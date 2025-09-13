// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/core/util/transactions_util.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/get_txns_current_month.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: RefreshIndicator.adaptive(
      displacement: 100,
      onRefresh: () async {
        ref
          ..invalidate(
              getTxnsCurrentMonthProvider(type: TransactionType.credit, currency: PecuniaCurrencies.usd))
          ..invalidate(
              getTxnsCurrentMonthProvider(type: TransactionType.debit, currency: PecuniaCurrencies.usd));
      },
      child: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Graphs + Charts =',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                Text(
                  'Analytics',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                        fontFamily: 'Instrument',
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 14),
                  child: const Text(
                    "This Month's Income",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                AllIncomeChart(),
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 14),
                  child: const Text(
                    "This Month's Expense",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                AllExpenseChart(),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class AllIncomeChart extends ConsumerWidget {
  const AllIncomeChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thisMonthIncomeValue =
        ref.watch(getTxnsCurrentMonthProvider(type: TransactionType.credit, currency: PecuniaCurrencies.usd));

    return switch (thisMonthIncomeValue) {
      AsyncLoading() => Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: CupertinoActivityIndicator(),
        ),
      AsyncError(:final Failure error) => Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Text(error.message),
        ),
      AsyncData(:final List<Transaction> value) when value.isEmpty => SizedBox(
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.center,
              child: Text('No income transactions yet!'),
            ),
          ),
        ),
      AsyncData(:final List<Transaction> value) => AllIncomeBarChart(value),
      _ => const Center(child: Text('Something went wrong')),
    };
  }
}

class AllIncomeBarChart extends HookWidget {
  const AllIncomeBarChart(this.txns, {super.key});

  final List<Transaction> txns;

  @override
  Widget build(BuildContext context) {
    final aggregate = useState(aggregateTransactionsIntoDays(txns));

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 400, minHeight: 200, maxWidth: 600, minWidth: 400),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.only(top: 34, bottom: 34, right: 14),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
              numberFormat: NumberFormat.currency(symbol: txns[0].fundDetails.transactionCurrency.symbol),
            ),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<MapEntry<DateTime, double>, String>>[
              ColumnSeries<MapEntry<DateTime, double>, String>(
                name: '${DateFormat('MMMM').format(DateTime.now())} Income',
                dataSource: aggregate.value,
                xValueMapper: (MapEntry<DateTime, double> entry, _) => DateFormat('M/d').format(entry.key),
                yValueMapper: (MapEntry<DateTime, double> entry, _) => entry.value,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
                color: Colors.green[300],
                animationDuration: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AllExpenseChart extends ConsumerWidget {
  const AllExpenseChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thisMonthExpenseValue =
        ref.watch(getTxnsCurrentMonthProvider(type: TransactionType.debit, currency: PecuniaCurrencies.usd));

    return switch (thisMonthExpenseValue) {
      AsyncLoading() => Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: CupertinoActivityIndicator(),
        ),
      AsyncError(:final Failure error) => Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Text(error.message),
        ),
      AsyncData(:final List<Transaction> value) when value.isEmpty => SizedBox(
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.center,
              child: Text('No expense transactions yet!'),
            ),
          ),
        ),
      AsyncData(:final List<Transaction> value) => AllExpenseLineChart(value),
      _ => const Center(child: Text('Something went wrong')),
    };
  }
}

class AllExpenseLineChart extends HookWidget {
  const AllExpenseLineChart(this.txns, {super.key});

  final List<Transaction> txns;

  @override
  Widget build(BuildContext context) {
    final aggregate = useState(aggregateTransactionsIntoDays(txns));

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 400, minHeight: 200, maxWidth: 600, minWidth: 400),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.only(top: 34, bottom: 34, right: 14),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
              numberFormat: NumberFormat.currency(symbol: txns[0].fundDetails.transactionCurrency.symbol),
            ),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<MapEntry<DateTime, double>, String>>[
              ColumnSeries<MapEntry<DateTime, double>, String>(
                name: '${DateFormat('MMMM').format(DateTime.now())} Expenses',
                dataSource: aggregate.value,
                xValueMapper: (MapEntry<DateTime, double> entry, _) => DateFormat('M/d').format(entry.key),
                yValueMapper: (MapEntry<DateTime, double> entry, _) => entry.value,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
                color: Colors.red[300],
                animationDuration: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
