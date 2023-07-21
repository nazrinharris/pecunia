import 'package:flutter_test/flutter_test.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';

void main() {
  group('FundDetails', () {
    test('transactionAmount returns baseAmount for debit transactions', () {
      const fundDetails = FundDetails(
        baseAmount: 100,
        baseCurrency: 'USD',
        transactionType: TransactionType.debit,
        exchangeRate: null,
        targetAmount: null,
        targetCurrency: null,
      );

      expect(fundDetails.transactionAmount, 100.0);
    });

    test('transactionAmount returns targetAmount for credit transactions with a target', () {
      const fundDetails = FundDetails(
        baseAmount: 100,
        baseCurrency: 'USD',
        transactionType: TransactionType.credit,
        exchangeRate: 1.1,
        targetAmount: 110,
        targetCurrency: 'EUR',
      );

      expect(fundDetails.transactionAmount, 110.0);
    });

    test('transactionAmount returns baseAmount for credit transactions without a target', () {
      const fundDetails = FundDetails(
        baseAmount: 100,
        baseCurrency: 'USD',
        transactionType: TransactionType.credit,
        exchangeRate: null,
        targetAmount: null,
        targetCurrency: null,
      );

      expect(fundDetails.transactionAmount, 100.0);
    });

    test('transactionCurrency returns baseCurrency for debit transactions', () {
      const fundDetails = FundDetails(
        baseAmount: 100,
        baseCurrency: 'USD',
        transactionType: TransactionType.debit,
        exchangeRate: null,
        targetAmount: null,
        targetCurrency: null,
      );

      expect(fundDetails.transactionCurrency, 'USD');
    });

    test('transactionCurrency returns targetCurrency for credit transactions with a target', () {
      const fundDetails = FundDetails(
        baseAmount: 100,
        baseCurrency: 'USD',
        transactionType: TransactionType.credit,
        exchangeRate: 1.1,
        targetAmount: 110,
        targetCurrency: 'EUR',
      );

      expect(fundDetails.transactionCurrency, 'EUR');
    });

    test('transactionCurrency returns baseCurrency for credit transactions without a target', () {
      const fundDetails = FundDetails(
        baseAmount: 100,
        baseCurrency: 'USD',
        transactionType: TransactionType.credit,
        exchangeRate: null,
        targetAmount: null,
        targetCurrency: null,
      );

      expect(fundDetails.transactionCurrency, 'USD');
    });
  });
}
