import '../failures.dart';

base class NetworkInfoFailure extends Failure {
  const NetworkInfoFailure({
    required super.message,
    required super.stackTrace,
    super.rawException,
  });
}

final class NoInternetFailure extends NetworkInfoFailure {
  const NoInternetFailure({
    required super.stackTrace,
    super.rawException,
  }) : super(
          message: "No internet connection detected. Please check your connection and try again.",
        );
}
