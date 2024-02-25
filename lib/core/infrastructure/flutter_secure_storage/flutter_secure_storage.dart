import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flutter_secure_storage.g.dart';

@Riverpod(keepAlive: true)
class PecuniaFlutterSecureStorage extends _$PecuniaFlutterSecureStorage {
  @override
  Future<FlutterSecureStorage> build() async {
    return FlutterSecureStorage(aOptions: _getAndroidOptions());
  }
}

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
