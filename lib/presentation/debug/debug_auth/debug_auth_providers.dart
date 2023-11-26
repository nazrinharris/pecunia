import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/infrastructure/flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pecunia/core/util/pecunia_crypto.dart';
import 'package:pecunia/features/auth/data/auth_local_ds.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/domain/entities/session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_auth_providers.g.dart';

@riverpod
class NavigateToDebugLocalDB extends _$NavigateToDebugLocalDB {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> navigateToDebugLocalDB() async {
    state = const AsyncValue.loading();
    (await ref.read(authRepoProvider).getLoggedInUser().run()).fold(
      (l) {
        state = AsyncValue.error(l, l.stackTrace);
      },
      (r) {
        state = const AsyncValue.data(true);
      },
    );
  }
}

@riverpod
class DebugLocalLoginWithEmailAndPassword extends _$DebugLocalLoginWithEmailAndPassword {
  @override
  FutureOr<Option<PecuniaUser>> build() {
    return const Option.none();
  }

  Future<void> debugLoginWithEmailAndPassword(String email, String password) async {
    state = const AsyncValue.loading();

    final failureOrPecuniaUserAndSession = await ref
        .read(authRepoProvider)
        .localLoginWithEmailAndPassword(
          email: email,
          password: password,
        )
        .run();

    return failureOrPecuniaUserAndSession.fold(
      (failure) => state = AsyncValue.error(failure, failure.stackTrace),
      (r) => state = AsyncValue.data(Option.of(r.user)),
    );
  }
}

@riverpod
class DebugLocalRegisterWithEmailAndPassword extends _$DebugLocalRegisterWithEmailAndPassword {
  @override
  FutureOr<Option<PecuniaUser>> build() {
    return const Option.none();
  }

  Future<void> debugRegisterWithEmailAndPassword(String username, String email, String password) async {
    state = const AsyncValue.loading();

    final failureOrPecuniaUserAndSession = await ref
        .read(authRepoProvider)
        .localRegisterWithEmailAndPassword(
          username: username,
          email: email,
          password: password,
        )
        .run();

    return failureOrPecuniaUserAndSession.fold(
      (failure) => state = AsyncValue.error(failure, failure.stackTrace),
      (r) => state = AsyncValue.data(Option.of(r.user)),
    );
  }
}

@riverpod
Future<List<PecuniaUser>> debugGetLocalUsers(DebugGetLocalUsersRef ref) async {
  final storage = ref.read(pecuniaFlutterSecureStorageProvider).requireValue;

  final allRead = await storage.readAll();
  final uidKeys = allRead.keys.where((key) => key.contains('pecunia_user_uid_'));
  debugPrint('UID Amount: ${uidKeys.length}');
  for (final element in uidKeys) {
    debugPrint(element);
  }

  final userList = <PecuniaUser>[];
  for (final uidKey in uidKeys) {
    final email = uidKey.split('pecunia_user_uid_')[1];
    final uid = await storage.read(key: kPecuniaUserUidKey(email));
    final userJson = await storage.read(key: kPecuniaUserKey(uid!));
    debugPrint('Attempting to read from key: ${kPecuniaUserKey(uid)}}');
    debugPrint(userJson);
    final user = PecuniaUser.fromJson(jsonDecode(userJson!) as Map<String, dynamic>);
    userList.add(user);
  }

  return userList;
}

@riverpod
Future<List<Session>> debugGetAllSessions(DebugGetAllSessionsRef ref) async {
  final sessionManager = AuthLocalSessionManager(ref.read(pecuniaFlutterSecureStorageProvider).requireValue);
  final failureOrSessions = await sessionManager.getAllSessions().run();

  return failureOrSessions.fold(
    (failure) => Future.error(failure, failure.stackTrace),
    (r) => r,
  );
}

@riverpod
Future<Option<Session>> debugGetActiveSession(DebugGetActiveSessionRef ref) async {
  final sessionManager = AuthLocalSessionManager(ref.read(pecuniaFlutterSecureStorageProvider).requireValue);
  final failureOrSession = await sessionManager.getActiveSession().run();

  return failureOrSession.fold(
    (failure) => Future.error(failure, failure.stackTrace),
    (r) => r,
  );
}
