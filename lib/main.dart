import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/splash_page.dart';
import 'theme/app_theme.dart';

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _themeMode = 'dark';

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _themeMode = prefs.getString('app_theme_mode') ?? 'dark';
    });
  }

  Future<void> changeTheme(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_theme_mode', mode);

    setState(() {
      _themeMode = mode;
    });
  }

  ThemeData _buildDarkTheme() {
    return ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: const Color(0xFF0B0B12),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0B0B12),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Color(0xFFF5F7FF),
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: Color(0xFFF5F7FF)),
      ),
      extensions: const [
        AppThemeColors(
          bg: Color(0xFF0B0B12),
          bgSoft: Color(0xFF151522),
          card: Color(0xFF1C1C2B),
          card2: Color(0xFF24243A),
          border: Color(0xFF31314A),
          text: Color(0xFFF5F7FF),
          textSoft: Color(0xFFB7B9C9),
          accent: Color(0xFF8B5CF6),
          accent2: Color(0xFF6D28D9),
          danger: Color(0xFFFF5A7A),
        ),
      ],
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData.light(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: const Color(0xFFF6F4FF),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF6F4FF),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Color(0xFF171421),
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: Color(0xFF171421)),
      ),
      extensions: const [
        AppThemeColors(
          bg: Color(0xFFF6F4FF),
          bgSoft: Color(0xFFFFFFFF),
          card: Color(0xFFFFFFFF),
          card2: Color(0xFFEDE9FE),
          border: Color(0xFFD8D0F0),
          text: Color(0xFF171421),
          textSoft: Color(0xFF6B647A),
          accent: Color(0xFF8B5CF6),
          accent2: Color(0xFF6D28D9),
          danger: Color(0xFFE11D48),
        ),
      ],
    );
  }

  ThemeData _buildPinkTheme() {
    return ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: const Color(0xFF160B14),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF160B14),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Color(0xFFFFF5FB),
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: Color(0xFFFFF5FB)),
      ),
      extensions: const [
        AppThemeColors(
          bg: Color(0xFF160B14),
          bgSoft: Color(0xFF24101F),
          card: Color(0xFF2E1628),
          card2: Color(0xFF3A1A31),
          border: Color(0xFF5A2A4D),
          text: Color(0xFFFFF5FB),
          textSoft: Color(0xFFE8BFD8),
          accent: Color(0xFFFF4FB8),
          accent2: Color(0xFFDB2777),
          danger: Color(0xFFFF5A7A),
        ),
      ],
    );
  }

  ThemeData get _theme {
    if (_themeMode == 'light') return _buildLightTheme();
    if (_themeMode == 'pink') return _buildPinkTheme();
    return _buildDarkTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GameStore Mobile',
      theme: _theme,
      home: const SplashPage(),
    );
  }
}
