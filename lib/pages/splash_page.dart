import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
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
    final colors = context.colors;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.bg, colors.bgSoft, colors.bg],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 44,
              backgroundColor: colors.card,
              child: Icon(Icons.sports_esports, size: 42, color: colors.accent),
            ),
            const SizedBox(height: 20),
            Text(
              'GameStore Mobile',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: colors.text,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Play • Save • Favorite',
              style: TextStyle(fontSize: 14, color: colors.textSoft),
            ),
            const SizedBox(height: 28),
            CircularProgressIndicator(color: colors.accent),
          ],
        ),
      ),
    );
  }
}
