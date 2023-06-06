// imports
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pecunia/core/errors/auth_errors/auth_failures.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/errors/network_info_errors/network_info_failures.dart';
import 'package:pecunia/core/network_info/network_info.dart';
import 'package:pecunia/features/auth/data/auth_remote_ds.dart';
import 'package:pecunia/features/auth/domain/models/pecunia_user.dart';
import 'package:pecunia/features/auth/domain/models/session.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as s;

// Mock classes
class MockSupabaseClient extends Mock implements s.SupabaseClient {}

class MockAuthResponse extends Mock implements s.AuthResponse {}

class MockUser extends Mock implements s.User {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockGoTrueClient extends Mock implements s.GoTrueClient {}

void main() {
  group('AuthRemoteDS -', () {
    group('loginWithPassword()', () {
      final supabaseClient = MockSupabaseClient();
      final auth = MockGoTrueClient();
      final authResponse = MockAuthResponse();
      final user = MockUser();
      final network = MockNetworkInfo();

      setUpAll(() {
        registerFallbackValue(StackTrace.empty);
        when(() => supabaseClient.auth).thenReturn(auth);
      });

      test('returns NoInternetFailure when there is no internet connection', () async {
        when(network.isConnected).thenAnswer((_) => TaskEither<Failure, bool>.right(false));

        final authRemoteDS = SupabaseAuthRemoteDS(supabaseClient, network);
        final result = await authRemoteDS
            .loginWithPassword(
              email: 'email',
              password: 'password',
              currentSession: const Session(isValid: false),
            )
            .run();

        expect(result.fold((l) => l, (r) => null), isA<NoInternetFailure>());
      });

      test('returns LoginFailure when there is an error during authentication', () async {
        when(network.isConnected).thenAnswer((_) => TaskEither<Failure, bool>.right(true));
        when(() => auth.signInWithPassword(email: 'email', password: 'password'))
            .thenThrow(const s.AuthException('Error'));

        final authRemoteDS = SupabaseAuthRemoteDS(supabaseClient, network);
        final result = await authRemoteDS
            .loginWithPassword(
              email: 'email',
              password: 'password',
              currentSession: const Session(isValid: false),
            )
            .run();

        expect(result.fold((l) => l, (r) => null), isA<LoginFailure>());
      });

      test('returns PecuniaUserDTO and new Session when authentication is successful', () async {
        when(network.isConnected).thenAnswer((_) => TaskEither<Failure, bool>.right(true));
        when(() => auth.signInWithPassword(email: 'email', password: 'password'))
            .thenAnswer((_) async => authResponse);
        when(() => authResponse.user).thenReturn(user);
        when(() => user.id).thenReturn('id');
        when(() => user.appMetadata).thenReturn({'username': 'username'});
        when(() => user.createdAt).thenReturn('2023-06-06T14:34:34Z');

        final authRemoteDS = SupabaseAuthRemoteDS(supabaseClient, network);
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
  });
}
