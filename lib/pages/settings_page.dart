import 'package:flutter/material.dart';
import '../main.dart';
import '../services/auth_service.dart';
import 'login_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _logout(BuildContext context) async {
    final authService = AuthService();
    await authService.logout();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  Widget _tile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Color iconColor = AppColors.accent,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14, //tăng chiều cao
        ),
        leading: CircleAvatar(
          radius: 24, //icon to hơn
          backgroundColor: iconColor.withOpacity(0.15),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.w700,
            fontSize: 16, //chữ to hơn chút
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.textSoft,
            fontSize: 13,
            height: 1.3, // giãn dòng
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textSoft),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _tile(
            icon: Icons.info_outline,
            title: 'Thông tin app',
            subtitle: 'App chơi game GBA miễn phí',
          ),
          _tile(
            icon: Icons.storage,
            title: 'Dữ liệu local',
            subtitle:
                'Tài khoản, thư viện và yêu thích được lưu bằng SharedPreferences',
          ),
          _tile(
            icon: Icons.notifications,
            title: 'Thông báo',
            subtitle: 'Bật/tắt thông báo trong app',
          ),
          _tile(
            icon: Icons.dark_mode,
            title: 'Giao diện',
            subtitle: 'Chế độ tối (Dark mode)',
          ),
          _tile(
            icon: Icons.info,
            title: 'Về chúng tôi',
            subtitle: 'Nhóm Pinky',
          ),
          _tile(icon: Icons.verified, title: 'Phiên bản', subtitle: 'v1.0.0'),
          _tile(
            icon: Icons.logout,
            title: 'Đăng xuất',
            subtitle: 'Thoát khỏi tài khoản local hiện tại',
            iconColor: AppColors.danger,
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
