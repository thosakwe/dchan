import 'package:angel_migration/angel_migration.dart';
import 'package:angel_serialize/angel_serialize.dart';
import 'package:angel_orm/angel_orm.dart';
import 'attachment.dart';
part 'post.g.dart';

@serializable
@orm
abstract class _Post extends Model {
  @nullable
  String get text;

  @nullable
  String get userHash;

  @nullable
  int get inReplyTo;

  @hasMany
  List<Attachment> get attachments;
}
