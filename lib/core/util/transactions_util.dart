import 'package:pecunia/features/transactions/domain/entities/transaction.dart';

List<MapEntry<DateTime, double>> aggregateTransactionsIntoDays(List<Transaction> txns) {
  final sortedTxn = txns..sort((a, b) => a.transactionDate.compareTo(b.transactionDate));

  final dailyTxnMap = <DateTime, double>{};
  for (final txn in sortedTxn) {
    final date = DateTime(txn.transactionDate.year, txn.transactionDate.month, txn.transactionDate.day);
    if (dailyTxnMap.containsKey(date)) {
      dailyTxnMap[date] =
          double.parse((dailyTxnMap[date]! + txn.fundDetails.transactionAmount).toStringAsFixed(2));
    } else {
      dailyTxnMap[date] = double.parse(txn.fundDetails.transactionAmount.toStringAsFixed(2));
    }
  }

  final sortedEntries = dailyTxnMap.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

  return sortedEntries;
}
