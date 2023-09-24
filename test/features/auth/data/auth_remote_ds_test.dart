// imports
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/errors/network_info_errors/network_info_errors.dart';
import 'package:pecunia/core/infrastructure/network_info/network_info.dart';
import 'package:pecunia/features/auth/data/auth_remote_ds.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/domain/entities/session.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as s;

import '../../../matcher/auth_matchers.dart';

// Mock classes
class MockSupabaseClient extends Mock implements s.SupabaseClient {}

class MockAuthResponse extends Mock implements s.AuthResponse {}

class MockUser extends Mock implements s.User {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockGoTrueClient extends Mock implements s.GoTrueClient {}

void main() {
  group('AuthRemoteDS -', () {
    final supabaseClient = MockSupabaseClient();
    final auth = MockGoTrueClient();
    final authResponse = MockAuthResponse();
    final user = MockUser();
    final network = MockNetworkInfo();

    final authRemoteDS = SupabaseAuthRemoteDS(supabaseClient, network, AuthRemoteDSHelper());

    setUpAll(() {
      registerFallbackValue(StackTrace.empty);
      when(() => supabaseClient.auth).thenReturn(auth);
    });

    group('loginWithPassword()', () {
      setUpAll(() {});

      test(
          'returns [AuthFailure] with [AuthErrorType.noInternet] and [AuthAction.login] when there is no internet connection',
          () async {
        // Arrange
        when(network.isConnected).thenAnswer((_) => TaskEither<NetworkInfoFailure, bool>.right(false));

        // Act
        final result = await authRemoteDS
            .loginWithPassword(
              email: 'email',
              password: 'password',
              currentSession: const Session(isValid: false),
            )
            .run();

        // Assert
        expect(result.fold((l) => l, (r) => null), isAuthFailure(AuthErrorType.noInternet));
      });

      test(
          'returns [AuthFailure] with [AuthErrorType.unknown] and [AuthAction.login] when [Supabase] throws an error',
          () async {
        when(network.isConnected).thenAnswer((_) => TaskEither<NetworkInfoFailure, bool>.right(true));
        when(() => auth.signInWithPassword(email: 'email', password: 'password'))
            .thenThrow(const s.AuthException('Error'));

        final result = await authRemoteDS
            .loginWithPassword(
              email: 'email',
              password: 'password',
              currentSession: const Session(isValid: false),
            )
            .run();

        expect(result.fold((l) => l, (r) => null), isAuthFailure(AuthErrorType.unknown));
      });

      test('returns [PecuniaUserDTO] and new [Session] when authentication is successful', () async {
        when(network.isConnected).thenAnswer((_) => TaskEither<NetworkInfoFailure, bool>.right(true));
        when(() => auth.signInWithPassword(email: 'email', password: 'password'))
            .thenAnswer((_) async => authResponse);
        when(() => authResponse.user).thenReturn(user);
        when(() => user.id).thenReturn('id');
        when(() => user.userMetadata).thenReturn({'username': 'username'});
        when(() => user.createdAt).thenReturn('2023-06-06T14:34:34Z');

        final result = await authRemoteDS
            .loginWithPassword(
              email: 'email',
              password: 'password',
              currentSession: const Session(isValid: false),
            )
            .run();

        result.fold((failure) => fail('Operation failed with error: $failure'), (record) {
          expect(record.pecuniaUserDTO, isA<PecuniaUserDTO>());
          expect(record.newSession, equals(const Session(isValid: true)));
        });
      });
    });

    group('registerWithPassword()', () {
      test(
          'returns [AuthFailure] with [AuthErrorType.noInternet] and [AuthAction.register] when there is no internet connection',
          () async {
        when(network.isConnected).thenAnswer((_) => TaskEither<NetworkInfoFailure, bool>.right(false));

        final result = await authRemoteDS
            .registerWithPassword(
              username: 'username',
              email: 'email',
              password: 'password',
              currentSession: const Session(isValid: false),
            )
            .run();

        expect(result.fold((l) => l, (r) => null), isAuthFailure(AuthErrorType.noInternet));
      });

      test(
          'returns [AuthFailure] with [AuthErrorType.unknown] and [AuthAction.register] when [Supabase] throws an error',
          () async {
        when(network.isConnected).thenAnswer((_) => TaskEither<NetworkInfoFailure, bool>.right(true));
        when(
          () => auth.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            data: any(named: 'data'),
          ),
        ).thenThrow(const s.AuthException('Error'));

        final result = await authRemoteDS
            .registerWithPassword(
              username: 'username',
              email: 'email',
              password: 'password',
              currentSession: const Session(isValid: false),
            )
            .run();

        expect(result.fold((l) => l, (r) => null), isAuthFailure(AuthErrorType.unknown));
      });

      test('returns [PecuniaUserDTO] and new [Session] when registration is successful', () async {
        when(network.isConnected).thenAnswer((_) => TaskEither<NetworkInfoFailure, bool>.right(true));
        when(
          () => auth.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            data: any(named: 'data'),
          ),
        ).thenAnswer((_) async => authResponse);
        when(() => authResponse.user).thenReturn(user);
        when(() => user.id).thenReturn('id');
        when(() => user.userMetadata).thenReturn({'username': 'username'});
        when(() => user.createdAt).thenReturn('2023-06-06T14:34:34Z');

        final result = await authRemoteDS
            .registerWithPassword(
              username: 'username',
              email: 'email',
              password: 'password',
              currentSession: const Session(isValid: false),
            )
            .run();

        result.fold((failure) => fail('Operation failed with error: $failure'), (record) {
          expect(record.pecuniaUserDTO, isA<PecuniaUserDTO>());
          expect(record.newSession, equals(const Session(isValid: true)));
        });
      });
    });

    group('logout()', () {
      test(
          'returns [AuthFailure] with [AuthErrorType.noInternet] and [AuthAction.logout] when there is no internet connection',
          () async {
        when(network.isConnected).thenAnswer((_) => TaskEither<NetworkInfoFailure, bool>.right(false));

        final result = await authRemoteDS.logout(const Session(isValid: true)).run();

        expect(result.fold((l) => l, (r) => null), isAuthFailure(AuthErrorType.noInternet));
      });

      test('returns updated [Session] when succesfull logout', () async {
        when(network.isConnected).thenAnswer((_) => TaskEither<NetworkInfoFailure, bool>.right(true));
        when(auth.signOut).thenAnswer((_) async {});

        final result = await authRemoteDS.logout(const Session(isValid: true)).run();

        result.fold((failure) => fail('Operation failed with error: $failure'), (session) {
          expect(session, equals(const Session(isValid: false)));
        });
      });

      test(
          'returns [AuthFailure] with [AuthErrorType.unknown] and [AuthAction.logout] when [Supabase] throws an error',
          () async {
        when(network.isConnected).thenAnswer((_) => TaskEither<NetworkInfoFailure, bool>.right(true));
        when(auth.signOut).thenThrow(const s.AuthException('Error'));

        final result = await authRemoteDS.logout(const Session(isValid: true)).run();

        expect(result.fold((l) => l, (r) => null), isAuthFailure(AuthErrorType.unknown));
      });
    });
  });
}
