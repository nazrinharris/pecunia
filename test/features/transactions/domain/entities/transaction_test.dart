import 'package:flutter_test/flutter_test.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';

void main() {
  group('FundDetails', () {
    test('transactionAmount returns baseAmount for debit transactions', () {
      final fundDetails = FundDetails(
        baseAmount: 100,
        baseCurrency: PecuniaCurrencies.fromString('USD'),
        transactionType: TransactionType.debit,
        exchangeRate: null,
        targetAmount: null,
        targetCurrency: null,
      );

      expect(fundDetails.transactionAmount, 100.0);
    });

    test('transactionAmount returns targetAmount for credit transactions with a target', () {
      final fundDetails = FundDetails(
        baseAmount: 100,
        baseCurrency: PecuniaCurrencies.fromString('USD'),
        transactionType: TransactionType.credit,
        exchangeRate: 1.1,
        targetAmount: 110,
        targetCurrency: PecuniaCurrencies.fromString('EUR'),
      );

      expect(fundDetails.transactionAmount, 110.0);
    });

    test('transactionAmount returns baseAmount for credit transactions without a target', () {
      final fundDetails = FundDetails(
        baseAmount: 100,
        baseCurrency: PecuniaCurrencies.fromString('USD'),
        transactionType: TransactionType.credit,
        exchangeRate: null,
        targetAmount: null,
        targetCurrency: null,
      );

      expect(fundDetails.transactionAmount, 100.0);
    });

    test('transactionCurrency returns baseCurrency for debit transactions', () {
      final fundDetails = FundDetails(
        baseAmount: 100,
        baseCurrency: PecuniaCurrencies.fromString('USD'),
        transactionType: TransactionType.debit,
        exchangeRate: null,
        targetAmount: null,
        targetCurrency: null,
      );

      expect(fundDetails.transactionCurrency.code, 'USD');
    });

    test('transactionCurrency returns targetCurrency for credit transactions with a target', () {
      final fundDetails = FundDetails(
        baseAmount: 100,
        baseCurrency: PecuniaCurrencies.fromString('USD'),
        transactionType: TransactionType.credit,
        exchangeRate: 1.1,
        targetAmount: 110,
        targetCurrency: PecuniaCurrencies.fromString('EUR'),
      );

      expect(fundDetails.transactionCurrency.code, 'EUR');
    });

    test('transactionCurrency returns baseCurrency for credit transactions without a target', () {
      final fundDetails = FundDetails(
        baseAmount: 100,
        baseCurrency: PecuniaCurrencies.fromString('USD'),
        transactionType: TransactionType.credit,
        exchangeRate: null,
        targetAmount: null,
        targetCurrency: null,
      );

      expect(fundDetails.transactionCurrency.code, 'USD');
    });
  });
}
