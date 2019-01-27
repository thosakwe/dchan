import 'package:angel_migration/angel_migration.dart';
import 'package:angel_serialize/angel_serialize.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kilobyte/kilobyte.dart';
part 'attachment.g.dart';

@serializable
@orm
abstract class _Attachment extends Model {
  int get postId;

  int get index;

  int sizeInBytes;

  Size get size => Size(bytes: sizeInBytes);

  String path;

  String filename;

  String get contentTypeString;

  MediaType get contentType => MediaType.parse(contentTypeString);
}
