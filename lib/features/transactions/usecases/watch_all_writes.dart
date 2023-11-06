import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/features/accounts/usecases/create_account.dart';
import 'package:pecunia/features/accounts/usecases/delete_account.dart';
import 'package:pecunia/features/accounts/usecases/edit_account.dart';
import 'package:pecunia/features/categories/usecases/delete_category.dart';
import 'package:pecunia/features/categories/usecases/update_category.dart';
import 'package:pecunia/features/transactions/usecases/create_transaction.dart';
import 'package:pecunia/features/transactions/usecases/create_transfer_transaction.dart';
import 'package:pecunia/features/transactions/usecases/delete_transaction.dart';
import 'package:pecunia/features/transactions/usecases/delete_transfer_transaction.dart';
import 'package:pecunia/features/transactions/usecases/edit_transaction.dart';
import 'package:pecunia/features/transactions/usecases/edit_transfer_transaction.dart';

void watchAllWritesAsyncNotifierProvider<T>(AutoDisposeAsyncNotifierProviderRef<T> ref) {
  ref
    ..watch(createAccountProvider)
    ..watch(deleteAccountProvider)
    ..watch(editAccountProvider)
    ..watch(createTransactionProvider)
    ..watch(deleteTransactionProvider)
    ..watch(editTransactionProvider)
    ..watch(createTransferTransactionProvider)
    ..watch(deleteTransferTransactionProvider)
    ..watch(editTransferTransactionProvider)
    ..watch(updateCategoryProvider)
    ..watch(deleteCategoryProvider);
}

void watchAllWritesFutureProvider<T>(AutoDisposeFutureProviderRef<T> ref) {
  ref
    ..watch(createAccountProvider)
    ..watch(deleteAccountProvider)
    ..watch(editAccountProvider)
    ..watch(createTransactionProvider)
    ..watch(deleteTransactionProvider)
    ..watch(editTransactionProvider)
    ..watch(createTransferTransactionProvider)
    ..watch(deleteTransferTransactionProvider)
    ..watch(editTransferTransactionProvider)
    ..watch(updateCategoryProvider)
    ..watch(deleteCategoryProvider);
}
