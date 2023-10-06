import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money2/money2.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:pecunia/features/categories/usecases/get_all_categories.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/create_transaction.dart';

class CreateTxnFields {
  static String? validateTxnName(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter a name for your transaction';
    }
    if (val.length > 50) {
      return 'Please enter a name less than 50 characters';
    }
    return null;
  }

  static String? validateTxnDescription(String? val) {
    if (val != null && val.length > 500) {
      return 'Please enter a description less than 500 characters';
    }
    return null;
  }

  static String? validateBaseAmount(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter an amount';
    }
    if (double.tryParse(val) == null) {
      return 'Please enter a valid amount';
    }
    if (double.tryParse(val)! <= 0) {
      return 'Must be greater than 0';
    }

    return null;
  }

  static String? validateExchangeRate(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter an exchange rate';
    }
    if (double.tryParse(val) == null) {
      return 'Please enter a valid exchange rate';
    }
    if (double.tryParse(val)! <= 0) {
      return 'Must be greater than 0';
    }
    return null;
  }

  static String? validateTargetAmount(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter a target amount';
    }
    if (double.tryParse(val) == null) {
      return 'Please enter a valid target amount';
    }
    if (double.tryParse(val)! <= 0) {
      return 'Must be greater than 0';
    }
    return null;
  }
}

class CreateTxnForm extends HookConsumerWidget {
  const CreateTxnForm({
    required this.initialTransactionType,
    this.account,
    this.accountsList,
    this.disableCloseButton = false,
    super.key,
  }) : assert(
            (account == null) != (accountsList == null), // either account or accountsList, but not both
            'Either account or accountsList must be provided, but not both.');

  final Account? account;
  final List<Account>? accountsList;
  final TransactionType initialTransactionType;
  final bool disableCloseButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chosenAccount = useState(account ?? accountsList!.first);

    final txnType = useState(initialTransactionType);
    final isCurrencyExchangeEnabled = useState(false);
    final formKey = useState(GlobalKey<FormState>());

    final nameController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final baseAmountController = useTextEditingController();
    final exchangeRateController = useTextEditingController();
    final targetAmountController = useTextEditingController();

    final baseCurrency = useState(chosenAccount.value.currency);
    final targetCurrency = useState(chosenAccount.value.currency);

    final chosenCategory = useState<Category?>(null);

    final nameNode = useFocusNode();
    final descriptionNode = useFocusNode();

    useEffect(() {
      baseCurrency.value = chosenAccount.value.currency;
      targetCurrency.value = chosenAccount.value.currency;
      return null;
    }, [chosenAccount.value]);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Form(
        key: formKey.value,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${txnType.value.toDisplayName()} Transaction',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: txnType.value.isCredit() ? Colors.green[200] : Colors.red[200],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (!disableCloseButton)
                    IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close, size: 28))
                ],
              ),
            ),
            TextFormField(
              controller: nameController,
              focusNode: nameNode,
              validator: CreateTxnFields.validateTxnName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onFieldSubmitted: (value) => descriptionNode.requestFocus(),
              decoration: const InputDecoration(
                labelText: 'Transaction Name',
                hintText: 'Enter a name for your transaction',
              ),
            ),
            TextFormField(
              controller: descriptionController,
              focusNode: descriptionNode,
              maxLines: null,
              validator: CreateTxnFields.validateTxnDescription,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter a description for your transaction',
              ),
            ),
            const SizedBox(height: 8),
            ChooseAccountField(chosenAccount: chosenAccount, accountsList: accountsList),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: TransactionType.values.map((type) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 14),
                    decoration: BoxDecoration(
                      color: txnType.value == type
                          ? (txnType.value.isCredit()
                              ? Colors.green[200]!.withOpacity(0.2)
                              : Colors.red[200]!.withOpacity(0.2))
                          : null,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: RadioListTile<TransactionType>(
                      title: Text(type.toDescription()),
                      value: type,
                      groupValue: txnType.value,
                      activeColor: txnType.value.isCredit() ? Colors.green[200] : Colors.red[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      onChanged: (val) => txnType.value = val!,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),
            CategoryField(chosenCategory),
            const SizedBox(height: 14),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Fund Details',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              value: isCurrencyExchangeEnabled.value,
              onChanged: (val) => isCurrencyExchangeEnabled.value = val,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              tileColor: isCurrencyExchangeEnabled.value
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : null,
              title: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.swap_horiz),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Enable currency exchange',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  flex: 3,
                  child: BaseCurrencyField(
                    chosenAccount.value,
                    baseCurrency,
                    txnType,
                    isCurrencyExchangeEnabled,
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: BaseAmountField(
                    baseAmountController: baseAmountController,
                    exchangeRateController: exchangeRateController,
                    targetAmountController: targetAmountController,
                  ),
                )
              ],
            ),
            if (isCurrencyExchangeEnabled.value) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: const Icon(Icons.swap_vert_rounded, size: 32),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: ExchangeRateField(
                      baseAmountController: baseAmountController,
                      exchangeRateController: exchangeRateController,
                      targetAmountController: targetAmountController,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 3,
                    child: TargetCurrencyField(
                      chosenAccount.value,
                      targetCurrency,
                      txnType,
                      isCurrencyExchangeEnabled,
                    ),
                  ),
                  Flexible(
                      flex: 5,
                      child: TargetAmountField(
                        baseAmountController: baseAmountController,
                        exchangeRateController: exchangeRateController,
                        targetAmountController: targetAmountController,
                      ))
                ],
              )
            ],
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();

                if (formKey.value.currentState!.validate()) {
                  double? exchangeRateInput;
                  double? targetAmountInput;
                  String? targetCurrencyInput;

                  if (isCurrencyExchangeEnabled.value) {
                    exchangeRateInput = double.parse(exchangeRateController.text);
                    targetAmountInput = double.parse(targetAmountController.text);
                    targetCurrencyInput = targetCurrency.value.code;
                  }

                  await ref.read(createTransactionProvider.notifier).createTransaction(
                        name: nameController.text,
                        description: descriptionController.text,
                        accountId: chosenAccount.value.id,
                        transactionType: txnType.value,
                        baseAmount: double.parse(baseAmountController.text),
                        baseCurrency: baseCurrency.value.code,
                        exchangeRate: exchangeRateInput,
                        targetCurrency: targetCurrencyInput,
                        targetAmount: targetAmountInput,
                        category: chosenCategory.value,
                      );
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.onSecondary,
              )),
              child: const Text('Create Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryField extends HookConsumerWidget {
  const CategoryField(this.chosenCategory, {super.key});

  final ValueNotifier<Category?> chosenCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesValue = ref.watch(getAllCategoriesProvider);

    return switch (categoriesValue) {
      AsyncLoading() => const Center(child: CupertinoActivityIndicator()),
      AsyncError(:final Failure error) => Center(child: Text(error.toString())),
      AsyncData(:final List<Category> value) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: DropdownButton<Category?>(
            isExpanded: true,
            borderRadius: BorderRadius.circular(14),
            hint: const Text('   Choose an optional category'),
            underline: const SizedBox.shrink(),
            icon: const SizedBox.shrink(),
            value: chosenCategory.value,
            itemHeight: 64,
            items: [
              const DropdownMenuItem<Category?>(
                child: Text('    No category'),
              ),
              ...value.map((category) {
                final primaryColor = Color(int.parse(category.primaryColor, radix: 16));
                final primarySwatch = ColorTools.createPrimarySwatch(primaryColor);
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Row(
                    children: [
                      const SizedBox(width: 14),
                      Container(
                        height: 45,
                        width: 45,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: primarySwatch.shade500.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          category.icon,
                          color: primarySwatch.shade500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(category.name),
                    ],
                  ),
                );
              }),
            ],
            onChanged: (val) {
              chosenCategory.value = val;
            },
          ),
        ),
      AsyncData(:final List<Category> value) when value.isEmpty => const Center(
          child: Text('No categories found'),
        ),
      _ => const Center(child: Text('Fatal Error, Unexpected State')),
    };
  }
}

class ChooseAccountField extends HookConsumerWidget {
  const ChooseAccountField({
    required this.chosenAccount,
    this.accountsList,
    super.key,
  });

  final ValueNotifier<Account> chosenAccount;
  final List<Account>? accountsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField<Account>(
      value: chosenAccount.value,
      items: items,
      onChanged: accountsList == null
          ? null
          : (val) {
              chosenAccount.value = val!;
            },
    );
  }

  List<DropdownMenuItem<Account>> get items {
    if (accountsList != null) {
      return accountsList!.map((account) {
        return DropdownMenuItem<Account>(
          value: account,
          child: Text(account.name),
        );
      }).toList();
    } else {
      return [
        DropdownMenuItem(
          value: chosenAccount.value,
          child: Text(chosenAccount.value.name),
        ),
      ];
    }
  }
}

class BaseAmountField extends HookConsumerWidget {
  const BaseAmountField({
    required this.baseAmountController,
    required this.exchangeRateController,
    required this.targetAmountController,
    super.key,
  });

  final TextEditingController baseAmountController;
  final TextEditingController exchangeRateController;
  final TextEditingController targetAmountController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: baseAmountController,
      validator: CreateTxnFields.validateBaseAmount,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Amount',
        hintText: 'Enter amount',
      ),
    );
  }
}

class ExchangeRateField extends HookConsumerWidget {
  const ExchangeRateField({
    required this.baseAmountController,
    required this.exchangeRateController,
    required this.targetAmountController,
    super.key,
  });

  final TextEditingController baseAmountController;
  final TextEditingController exchangeRateController;
  final TextEditingController targetAmountController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      void update() {
        if (baseAmountController.text.isNotEmpty &&
            targetAmountController.text.isNotEmpty &&
            _isNumeric(baseAmountController.text) &&
            _isNumeric(targetAmountController.text)) {
          final baseAmount = double.parse(baseAmountController.text);
          final targetAmount = double.parse(targetAmountController.text);
          final exchangeRate = targetAmount / baseAmount;

          exchangeRateController.text = exchangeRate.toString();
        }
      }

      baseAmountController.addListener(update);
      targetAmountController.addListener(update);
      return () {
        baseAmountController.removeListener(update);
        targetAmountController.removeListener(update);
      };
    }, [baseAmountController, targetAmountController]);

    return TextFormField(
      controller: exchangeRateController,
      enabled: false,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Exchange Rate (optional)',
        hintText: 'Just fill amount & target amount',
      ),
      onChanged: (val) {},
    );
  }

  bool _isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}

class TargetAmountField extends HookConsumerWidget {
  const TargetAmountField({
    required this.baseAmountController,
    required this.exchangeRateController,
    required this.targetAmountController,
    super.key,
  });

  final TextEditingController baseAmountController;
  final TextEditingController exchangeRateController;
  final TextEditingController targetAmountController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: targetAmountController,
      validator: CreateTxnFields.validateTargetAmount,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Target Amount',
        hintText: 'Enter the target amount',
      ),
    );
  }
}

class BaseCurrencyField extends HookConsumerWidget {
  const BaseCurrencyField(
    this.account,
    this.baseCurrency,
    this.txnType,
    this.isCurrencyExchangeEnabled, {
    super.key,
  });

  final Account account;
  final ValueNotifier<Currency> baseCurrency;
  final ValueNotifier<TransactionType> txnType;
  final ValueNotifier<bool> isCurrencyExchangeEnabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      void update() {
        if (txnType.value.isCredit() && isCurrencyExchangeEnabled.value) {
          // baseCurrency remains unchanged
        } else if (txnType.value.isDebit() && isCurrencyExchangeEnabled.value) {
          baseCurrency.value = account.currency;
        } else {
          baseCurrency.value = account.currency;
        }
      }

      txnType.addListener(update);
      isCurrencyExchangeEnabled.addListener(update);
      return () {
        txnType.removeListener(update);
        isCurrencyExchangeEnabled.removeListener(update);
      };
    }, [txnType, isCurrencyExchangeEnabled]);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: determineIfEnabled() ? 1 : 0.5,
      child: Container(
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Material(
            color: Colors.transparent,
            child: PopupMenuButton<Currency>(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              initialValue: baseCurrency.value,
              onSelected: (Currency value) {
                baseCurrency.value = value;
              },
              enabled: determineIfEnabled(),
              itemBuilder: (BuildContext context) {
                return PecuniaCurrencies.toList().map<PopupMenuItem<Currency>>((Currency c) {
                  return PopupMenuItem<Currency>(
                    value: c,
                    child: Text('${c.code} - ${c.name}', textAlign: TextAlign.center),
                  );
                }).toList();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      baseCurrency.value.code,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool determineIfEnabled() {
    if (txnType.value.isCredit() && isCurrencyExchangeEnabled.value) {
      return true;
    } else {
      return false;
    }
  }
}

class TargetCurrencyField extends HookConsumerWidget {
  const TargetCurrencyField(
    this.account,
    this.targetCurrency,
    this.txnType,
    this.isCurrencyExchangeEnabled, {
    super.key,
  });

  final Account account;
  final ValueNotifier<Currency> targetCurrency;
  final ValueNotifier<TransactionType> txnType;
  final ValueNotifier<bool> isCurrencyExchangeEnabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      void update() {
        if (txnType.value.isCredit() && isCurrencyExchangeEnabled.value) {
          targetCurrency.value = account.currency;
        } else if (txnType.value.isDebit() && isCurrencyExchangeEnabled.value) {
          // targetCurrency remains unchanged
        } else {
          targetCurrency.value = account.currency;
        }
      }

      txnType.addListener(update);
      isCurrencyExchangeEnabled.addListener(update);
      return () {
        txnType.removeListener(update);
        isCurrencyExchangeEnabled.removeListener(update);
      };
    }, [txnType, isCurrencyExchangeEnabled]);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: determineIfEnabled() ? 1 : 0.5,
      child: Container(
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Material(
            color: Colors.transparent,
            child: PopupMenuButton<Currency>(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              initialValue: targetCurrency.value,
              onSelected: (Currency value) {
                targetCurrency.value = value;
              },
              enabled: determineIfEnabled(),
              itemBuilder: (BuildContext context) {
                return PecuniaCurrencies.toList().map<PopupMenuItem<Currency>>((Currency c) {
                  return PopupMenuItem<Currency>(
                    value: c,
                    child: Text('${c.code} - ${c.name}', textAlign: TextAlign.center),
                  );
                }).toList();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      targetCurrency.value.code,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool determineIfEnabled() {
    if (txnType.value.isCredit() && isCurrencyExchangeEnabled.value) {
      return false;
    } else {
      return true;
    }
  }
}
