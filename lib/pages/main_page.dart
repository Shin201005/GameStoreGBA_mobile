import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'favorites_page.dart';
import 'home_page.dart';
import 'library_page.dart';
import 'profile_page.dart';
import 'store_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    const HomePage(),
    const StorePage(),
    const LibraryPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
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
