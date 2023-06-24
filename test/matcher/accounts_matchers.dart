// ignore_for_file: strict_raw_type

import 'package:flutter_test/flutter_test.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';

/// Checks if the given [AccountsFailure] has the expected [AccountsErrorType] and [AccountsAction]
Matcher isAccountsFailure(AccountsErrorType expectedErrorType, AccountsAction expectedAction) =>
    _IsAccountsFailure(expectedErrorType, expectedAction);

class _IsAccountsFailure extends CustomMatcher {
  _IsAccountsFailure(this.expectedErrorType, this.expectedAction)
      : super(
          'AccountFailure with $expectedErrorType and $expectedAction',
          'errorType and action',
          '',
        );

  final AccountsErrorType expectedErrorType;
  final AccountsAction expectedAction;

  @override
  bool matches(dynamic item, Map matchState) {
    if (item == null) {
      matchState['null'] = 'was null';
      return false;
    }

    if (item is AccountsFailure) {
      if (item.errorType == expectedErrorType && item.accountsAction == expectedAction) {
        return true;
      } else {
        matchState['accountsFailure'] = 'has errorType ${item.errorType} and action ${item.accountsAction}';
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
