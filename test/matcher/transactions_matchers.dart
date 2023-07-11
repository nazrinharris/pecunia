// ignore_for_file: strict_raw_type

import 'package:flutter_test/flutter_test.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';

/// Checks if the given [TransactionsFailure] has the expected [TransactionsErrorType] and [TransactionsAction]
Matcher isTransactionsFailure(TransactionsErrorType expectedErrorType, TransactionsAction expectedAction) =>
    _IsTransactionsFailure(expectedErrorType, expectedAction);

class _IsTransactionsFailure extends CustomMatcher {
  _IsTransactionsFailure(this.expectedErrorType, this.expectedAction)
      : super(
          'TransactionsFailure with $expectedErrorType and $expectedAction',
          'errorType and action',
          '',
        );

  final TransactionsErrorType expectedErrorType;
  final TransactionsAction expectedAction;

  @override
  bool matches(dynamic item, Map matchState) {
    if (item == null) {
      matchState['null'] = 'was null';
      return false;
    }

    if (item is TransactionsFailure) {
      if (item.errorType == expectedErrorType && item.transactionsAction == expectedAction) {
        return true;
      } else {
        matchState['transactionsFailure'] =
            'has errorType ${item.errorType} and action ${item.transactionsAction}';
        return false;
      }
    } else {
      matchState['notTransactionsFailure'] = 'is not a TransactionsFailure';
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

    if (matchState['transactionsFailure'] != null) {
      return mismatchDescription.add(matchState['transactionsFailure'].toString());
    }

    if (matchState['notTransactionsFailure'] != null) {
      return mismatchDescription.add(matchState['notTransactionsFailure'].toString());
    }

    return mismatchDescription;
  }
}
