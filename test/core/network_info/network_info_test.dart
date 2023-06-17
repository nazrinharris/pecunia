import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pecunia/core/errors/network_info_errors/network_info_errors.dart';
import 'package:pecunia/core/infrastructure/network_info/network_info.dart';

class MockInternetConnectionCheckerPlus extends Mock implements InternetConnectionCheckerPlus {}

void main() {
  group('NetworkInfo -', () {
    group('isConnected', () {
      final connectionChecker = MockInternetConnectionCheckerPlus();

      setUpAll(() {
        // This is necessary in order to create a fake that can be used with a class that includes a non-nullable field.
        registerFallbackValue(StackTrace.empty);
      });

      test('returns NetworkInfoFailure when there is an error', () async {
        when(() => connectionChecker.hasConnection).thenThrow(Exception());

        final network = NetworkInfoImpl(connectionChecker);
        final result = await network.isConnected().run();

        expect(result.fold((l) => l, (r) => null), isA<NetworkInfoFailure>());
      });

      test('returns true when the connection is available', () async {
        when(() => connectionChecker.hasConnection).thenAnswer((_) async => true);

        final network = NetworkInfoImpl(connectionChecker);
        final result = await network.isConnected().run();

        expect(result.fold((l) => null, (r) => r), equals(true));
      });

      test('returns false when the connection is not available', () async {
        when(() => connectionChecker.hasConnection).thenAnswer((_) async => false);

        final network = NetworkInfoImpl(connectionChecker);
        final result = await network.isConnected().run();

        expect(result.fold((l) => null, (r) => r), equals(false));
      });
    });
  });
}
