// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// MigrationGenerator
// **************************************************************************

class AttachmentMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('attachments', (table) {
      table.serial('id')..primaryKey();
      table.integer('size_in_bytes');
      table.varChar('path');
      table.varChar('filename');
      table.integer('post_id');
      table.integer('index');
      table.varChar('content_type_string');
      table.timeStamp('created_at');
      table.timeStamp('updated_at');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('attachments');
  }
}

// **************************************************************************
// OrmGenerator
// **************************************************************************

class AttachmentQuery extends Query<Attachment, AttachmentQueryWhere> {
  AttachmentQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = new AttachmentQueryWhere(this);
  }

  @override
  final AttachmentQueryValues values = new AttachmentQueryValues();

  AttachmentQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'attachments';
  }

  @override
  get fields {
    return const [
      'id',
      'size_in_bytes',
      'path',
      'filename',
      'post_id',
      'index',
      'content_type_string',
      'created_at',
      'updated_at'
    ];
  }

  @override
  AttachmentQueryWhere get where {
    return _where;
  }

  @override
  AttachmentQueryWhere newWhereClause() {
    return new AttachmentQueryWhere(this);
  }

  static Attachment parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = new Attachment(
        id: row[0].toString(),
        sizeInBytes: (row[1] as int),
        path: (row[2] as String),
        filename: (row[3] as String),
        postId: (row[4] as int),
        index: (row[5] as int),
        contentTypeString: (row[6] as String),
        createdAt: (row[7] as DateTime),
        updatedAt: (row[8] as DateTime));
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }
}

class AttachmentQueryWhere extends QueryWhere {
  AttachmentQueryWhere(AttachmentQuery query)
      : id = new NumericSqlExpressionBuilder<int>(query, 'id'),
        sizeInBytes =
            new NumericSqlExpressionBuilder<int>(query, 'size_in_bytes'),
        path = new StringSqlExpressionBuilder(query, 'path'),
        filename = new StringSqlExpressionBuilder(query, 'filename'),
        postId = new NumericSqlExpressionBuilder<int>(query, 'post_id'),
        index = new NumericSqlExpressionBuilder<int>(query, 'index'),
        contentTypeString =
            new StringSqlExpressionBuilder(query, 'content_type_string'),
        createdAt = new DateTimeSqlExpressionBuilder(query, 'created_at'),
        updatedAt = new DateTimeSqlExpressionBuilder(query, 'updated_at');

  final NumericSqlExpressionBuilder<int> id;

  final NumericSqlExpressionBuilder<int> sizeInBytes;

  final StringSqlExpressionBuilder path;

  final StringSqlExpressionBuilder filename;

  final NumericSqlExpressionBuilder<int> postId;

  final NumericSqlExpressionBuilder<int> index;

  final StringSqlExpressionBuilder contentTypeString;

  final DateTimeSqlExpressionBuilder createdAt;

  final DateTimeSqlExpressionBuilder updatedAt;

  @override
  get expressionBuilders {
    return [
      id,
      sizeInBytes,
      path,
      filename,
      postId,
      index,
      contentTypeString,
      createdAt,
      updatedAt
    ];
  }
}

class AttachmentQueryValues extends MapQueryValues {
  @override
  get casts {
    return {};
  }

  int get id {
    return (values['id'] as int);
  }

  set id(int value) => values['id'] = value;
  int get sizeInBytes {
    return (values['size_in_bytes'] as int);
  }

  set sizeInBytes(int value) => values['size_in_bytes'] = value;
  String get path {
    return (values['path'] as String);
  }

  set path(String value) => values['path'] = value;
  String get filename {
    return (values['filename'] as String);
  }

  set filename(String value) => values['filename'] = value;
  int get postId {
    return (values['post_id'] as int);
  }

  set postId(int value) => values['post_id'] = value;
  int get index {
    return (values['index'] as int);
  }

  set index(int value) => values['index'] = value;
  String get contentTypeString {
    return (values['content_type_string'] as String);
  }

  set contentTypeString(String value) => values['content_type_string'] = value;
  DateTime get createdAt {
    return (values['created_at'] as DateTime);
  }

  set createdAt(DateTime value) => values['created_at'] = value;
  DateTime get updatedAt {
    return (values['updated_at'] as DateTime);
  }

  set updatedAt(DateTime value) => values['updated_at'] = value;
  void copyFrom(Attachment model) {
    sizeInBytes = model.sizeInBytes;
    path = model.path;
    filename = model.filename;
    postId = model.postId;
    index = model.index;
    contentTypeString = model.contentTypeString;
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
  }
}

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

@generatedSerializable
class Attachment extends _Attachment {
  Attachment(
      {this.id,
      this.sizeInBytes,
      this.path,
      this.filename,
      this.postId,
      this.index,
      this.contentTypeString,
      this.createdAt,
      this.updatedAt});

  @override
  final String id;

  @override
  final int sizeInBytes;

  @override
  final String path;

  @override
  final String filename;

  @override
  final int postId;

  @override
  final int index;

  @override
  final String contentTypeString;

  @override
  final DateTime createdAt;

  @override
  final DateTime updatedAt;

  Attachment copyWith(
      {String id,
      int sizeInBytes,
      String path,
      String filename,
      int postId,
      int index,
      String contentTypeString,
      DateTime createdAt,
      DateTime updatedAt}) {
    return new Attachment(
        id: id ?? this.id,
        sizeInBytes: sizeInBytes ?? this.sizeInBytes,
        path: path ?? this.path,
        filename: filename ?? this.filename,
        postId: postId ?? this.postId,
        index: index ?? this.index,
        contentTypeString: contentTypeString ?? this.contentTypeString,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  bool operator ==(other) {
    return other is _Attachment &&
        other.id == id &&
        other.sizeInBytes == sizeInBytes &&
        other.path == path &&
        other.filename == filename &&
        other.postId == postId &&
        other.index == index &&
        other.contentTypeString == contentTypeString &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return hashObjects([
      id,
      sizeInBytes,
      path,
      filename,
      postId,
      index,
      contentTypeString,
      createdAt,
      updatedAt
    ]);
  }

  Map<String, dynamic> toJson() {
    return AttachmentSerializer.toMap(this);
  }
}

// **************************************************************************
// SerializerGenerator
// **************************************************************************

abstract class AttachmentSerializer {
  static Attachment fromMap(Map map) {
    return new Attachment(
        id: map['id'] as String,
        sizeInBytes: map['size_in_bytes'] as int,
        path: map['path'] as String,
        filename: map['filename'] as String,
        postId: map['post_id'] as int,
        index: map['index'] as int,
        contentTypeString: map['content_type_string'] as String,
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

  static Map<String, dynamic> toMap(_Attachment model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'size_in_bytes': model.sizeInBytes,
      'path': model.path,
      'filename': model.filename,
      'post_id': model.postId,
      'index': model.index,
      'content_type_string': model.contentTypeString,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String()
    };
  }
}

abstract class AttachmentFields {
  static const List<String> allFields = const <String>[
    id,
    sizeInBytes,
    path,
    filename,
    postId,
    index,
    contentTypeString,
    createdAt,
    updatedAt
  ];

  static const String id = 'id';

  static const String sizeInBytes = 'size_in_bytes';

  static const String path = 'path';

  static const String filename = 'filename';

  static const String postId = 'post_id';

  static const String index = 'index';

  static const String contentTypeString = 'content_type_string';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';
}
