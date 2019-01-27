import 'package:dchan/src/config/plugins/orm.dart';
import 'package:dchan/models.dart';
import 'package:angel_configuration/angel_configuration.dart';
import 'package:angel_migration_runner/angel_migration_runner.dart';
import 'package:angel_migration_runner/postgres.dart';
import 'package:file/local.dart';

main(List<String> args) async {
  var fs = LocalFileSystem();
  var configuration = await loadStandaloneConfiguration(fs);
  var connection = await connectToPostgres(configuration);
  var migrationRunner = PostgresMigrationRunner(connection, migrations: [
    PostMigration(),
    AttachmentMigration(),
  ]);
  return await runMigrations(migrationRunner, args);
}
