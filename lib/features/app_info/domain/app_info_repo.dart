import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/app_info_errors/app_info_errors.dart';
import 'package:pecunia/features/app_info/data/app_info_local_ds.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_info_repo.g.dart';

@riverpod
AppInfoRepo appInfoRepo(AppInfoRepoRef ref) => AppInfoRepo(ref.watch(appInfoLocalDSProvider));

class AppInfoRepo {
  AppInfoRepo(this.appInfoLocalDS);

  final AppInfoLocalDS appInfoLocalDS;

  TaskEither<AppInfoFailure, Option<bool>> getIsFirstOpen() {
    return appInfoLocalDS.getIsFirstOpen();
  }

  TaskEither<AppInfoFailure, Unit> setIsFirstOpen(bool value) {
    return appInfoLocalDS.setIsFirstOpen(value);
  }
}
