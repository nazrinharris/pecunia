import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_saved_databases.g.dart';

@riverpod
Future<List<String>> getSavedDatabases(GetSavedDatabasesRef ref) async {
  return getUIDsFromPaths(await listDbFilePaths()).getOrElse(() => []);
}
