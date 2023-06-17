import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pecunia/core/errors/failures.dart';

part 'network_info_errors.freezed.dart';

/// ****************************************************************
/// * NetworkInfo Error Definitions
/// * [NetworkInfoErrorType] - Enum of all possible network info errors
/// ****************************************************************

const defaultUnknownNetworkInfoErrorCode = 'unknown-network-info-error';
const defaultUnknownNetworkInfoErrorMessage = 'Something went wrong while checking for connection.';

enum NetworkInfoErrorType {
  unknownNetworkInfoError(defaultUnknownNetworkInfoErrorCode, defaultUnknownNetworkInfoErrorMessage);

  const NetworkInfoErrorType(this.errorCode, this.errorMessage);

  final String errorCode;
  final String errorMessage;
}

/// ****************************************************************
/// * NetworkInfoFailure
/// ****************************************************************

@freezed
class NetworkInfoFailure with _$NetworkInfoFailure implements Failure {
  const factory NetworkInfoFailure({
    required StackTrace stackTrace,
    @Default(defaultUnknownNetworkInfoErrorMessage) String message,
    @Default(NetworkInfoErrorType.unknownNetworkInfoError) NetworkInfoErrorType errorType,
    Object? rawException,
  }) = _NetworkInfoFailure;

  const NetworkInfoFailure._();

  @override
  List<Object> get props => [message, stackTrace];

  @override
  bool? get stringify => true;
}
