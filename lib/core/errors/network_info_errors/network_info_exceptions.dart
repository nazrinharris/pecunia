import '../exceptions.dart';

const String noInternetErrorCode = 'no-internet';

final class NoInternetException extends BaseException {
  const NoInternetException({
    String? errorCode,
    StackTrace? stackTrace,
  }) : super(
          message: "No internet connection detected. Please check your connection and try again.",
          errorCode: noInternetErrorCode,
          stackTrace: stackTrace,
        );
}
