import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'package:tugsuyoo/water/ui/home/bottom_nav_bar.dart';
import 'package:tugsuyoo/water/ui/hydration_pool/hydration_pool_page.dart';
import 'package:tugsuyoo/water/ui/hydration_progress/hydration_progress_page.dart';
import 'package:tugsuyoo/water/ui/settings/settings_page.dart';

class WaterPage extends StatefulWidget {
  @override
  _WaterPageState createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  final _pages = <Widget>[
    HydrationPoolPage(),
    HydrationProgressPage(),
    SettingsPage(),
  ];
  int _currentPage = 0;

  void _changePage(int index) {
    if (index == _currentPage) return;

    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageTransitionSwitcher(
            transitionBuilder: (
              child,
              primaryAnimation,
              secondaryAnimation,
            ) {
              return FadeThroughTransition(
                fillColor: Theme.of(context).backgroundColor,
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: _pages[_currentPage],
          ),
          BottomNavBar(
             currentPage: _currentPage,
            onChanged: _changePage,
           ),
        ],
      ),
    );
  }
}
