// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// MigrationGenerator
// **************************************************************************

class PostMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('posts', (table) {
      table.serial('id')..primaryKey();
      table.varChar('text');
      table.varChar('user_hash');
      table.integer('in_reply_to');
      table.timeStamp('created_at');
      table.timeStamp('updated_at');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('posts');
  }
}

// **************************************************************************
// OrmGenerator
// **************************************************************************

class PostQuery extends Query<Post, PostQueryWhere> {
  PostQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = new PostQueryWhere(this);
    leftJoin(new AttachmentQuery(trampoline: trampoline), 'id', 'post_id',
        additionalFields: const [
          'size_in_bytes',
          'path',
          'filename',
          'post_id',
          'index',
          'content_type_string',
          'created_at',
          'updated_at'
        ]);
  }

  @override
  final PostQueryValues values = new PostQueryValues();

  PostQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'posts';
  }

  @override
  get fields {
    return const [
      'id',
      'text',
      'user_hash',
      'in_reply_to',
      'created_at',
      'updated_at'
    ];
  }

  @override
  PostQueryWhere get where {
    return _where;
  }

  @override
  PostQueryWhere newWhereClause() {
    return new PostQueryWhere(this);
  }

  static Post parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = new Post(
        id: row[0].toString(),
        text: (row[1] as String),
        userHash: (row[2] as String),
        inReplyTo: (row[3] as int),
        createdAt: (row[4] as DateTime),
        updatedAt: (row[5] as DateTime));
    if (row.length > 6) {
      model = model.copyWith(
          attachments: [AttachmentQuery.parseRow(row.skip(6).toList())]
              .where((x) => x != null)
              .toList());
    }
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }

  @override
  get(QueryExecutor executor) {
    return super.get(executor).then((result) {
      return result.fold<List<Post>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                attachments: List<Attachment>.from(l.attachments ?? [])
                  ..addAll(model.attachments ?? []));
        }
      });
    });
  }

  @override
  update(QueryExecutor executor) {
    return super.update(executor).then((result) {
      return result.fold<List<Post>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                attachments: List<Attachment>.from(l.attachments ?? [])
                  ..addAll(model.attachments ?? []));
        }
      });
    });
  }

  @override
  delete(QueryExecutor executor) {
    return super.delete(executor).then((result) {
      return result.fold<List<Post>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                attachments: List<Attachment>.from(l.attachments ?? [])
                  ..addAll(model.attachments ?? []));
        }
      });
    });
  }
}

class PostQueryWhere extends QueryWhere {
  PostQueryWhere(PostQuery query)
      : id = new NumericSqlExpressionBuilder<int>(query, 'id'),
        text = new StringSqlExpressionBuilder(query, 'text'),
        userHash = new StringSqlExpressionBuilder(query, 'user_hash'),
        inReplyTo = new NumericSqlExpressionBuilder<int>(query, 'in_reply_to'),
        createdAt = new DateTimeSqlExpressionBuilder(query, 'created_at'),
        updatedAt = new DateTimeSqlExpressionBuilder(query, 'updated_at');

  final NumericSqlExpressionBuilder<int> id;

  final StringSqlExpressionBuilder text;

  final StringSqlExpressionBuilder userHash;

  final NumericSqlExpressionBuilder<int> inReplyTo;

  final DateTimeSqlExpressionBuilder createdAt;

  final DateTimeSqlExpressionBuilder updatedAt;

  @override
  get expressionBuilders {
    return [id, text, userHash, inReplyTo, createdAt, updatedAt];
  }
}

class PostQueryValues extends MapQueryValues {
  @override
  get casts {
    return {};
  }

  int get id {
    return (values['id'] as int);
  }

  set id(int value) => values['id'] = value;
  String get text {
    return (values['text'] as String);
  }

  set text(String value) => values['text'] = value;
  String get userHash {
    return (values['user_hash'] as String);
  }

  set userHash(String value) => values['user_hash'] = value;
  int get inReplyTo {
    return (values['in_reply_to'] as int);
  }

  set inReplyTo(int value) => values['in_reply_to'] = value;
  DateTime get createdAt {
    return (values['created_at'] as DateTime);
  }

  set createdAt(DateTime value) => values['created_at'] = value;
  DateTime get updatedAt {
    return (values['updated_at'] as DateTime);
  }

  set updatedAt(DateTime value) => values['updated_at'] = value;
  void copyFrom(Post model) {
    text = model.text;
    userHash = model.userHash;
    inReplyTo = model.inReplyTo;
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
  }
}

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

@generatedSerializable
class Post extends _Post {
  Post(
      {this.id,
      this.text,
      this.userHash,
      this.inReplyTo,
      List<Attachment> attachments,
      this.createdAt,
      this.updatedAt})
      : this.attachments = new List.unmodifiable(attachments ?? []);

  @override
  final String id;

  @override
  final String text;

  @override
  final String userHash;

  @override
  final int inReplyTo;

  @override
  final List<Attachment> attachments;

  @override
  final DateTime createdAt;

  @override
  final DateTime updatedAt;

  Post copyWith(
      {String id,
      String text,
      String userHash,
      int inReplyTo,
      List<Attachment> attachments,
      DateTime createdAt,
      DateTime updatedAt}) {
    return new Post(
        id: id ?? this.id,
        text: text ?? this.text,
        userHash: userHash ?? this.userHash,
        inReplyTo: inReplyTo ?? this.inReplyTo,
        attachments: attachments ?? this.attachments,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  bool operator ==(other) {
    return other is _Post &&
        other.id == id &&
        other.text == text &&
        other.userHash == userHash &&
        other.inReplyTo == inReplyTo &&
        const ListEquality<Attachment>(const DefaultEquality<Attachment>())
            .equals(other.attachments, attachments) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return hashObjects(
        [id, text, userHash, inReplyTo, attachments, createdAt, updatedAt]);
  }

  Map<String, dynamic> toJson() {
    return PostSerializer.toMap(this);
  }
}

// **************************************************************************
// SerializerGenerator
// **************************************************************************

abstract class PostSerializer {
  static Post fromMap(Map map) {
    return new Post(
        id: map['id'] as String,
        text: map['text'] as String,
        userHash: map['user_hash'] as String,
        inReplyTo: map['in_reply_to'] as int,
        attachments: map['attachments'] is Iterable
            ? new List.unmodifiable(((map['attachments'] as Iterable)
                    .where((x) => x is Map) as Iterable<Map>)
                .map(AttachmentSerializer.fromMap))
            : null,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null);
  }

  static Map<String, dynamic> toMap(_Post model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'text': model.text,
      'user_hash': model.userHash,
      'in_reply_to': model.inReplyTo,
      'attachments': model.attachments
          ?.map((m) => AttachmentSerializer.toMap(m))
          ?.toList(),
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String()
    };
  }
}

abstract class PostFields {
  static const List<String> allFields = const <String>[
    id,
    text,
    userHash,
    inReplyTo,
    attachments,
    createdAt,
    updatedAt
  ];

  static const String id = 'id';

  static const String text = 'text';

  static const String userHash = 'user_hash';

  static const String inReplyTo = 'in_reply_to';

  static const String attachments = 'attachments';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';
}
