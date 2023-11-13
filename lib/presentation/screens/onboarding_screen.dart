// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/features/app_info/app_info.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showOnboardingBottomSheet(context).then((_) {
        context.goNamed('start');
        ref.read(setIsFirstOpenProvider(false));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: SizedBox.shrink()));
  }
}

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 44),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 34),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.6),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showOnboardingBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(44)),
    ),
    builder: (context) {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: Container(
            padding: const EdgeInsets.only(top: 14, bottom: 14),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "What's new in",
                                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                      color:
                                          Theme.of(context).textTheme.headlineSmall!.color!.withOpacity(0.5),
                                    ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Pecunia',
                                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 48,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                  children: [
                                    TextSpan(
                                      text: ' v0.1.0+1',
                                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 48,
                                          ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text('Skip'))
                    ],
                  ),
                ),
                const SizedBox(height: 44),
                OnboardingItem(
                  title: 'Remote and local user accounts',
                  subtitle:
                      'You can create a remote account or stay local (remote data sync not yet implemented).',
                  icon: Icons.face_rounded,
                ),
                SizedBox(height: 18),
                OnboardingItem(
                  title: 'Transaction Tracking',
                  subtitle: 'Create income and expense transactions.',
                  icon: Icons.timeline_rounded,
                ),
                SizedBox(height: 18),
                OnboardingItem(
                  title: 'Multiple Accounts',
                  subtitle: 'Create multiple accounts and track transactions for each account.',
                  icon: Icons.receipt_long_rounded,
                ),
                SizedBox(height: 18),
                OnboardingItem(
                  title: 'Transfer between accounts',
                  subtitle: 'You can transfer money between accounts.',
                  icon: Icons.sync_alt_rounded,
                ),
                SizedBox(height: 18),
                OnboardingItem(
                  title: 'Multi-Currency Capable',
                  subtitle: 'USD? INR? EUR? You name it!',
                  icon: Icons.currency_exchange,
                ),
                SizedBox(height: 18),
                OnboardingItem(
                  title: 'Categories',
                  subtitle: 'So that you can see how much you spent on coffee.',
                  icon: Icons.sell,
                ),
                const SizedBox(height: 84),
              ],
            ),
          ),
        ),
      );
    },
  );
}
