import 'package:pecunia/core/errors/exceptions.dart';

const String noInternetErrorCode = 'no-internet';

final class NoInternetException extends BaseException {
  const NoInternetException({
    super.stackTrace,
  }) : super(
          message: 'No internet connection detected. Please check your connection and try again.',
          errorCode: noInternetErrorCode,
        );
}
