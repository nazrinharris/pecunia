import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pecunia/core/errors/auth_errors/auth_failures.dart';
import 'package:pecunia/features/auth/data/auth_remote_ds.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/domain/entities/session.dart';

class MockAuthRemoteDS extends Mock implements AuthRemoteDS {}

void main() {
  late AuthRepoImpl authRepo;
  late MockAuthRemoteDS mockAuthRemoteDS;

  setUpAll(() {
    registerFallbackValue(const Session(isValid: true));
  });

  setUp(() {
    mockAuthRemoteDS = MockAuthRemoteDS();
    authRepo = AuthRepoImpl(authRemoteDS: mockAuthRemoteDS);
  });

  group('AuthRepoImpl -', () {
    group('loginWithPassword()', () {
      // Arrange
      const testUsername = 'test';
      const testUid = '12345';
      const testEmail = 'test@test.com';
      const testPassword = 'password';
      final testDateCreated = DateTime.now();
      const testSession = Session(isValid: true);
      final testUserDto = PecuniaUserDTO(
        username: testUsername,
        uid: testUid,
        email: testEmail,
        dateCreated: testDateCreated,
      );
      final testUser = PecuniaUser.fromDTO(testUserDto);

      test('returns a PecuniaUser when the call to authRemoteDS is successful', () async {
        when(
          () => mockAuthRemoteDS.loginWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
            currentSession: any(named: 'currentSession'),
          ),
        ).thenAnswer(
          (_) => TaskEither.right((newSession: testSession, pecuniaUserDTO: testUserDto)),
        );

        final result = await authRepo
            .loginWithPassword(
              email: testEmail,
              password: testPassword,
              currentSession: testSession,
            )
            .run();

        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Operation failed with error: $l'),
          (r) {
            expect(r.pecuniaUser, equals(testUser));
            expect(r.session, equals(testSession));
          },
        );
      });

      test('returns a Failure when the call to authRemoteDS is unsuccessful', () async {
        when(
          () => mockAuthRemoteDS.loginWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
            currentSession: any(named: 'currentSession'),
          ),
        ).thenAnswer(
          (_) => TaskEither.left(AuthFailure(message: 'Error', stackTrace: StackTrace.current)),
        );

        final result = await authRepo
            .loginWithPassword(
              email: testEmail,
              password: testPassword,
              currentSession: testSession,
            )
            .run();

        expect(result.isLeft(), isTrue);
        result.fold(
          (l) => expect(l, isA<AuthFailure>()),
          (r) => fail('Operation succeeded with value: $r'),
        );
      });
    });

    group('registerWithPassword()', () {
      const testUsername = 'test';
      const testUid = '12345';
      const testEmail = 'test@test.com';
      const testPassword = 'password';
      final testDateCreated = DateTime.now();
      const testSession = Session(isValid: true);
      final testUserDto = PecuniaUserDTO(
        username: testUsername,
        uid: testUid,
        email: testEmail,
        dateCreated: testDateCreated,
      );
      final testUser = PecuniaUser.fromDTO(testUserDto);

      test('returns a PecuniaUser when the call to authRemoteDS is successful', () async {
        when(
          () => mockAuthRemoteDS.registerWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
            username: any(named: 'username'),
            currentSession: any(named: 'currentSession'),
          ),
        ).thenAnswer(
          (_) => TaskEither.right((newSession: testSession, pecuniaUserDTO: testUserDto)),
        );

        final result = await authRepo
            .registerWithPassword(
              email: testEmail,
              password: testPassword,
              username: testUsername,
              currentSession: testSession,
            )
            .run();

        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Operation failed with error: $l'),
          (r) {
            expect(r.pecuniaUser, equals(testUser));
            expect(r.session, equals(testSession));
          },
        );
      });

      test('returns a Failure when the call to authRemoteDS is unsuccessful', () async {
        when(
          () => mockAuthRemoteDS.registerWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
            username: any(named: 'username'),
            currentSession: any(named: 'currentSession'),
          ),
        ).thenAnswer(
          (_) => TaskEither.left(AuthFailure(message: 'Error', stackTrace: StackTrace.current)),
        );

        final result = await authRepo
            .registerWithPassword(
              email: testEmail,
              password: testPassword,
              username: testUsername,
              currentSession: testSession,
            )
            .run();

        expect(result.isLeft(), isTrue);
        result.fold(
          (l) => expect(l, isA<AuthFailure>()),
          (r) => fail('Operation succeeded with value: $r'),
        );
      });
    });

    group('logout()', () {
      const testSession = Session(isValid: true);
      test('returns an updated session when logged out succesfully', () async {
        when(() => mockAuthRemoteDS.logout(testSession))
            .thenAnswer((_) => TaskEither.right(testSession.copyWith(isValid: false)));

        final result = await authRepo.logout(testSession).run();

        expect(result.isRight(), isTrue);
      });

      test('returns a Failure when the call to authRemoteDS is unsuccessful', () async {
        when(() => mockAuthRemoteDS.logout(testSession)).thenAnswer(
          (_) => TaskEither.left(AuthFailure(message: 'Error', stackTrace: StackTrace.current)),
        );

        final result = await authRepo.logout(testSession).run();

        expect(result.isLeft(), isTrue);
        result.fold(
          (l) => expect(l, isA<AuthFailure>()),
          (r) => fail('Operation succeeded with value: $r'),
        );
      });
    });
  });
}
