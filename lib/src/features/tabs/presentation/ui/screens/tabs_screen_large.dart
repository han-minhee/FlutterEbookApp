import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/src/common/common.dart';
import 'package:flutter_ebook_app/src/features/features.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreenLarge extends ConsumerWidget {
  const TabsScreenLarge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        ExploreRoute(),
        SettingsRoute(),
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                leading: Image.asset(
                  'assets/images/app-icon.png',
                  height: 80,
                ),
                selectedIndex: tabsRouter.activeIndex,
                onDestinationSelected: (index) {
                  ref.read(currentTabNotifierProvider).value = index;
                  tabsRouter.setActiveIndex(index);
                },
                labelType: NavigationRailLabelType.all,
                useIndicator: true,
                indicatorColor:
                    context.theme.colorScheme.secondary.withValues(alpha: 0.5),
                destinations: const <NavigationRailDestination>[
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.explore),
                    label: Text('Explore'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    // selectedIcon: Icon(Icons.favorite),
                    label: Text('Settings'),
                  ),
                ],
                selectedIconTheme: IconThemeData(
                  color: context.theme.colorScheme.secondary,
                ),
                unselectedIconTheme: IconThemeData(color: Colors.grey[500]),
                unselectedLabelTextStyle: TextStyle(color: Colors.grey[500]),
                selectedLabelTextStyle: TextStyle(
                  color: context.theme.colorScheme.secondary,
                ),
              ),
              const VerticalDivider(thickness: 1, width: 2),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}
