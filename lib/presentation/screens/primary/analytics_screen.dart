// ignore_for_file: prefer_const_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/core/util/transactions_util.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/get_txns_current_month.dart';

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
      AsyncData(:final List<Transaction> value) => AllIncomeLineChart(value),
      _ => const Center(child: Text('Something went wrong')),
    };
  }
}

class AllIncomeLineChart extends StatelessWidget {
  const AllIncomeLineChart(this.txns, {super.key});

  final List<Transaction> txns;

  @override
  Widget build(BuildContext context) {
    debugPrint('txns: ${txns.length}');

    final aggregate = aggregateTransactionsIntoDays(txns);

    return SizedBox(
      height: 400,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.only(top: 34, bottom: 34, right: 14),
          child: BarChart(
            BarChartData(
              barTouchData: BarTouchData(),
              titlesData: FlTitlesData(
                rightTitles: const AxisTitles(),
                topTitles: const AxisTitles(),
                bottomTitles: AxisTitles(sideTitles: _bottomTitles(aggregate, context), axisNameSize: 8),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: aggregate
                  .map(
                    (e) => BarChartGroupData(
                      x: aggregate.indexOf(e),
                      barRods: [
                        BarChartRodData(
                          toY: e.value,
                          color: Colors.green[300],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  SideTitles _bottomTitles(List<MapEntry<DateTime, double>> aggregate, BuildContext context) {
    return SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          value.toInt().isEven ? DateFormat('MM/dd').format(aggregate[value.toInt()].key) : '',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5),
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

class AllExpenseLineChart extends StatelessWidget {
  const AllExpenseLineChart(this.txns, {super.key});

  final List<Transaction> txns;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.only(top: 34, bottom: 34, right: 14),
        child: AspectRatio(
          aspectRatio: 1.7,
          child: BarChart(
            BarChartData(
              barTouchData: BarTouchData(),
              titlesData: FlTitlesData(
                rightTitles: const AxisTitles(),
                topTitles: const AxisTitles(),
                bottomTitles: const AxisTitles(),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: txns
                  .map(
                    (e) => BarChartGroupData(
                      x: txns.indexOf(e),
                      barRods: [
                        BarChartRodData(
                          toY: e.fundDetails.transactionAmount,
                          color: Colors.red[300],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
