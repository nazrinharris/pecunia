// ignore_for_file: strict_raw_type

import 'package:flutter_test/flutter_test.dart';
import 'package:pecunia/core/errors/network_info_errors/network_info_errors.dart';

/// Checks if the given [NetworkInfoFailure] has the expected [NetworkInfoErrorType]
Matcher isNetworkInfoFailureType(NetworkInfoErrorType expectedErrorType) =>
    _IsNetworkInfoFailure(expectedErrorType);

class _IsNetworkInfoFailure extends CustomMatcher {
  _IsNetworkInfoFailure(this.expectedErrorType)
      : super('NetworkInfoFailure with errorType $expectedErrorType', 'errorType', expectedErrorType);

  final NetworkInfoErrorType expectedErrorType;

  @override
  bool matches(dynamic item, Map matchState) {
    if (item is NetworkInfoFailure) {
      return item.errorType == expectedErrorType;
    }
    return false;
  }
}
