import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/app_button.dart';
import '../theme/app_theme.dart';
import 'login_page.dart';
import 'main_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  Future<void> _start(BuildContext context) async {
    final authService = AuthService();
    final isLoggedIn = await authService.isLoggedIn();

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => isLoggedIn ? const MainPage() : const LoginPage(),
      ),
    );
  }

  Widget _featureItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: colors.accent.withOpacity(0.16),
            child: Icon(icon, color: colors.accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: colors.textSoft, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  color: colors.card,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: colors.border),
                ),
                child: Icon(
                  Icons.sports_esports,
                  size: 46,
                  color: colors.accent,
                ),
              ),

              const SizedBox(height: 28),

              Text(
                'Kho game GBA trong túi của bạn',
                style: TextStyle(
                  color: colors.text,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Đăng nhập local, lưu game yêu thích và chuẩn bị sẵn nền để chơi bằng emulator.',
                style: TextStyle(
                  color: colors.textSoft,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 28),

              _featureItem(
                context,
                Icons.login,
                'Đăng nhập nhanh',
                'Tạo tài khoản local, đăng nhập nhanh chóng mà không cần mạng.',
              ),
              const SizedBox(height: 12),

              _featureItem(
                context,
                Icons.favorite,
                'Lưu game yêu thích',
                'Lưu lại game bạn thích để dễ dàng tìm lại sau này.',
              ),
              const SizedBox(height: 12),

              _featureItem(
                context,
                Icons.gamepad,
                'Chơi bằng Emulator',
                'Cung cấp nền tảng để tích hợp emulator và chơi game GBA GB GBC ngay trong app.',
              ),

              const Spacer(),

              AppButton(
                text: 'Bắt đầu ngay',
                icon: Icons.arrow_forward,
                onPressed: () => _start(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
