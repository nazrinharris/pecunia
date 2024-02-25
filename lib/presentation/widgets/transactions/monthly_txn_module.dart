import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/core/util/extensions.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/get_txns_over_period.dart';

class MonthlyTxnModule extends ConsumerWidget {
  const MonthlyTxnModule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final start = DateTime(DateTime.now().year, DateTime.now().month);
    final end = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);

    final monthlyIncomes = ref.watch(GetTxnsOverPeriodProvider(
      startDate: start,
      endDate: end,
      type: TransactionType.credit,
      currency: PecuniaCurrencies.usd,
    ));
    final monthlyExpenses = ref.watch(GetTxnsOverPeriodProvider(
      startDate: start,
      endDate: end,
      type: TransactionType.debit,
      currency: PecuniaCurrencies.usd,
    ));

    return switch ((monthlyIncomes, monthlyExpenses)) {
      (AsyncLoading(), _) || (_, AsyncLoading()) => const LoadingMonthlyTxnModule(),
      (AsyncError(:final Object error), _) => Center(child: Text((error as Failure).message)),
      (_, AsyncError(:final Object error)) => Center(child: Text((error as Failure).message)),
      (
        AsyncData(value: final List<Transaction> monthlyIncomesList),
        AsyncData(value: final List<Transaction> monthlyExpensesList),
      ) =>
        BuildMonthlyTxnModule(monthlyIncomesList, monthlyExpensesList),
      _ => const Center(child: Text('Something went wrong')),
    };
  }
}

class LoadingMonthlyTxnModule extends ConsumerWidget {
  const LoadingMonthlyTxnModule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 34),
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}

class BuildMonthlyTxnModule extends ConsumerWidget {
  const BuildMonthlyTxnModule(this.monthlyIncomesList, this.monthlyExpensesList, {super.key});

  final List<Transaction> monthlyIncomesList;
  final List<Transaction> monthlyExpensesList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              'Stats (\$USD) ${DateTime.now().month.monthName} ${DateTime.now().year}',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Column(
                      children: [
                        Text(
                          '\$${sumUpTxns(monthlyIncomesList).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.green[100],
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'income',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5),
                                fontSize: 16,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Column(
                      children: [
                        Text(
                          '\$${sumUpTxns(monthlyExpensesList).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.red[100],
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'expense',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5),
                                fontSize: 16,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double sumUpTxns(List<Transaction> txns) {
    var sum = 0.0;
    for (final txn in txns) {
      sum += txn.fundDetails.transactionAmount;
    }
    return sum;
  }
}
