import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/presentation/screens/accounts/accounts_screen.dart';
import 'package:pecunia/presentation/screens/analytics/analytics_screen.dart';
import 'package:pecunia/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:pecunia/presentation/screens/finance/finance_screen.dart';
import 'package:pecunia/presentation/screens/profile/profile_screen.dart';
import 'package:pecunia/presentation/screens/shared/pecunia_fab.dart';
import 'package:simple_animations/simple_animations.dart';

class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      floatingActionButton: PlayAnimationBuilder(
          tween: Tween<Offset>(begin: const Offset(0, 200), end: Offset.zero),
          duration: const Duration(milliseconds: 1000),
          delay: const Duration(milliseconds: 200),
          curve: Curves.easeOutExpo,
          builder: (context, value, child) => Transform.translate(
                offset: value,
                child: child,
              ),
          child: Transform.translate(
            offset: const Offset(0, -70),
            child: const PecuniaFAB(),
          )),
      floatingActionButtonLocation: ExpandableFab.location,
      body: BottomNavLayout(
        pages: [
          (_) => const DashboardScreen(),
          (_) => const AccountsScreen(),
          (_) => const FinanceScreen(),
          (_) => const AnalyticsScreen(),
          (_) => const ProfileScreen(),
        ],
        pageTransitionData: _pageTransition(),
        lazyLoadPages: true,
        savePageState: true,
        bottomNavigationBar: (currentIndex, onTap) => PlayAnimationBuilder(
          tween: Tween<Offset>(begin: const Offset(0, 200), end: Offset.zero),
          duration: const Duration(milliseconds: 1000),
          delay: const Duration(milliseconds: 200),
          curve: Curves.easeOutExpo,
          builder: (context, value, child) => Transform.translate(
            offset: value,
            child: child,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            padding: EdgeInsets.only(left: 24, right: 24, bottom: bottomPadding + 10, top: 14),
            child: GNav(
              gap: 10,
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
              activeColor: Theme.of(context).colorScheme.primary,
              hoverColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              iconSize: 20,
              // tabBackgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInExpo,
              // tabActiveBorder:
              //     Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2), width: 2),
              // tabBorder:
              //     Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0), width: 2),
              tabs: const [
                GButton(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  icon: Icons.dashboard,
                  // text: 'Dashboard',
                  iconSize: 26,
                ),
                GButton(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  icon: Icons.folder,
                  // text: 'Accounts',
                  iconSize: 26,
                ),
                GButton(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  iconSize: 26,
                  icon: Icons.paid,
                  // text: 'Manage',
                ),
                GButton(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  iconSize: 26,
                  icon: Icons.insert_chart,
                  // text: 'Analytics',
                ),
                GButton(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  iconSize: 26,
                  icon: Icons.sentiment_very_satisfied_rounded,
                  // text: 'Profile',
                ),
              ],
              selectedIndex: currentIndex,
              onTabChange: onTap,
            ),
          ),
        ),
      ),
    );
  }

  PageTransitionData _pageTransition() {
    return PageTransitionData(
      builder: (controller, child) => AnimatedBuilder(
        animation: Tween(begin: 0, end: 1).animate(controller),
        builder: (context, child) => Opacity(
          opacity: controller.value,
          child: Transform.scale(
            scale: 1.05 - (controller.value * 0.05),
            child: child,
          ),
        ),
        child: child,
      ),
      duration: 100,
      //direction: AnimationDirection.inAndOut,
    );
  }
}
