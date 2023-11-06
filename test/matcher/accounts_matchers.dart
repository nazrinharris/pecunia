// ignore_for_file: strict_raw_type

import 'package:flutter_test/flutter_test.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';

/// Checks if the given [AccountsFailure] has the expected [AccountsErrorType]
Matcher isAccountsFailure(AccountsErrorType expectedErrorType) => _IsAccountsFailure(expectedErrorType);

class _IsAccountsFailure extends CustomMatcher {
  _IsAccountsFailure(this.expectedErrorType)
      : super(
          'AccountFailure with $expectedErrorType',
          'errorType and action',
          '',
        );

  final AccountsErrorType expectedErrorType;

  @override
  bool matches(dynamic item, Map matchState) {
    if (item == null) {
      matchState['null'] = 'was null';
      return false;
    }

    if (item is AccountsFailure) {
      if (item.errorType == expectedErrorType) {
        return true;
      } else {
        matchState['accountsFailure'] = 'has errorType ${item.errorType}';
        return false;
      }
    } else {
      matchState['notAccountsFailure'] = 'is not an AccountsFailure';
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

    if (matchState['accountsFailure'] != null) {
      return mismatchDescription.add(matchState['accountsFailure'].toString());
    }

    if (matchState['notAccountsFailure'] != null) {
      return mismatchDescription.add(matchState['notAccountsFailure'].toString());
    }

    return mismatchDescription;
  }
}
