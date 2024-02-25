import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/util/extensions.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/presentation/widgets/transactions/txn_bottom_sheet_widget.dart';

class TxnListTile extends HookConsumerWidget {
  const TxnListTile({
    required this.account,
    required this.txn,
    required this.category,
    this.enableTopDivider = false,
    this.enableBottomDivider = true,
    this.hideAccountName = false,
    this.hideDate = false,
    this.onTap,
    super.key,
  });

  final Account account;
  final Transaction txn;
  final Category? category;
  final bool enableTopDivider;
  final bool enableBottomDivider;
  final bool hideAccountName;
  final bool hideDate;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        if (enableTopDivider) Divider(color: Colors.grey.withOpacity(0.1)),
        ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!hideAccountName)
                Text(
                  account.name,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              if (!hideDate)
                Text(
                  txn.transactionDate.formatted,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(width: 8),
              Text(
                txn.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          subtitle: txn.transactionDescription.value == null
              ? null
              : Text(
                  txn.transactionDescription.value!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
          trailing: BuildTxnAmountText(txn),
          leading: TxnListTileIcon(category: category),
          onTap: onTap ??
              () {
                showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    showDragHandle: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(44),
                    ),
                    builder: (context) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: TxnBottomSheet(
                          account: account,
                          txn: txn,
                          category: category,
                        ),
                      );
                    });
              },
        ),
        if (enableBottomDivider) Divider(color: Colors.grey.withOpacity(0.1)),
      ],
    );
  }
}

class TxnListTileIcon extends StatelessWidget {
  const TxnListTileIcon({super.key, this.category});

  final Category? category;

  @override
  Widget build(BuildContext context) {
    if (category != null) {
      final swatch = category!.primaryColor.toMaterialColor();
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: swatch.shade500.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          category!.icon,
          color: swatch.shade500, // Use the darker shade for the icon color
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.question_mark, color: Colors.grey[100]),
    );
  }
}

class TxnListTileError extends HookConsumerWidget {
  const TxnListTileError(
    this.failure, {
    super.key,
    this.enableTopDivider = false,
    this.enableBottomDivider = true,
  });

  final Failure failure;
  final bool enableTopDivider;
  final bool enableBottomDivider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Divider(color: Colors.grey.withOpacity(0.1)),
        ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Error loading transaction',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 8),
              Text(
                failure.message,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: const Icon(Icons.error_outline, color: Colors.red),
        ),
        Divider(color: Colors.grey.withOpacity(0.1)),
      ],
    );
  }
}
