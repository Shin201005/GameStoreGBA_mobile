import 'package:flutter/material.dart';
import 'pages/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class AppColors {
  static const Color bg = Color(0xFF0B0B12);
  static const Color bgSoft = Color(0xFF151522);
  static const Color card = Color(0xFF1C1C2B);
  static const Color card2 = Color(0xFF24243A);
  static const Color border = Color(0xFF31314A);
  static const Color text = Color(0xFFF5F7FF);
  static const Color textSoft = Color(0xFFB7B9C9);
  static const Color accent = Color(0xFF8B5CF6);
  static const Color accent2 = Color(0xFF6D28D9);
  static const Color danger = Color(0xFFFF5A7A);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData.dark(useMaterial3: true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GameStore Mobile',
      theme: base.copyWith(
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.accent,
          brightness: Brightness.dark,
          background: AppColors.bg,
          surface: AppColors.card,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.bg,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: AppColors.text,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          iconTheme: IconThemeData(color: AppColors.text),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.w800,
          ),
          headlineMedium: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(color: AppColors.text, fontSize: 16),
          bodyMedium: TextStyle(color: AppColors.textSoft, fontSize: 14),
        ),
      ),
      home: const SplashPage(),
    );
  }
}
