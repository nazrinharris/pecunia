import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pecunia/core/errors/network_info_errors/network_info_errors.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_info.g.dart';

@Riverpod(keepAlive: true)
InternetConnectionCheckerPlus internetConnectionCheckerPlus(InternetConnectionCheckerPlusRef ref) {
  return InternetConnectionCheckerPlus();
}

@riverpod
NetworkInfo networkInfo(NetworkInfoRef ref) {
  return NetworkInfoImpl(
    ref.watch(internetConnectionCheckerPlusProvider),
  );
}

abstract interface class NetworkInfo {
  TaskEither<NetworkInfoFailure, bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this.connectionChecker);

  final InternetConnectionCheckerPlus connectionChecker;

  @override
  TaskEither<NetworkInfoFailure, bool> isConnected() => TaskEither.tryCatch(
        () => connectionChecker.hasConnection,
        (error, stackTrace) => NetworkInfoFailure(
          stackTrace: stackTrace,
          rawException: error,
        ),
      );
}
