import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/errors/network_info_errors/network_info_failures.dart';

abstract interface class NetworkInfo {
  TaskEither<Failure, bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this.connectionChecker);

  final InternetConnectionCheckerPlus connectionChecker;

  @override
  TaskEither<Failure, bool> isConnected() => TaskEither.tryCatch(
        () => connectionChecker.hasConnection,
        (error, stackTrace) => NetworkInfoFailure(
          message: 'Something went wrong while checking for connection.',
          stackTrace: stackTrace,
          rawException: error,
        ),
      );
}
