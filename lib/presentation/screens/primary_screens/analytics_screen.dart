// ignore_for_file: prefer_const_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/get_all_expense_txns.dart';
import 'package:pecunia/features/transactions/usecases/get_all_income_txns.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: RefreshIndicator(
      displacement: 100,
      onRefresh: () async {
        ref.invalidate(getAllIncomeTxnsProvider);
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
                Divider(
                  color: Theme.of(context).dividerColor.withOpacity(0.2),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 24, top: 14),
                  child: const Text(
                    'Income',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AllIncomeChart(),
                Divider(
                  color: Theme.of(context).dividerColor.withOpacity(0.2),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 24, top: 14),
                  child: const Text(
                    'Expense',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
    final incomeValue = ref.watch(getAllIncomeTxnsProvider);

    return switch (incomeValue) {
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
    txns.forEach((txn) {
      print('Transaction ID: ${txn.id}, Transaction Amount: ${txn.fundDetails.transactionAmount}');
    });

    return AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          gridData: FlGridData(
            horizontalInterval: 10,
            verticalInterval: 10,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Theme.of(context).dividerColor.withOpacity(0.2),
                strokeWidth: 1,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Theme.of(context).dividerColor.withOpacity(0.2),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(),
            topTitles: const AxisTitles(),
            bottomTitles: const AxisTitles(),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          lineBarsData: [
            LineChartBarData(
              spots: txns
                  .map((e) => FlSpot(
                        txns.indexOf(e).toDouble(),
                        e.fundDetails.transactionAmount,
                      ))
                  .toList(),
              barWidth: 3,
              isStrokeCapRound: true,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff23b6e6),
                  Color(0xff02d39a),
                ],
              ),
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}

class AllExpenseChart extends ConsumerWidget {
  const AllExpenseChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incomeValue = ref.watch(getAllExpenseTxnsProvider);

    return switch (incomeValue) {
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
    txns.forEach((txn) {
      print('Transaction ID: ${txn.id}, Transaction Amount: ${txn.fundDetails.transactionAmount}');
    });

    return AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          gridData: FlGridData(
            horizontalInterval: 10,
            verticalInterval: 10,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Theme.of(context).dividerColor.withOpacity(0.2),
                strokeWidth: 1,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Theme.of(context).dividerColor.withOpacity(0.2),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(),
            topTitles: const AxisTitles(),
            bottomTitles: const AxisTitles(),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          lineBarsData: [
            LineChartBarData(
              spots: txns
                  .map((e) => FlSpot(
                        txns.indexOf(e).toDouble(),
                        e.fundDetails.transactionAmount,
                      ))
                  .toList(),
              barWidth: 3,
              isStrokeCapRound: true,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffFF0000),
                  Color(0xff8B0000),
                ],
              ),
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
