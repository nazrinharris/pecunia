// ignore_for_file: strict_raw_type

import 'package:flutter_test/flutter_test.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';

/// Checks if the given [AuthFailure] has the expected [AuthErrorType] and [AuthAction]
Matcher isAuthFailure(AuthErrorType expectedErrorType) => _IsAuthFailure(expectedErrorType);

class _IsAuthFailure extends CustomMatcher {
  _IsAuthFailure(this.expectedErrorType)
      : super(
          'AuthFailure with $expectedErrorType',
          'errorType and action',
          '',
        );

  final AuthErrorType expectedErrorType;

  @override
  bool matches(dynamic item, Map matchState) {
    if (item == null) {
      matchState['null'] = 'was null';
      return false;
    }

    if (item is AuthFailure) {
      if (item.errorType == expectedErrorType) {
        return true;
      } else {
        matchState['authFailure'] = 'has errorType ${item.errorType}';
        return false;
      }
    } else {
      matchState['notAuthFailure'] = 'is not an AuthFailure';
      return false;
    }
  }

  @override
  Description describeMismatch(dynamic item, Description mismatchDescription, Map? matchState, bool verbose) {
    if (matchState == null) {
      return mismatchDescription;
    }

    if (matchState['null'] != null) {
      return mismatchDescription.addDescriptionOf(matchState['null'].toString());
    }

    if (matchState['authFailure'] != null) {
      return mismatchDescription.add(matchState['authFailure'].toString());
    }

    if (matchState['notAuthFailure'] != null) {
      return mismatchDescription.add(matchState['notAuthFailure'].toString());
    }

    return mismatchDescription;
  }
}
