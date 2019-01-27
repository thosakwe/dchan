import 'dart:convert';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:angel_static/angel_static.dart';
import 'package:angel_validate/server.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dchan/models.dart';
import 'package:file/file.dart';
import 'package:markdown/markdown.dart' as markdown;
import 'package:path/path.dart' as p;

AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) async {
    var executor = app.container.make<QueryExecutor>();
    var webDir = fileSystem.directory('web');
    var uploadsDir = webDir.childDirectory('uploads');

    app.get('/', (req, res) async {
      var query = PostQuery()..where.inReplyTo.equals(-1);
      var posts = await query.get(executor).then((posts) {
        return posts.map((p) {
          // If there is no text, add some filler text, ex. [image.jpg], [2.png]
          if (p.text.isEmpty) {
            return p.copyWith(
              text: '${p.attachments.length} File(s) - [' +
                  p.attachments.map((a) => a.filename).join(', ') +
                  ']',
            );
          } else {
            return p;
          }
        });
      });
      await res.render('index', {'posts': posts});
    });

    app.get(
      '/compose',
      chain([
        autoParseQuery(['in_reply_to']),
        validateQuery(Validator({
          'in_reply_to': [isInt, isPositive]
        })),
        (req, res) {
          var params = Map<String, dynamic>.from(req.queryParameters);
          params
            ..['title'] = 'Compose'
            ..['meta'] = json.encode(req.queryParameters);
          return res.render('compose', params);
        },
      ]),
    );

    app.post(
      '/compose',
      (req, res) async {
        var params = <String, dynamic>{'title': 'Compose'};

        try {
          var body = await req.parseBody().then((_) => req.bodyAsMap);
          body = autoParse(body, ['in_reply_to']);
          var validator = Validator({
            'meta': isString,
            'in_reply_to': [isInt, isPositive],
            'text': isString,
            'user_hash': isString
          });
          validator.enforce(body);

          // Try to persist data sent to the client.
          try {
            params.addAll(((json.decode(body['meta'] as String ?? '{}'))
                as Map<String, dynamic>)
              ..remove('title'));
          } catch (_) {}

          // If there is no text, there must be at least one file.
          var text = body['text']?.toString()?.trim() ?? '';
          if (text.isEmpty && req.uploadedFiles.isEmpty) {
            throw FormatException(
                'Either a title or uploaded files are required.');
          }

          // If this is a reply, the referenced post must exist.
          var inReplyTo = int.tryParse(body['in_reply_to']?.toString() ?? '-1');
          if (inReplyTo > -1) {
            var query = PostQuery()..where.id.equals(inReplyTo);
            var reference = await query.get(executor);

            if (reference == null) {
              params.remove('in_reply_to');
              throw FormatException(
                  'The referenced post does not exist. Creating a new thread instead.');
            }
          }

          // Apply the user's hash identifier, if they have supplied one.
          var userHash = body['user_hash']?.toString()?.trim();
          if (userHash?.isNotEmpty == true) {
            var hashBytes = sha256.convert(utf8.encode(userHash)).bytes;
            userHash = hex.encode(hashBytes);
          } else {
            userHash = null;
          }

          // Create the post.
          var now = DateTime.now();
          var query = PostQuery();
          query.values
            ..inReplyTo = inReplyTo
            ..text = text
            ..userHash = userHash
            ..createdAt = now
            ..updatedAt = now;
          var post = await query.insert(executor);

          // Upload the attachments, if any.
          int i = 0;
          for (var attachment in req.uploadedFiles) {
            var file = uploadsDir.childDirectory(post.id).childFile(
                p.setExtension(
                    i.toString(),
                    attachment.filename == null
                        ? ''
                        : p.extension(attachment.filename)));
            await file.create(recursive: true);
            await attachment.data.pipe(file.openWrite());

            var now = DateTime.now();
            var query = AttachmentQuery();
            query.values
              ..postId = post.idAsInt
              ..contentTypeString = attachment.contentType.toString()
              ..filename = attachment.filename ?? 'unknown'
              ..index = i++
              ..path = p.relative(file.path, from: webDir.path)
              ..sizeInBytes = await file.length()
              ..createdAt = now
              ..updatedAt = now;
            await query.insert(executor);
          }

          // Send the user to either the new thread, or their comment (using URL fragment)
          if (post.inReplyTo == -1) {
            var url = Uri(path: '/post/${post.id}');
            res.redirect(url);
          } else {
            var url = Uri(
              path: '/post/${post.inReplyTo}',
              fragment: 'comment-${post.id}',
            );
            res.redirect(url);
          }
        } on AngelHttpException catch (e) {
          if (e.statusCode != 400) rethrow;
          params['error'] = e.errors.first;
          res.statusCode = 400;
          return res.render('compose', params);
        } on FormatException catch (e) {
          params['error'] = e.message;
          res.statusCode = 400;
          return res.render('compose', params);
        }
      },
    );

    app.get('/post/int:id', (req, res) async {
      var id = req.params['id'] as int;
      var query = PostQuery()..where.id.equals(id);
      var post = await query.getOne(executor);
      if (post == null) throw AngelHttpException.notFound();
      List<Post> comments;

      if (post.inReplyTo != -1)
        comments = [];
      else {
        var query = PostQuery()..where.inReplyTo.equals(post.idAsInt);
        comments = await query.get(executor);
      }

      await res.render('post', {
        'comments': comments,
        'post': post,
        'md': (String s) {
          return markdown.markdownToHtml(s,
              extensionSet: markdown.ExtensionSet.gitHubWeb);
        }
      });
    });

    app.get('/user/:hash', (req, res) async {
      var hash = req.params['hash'] as String;
      var query = PostQuery()..where.userHash.equals(hash);
      var posts = await query.get(executor).then((posts) {
        return posts.map((p) {
          // If there is no text, add some filler text, ex. [image.jpg], [2.png]
          if (p.text.isEmpty) {
            return p.copyWith(
              text: '${p.attachments.length} File(s) - [' +
                  p.attachments.map((a) => a.filename).join(', ') +
                  ']',
            );
          } else {
            return p;
          }
        });
      });
      await res.render('index', {'posts': posts, 'heading': 'User: $hash'});
    });

    // Serve the assets
    var vDir = CachingVirtualDirectory(app, fileSystem, source: webDir);
    app.fallback(vDir.handleRequest);

    app.fallback((req, res) => throw AngelHttpException.notFound(
        message: 'The requested path does not exist.'));

    var oldErrorHandler = app.errorHandler;
    app.errorHandler = (e, req, res) async {
      if (!req.accepts('text/html', strict: true))
        return await oldErrorHandler(e, req, res);
      else {
        return await res.render('error', {'message': e.message});
      }
    };
  };
}
