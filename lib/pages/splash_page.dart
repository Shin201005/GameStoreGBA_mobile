import 'package:flutter/material.dart';
import '../main.dart';
import '../services/auth_service.dart';
import 'login_page.dart';
import 'main_page.dart';
import 'onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _handleStart();
  }

  Future<void> _handleStart() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OnboardingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B0B12), Color(0xFF171726), Color(0xFF0B0B12)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.card,
              child: Icon(
                Icons.sports_esports,
                size: 42,
                color: AppColors.accent,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'GameStore Mobile',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.text,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Play • Save • Favorite',
              style: TextStyle(fontSize: 14, color: AppColors.textSoft),
            ),
            SizedBox(height: 28),
            CircularProgressIndicator(color: AppColors.accent),
          ],
        ),
      ),
    );
  }
}
