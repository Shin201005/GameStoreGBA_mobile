import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/admin_bottom_nav_bar.dart';

import 'admin_games_page.dart';
import 'admin_home_page.dart';
import 'admin_stats_page.dart';
import 'admin_users_page.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    AdminHomePage(),
    AdminGamesPage(),
    AdminUsersPage(),
    AdminStatsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.bg,

      body: IndexedStack(index: _currentIndex, children: _pages),

      bottomNavigationBar: AdminBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
