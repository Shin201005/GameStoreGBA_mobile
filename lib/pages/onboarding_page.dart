import 'package:flutter/material.dart';
import '../main.dart';
import '../services/auth_service.dart';
import '../widgets/app_button.dart';
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

  Widget _featureItem(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.accent.withOpacity(0.16),
            child: Icon(icon, color: AppColors.accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSoft,
                    fontSize: 13,
                  ),
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
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  Icons.sports_esports,
                  size: 46,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Kho game GBA trong túi của bạn',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Đăng nhập local, lưu game yêu thích và chuẩn bị sẵn nền để chơi bằng emulator.',
                style: TextStyle(
                  color: AppColors.textSoft,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              _featureItem(
                Icons.login,
                'Đăng nhập nhanh',
                'Tài khoản local đơn giản cho bản demo.',
              ),
              const SizedBox(height: 12),
              _featureItem(
                Icons.favorite,
                'Lưu game yêu thích',
                'Sẵn khung cho library và favorites ở tuần sau.',
              ),
              const SizedBox(height: 12),
              _featureItem(
                Icons.gamepad,
                'Sẵn luồng Play Game',
                'Chuẩn bị sẵn cho phần EmulatorJS tuần 2.',
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
