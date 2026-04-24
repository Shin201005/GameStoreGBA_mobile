import 'package:flutter/material.dart';
import '../main.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
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

  void _showThemeDialog(BuildContext context) {
    final colors = context.colors;

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.dark_mode, color: colors.accent),
                title: Text('Dark Mode', style: TextStyle(color: colors.text)),
                onTap: () {
                  MyApp.of(context)?.changeTheme('dark');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.light_mode, color: Colors.orange),
                title: Text('Light Mode', style: TextStyle(color: colors.text)),
                onTap: () {
                  MyApp.of(context)?.changeTheme('light');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite, color: Colors.pinkAccent),
                title: Text('Pink Mode', style: TextStyle(color: colors.text)),
                onTap: () {
                  MyApp.of(context)?.changeTheme('pink');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _tile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Color? iconColor,
  }) {
    final colors = context.colors;
    final activeIconColor = iconColor ?? colors.accent;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: activeIconColor.withOpacity(0.15),
          child: Icon(icon, color: activeIconColor),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: colors.text,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: colors.textSoft, fontSize: 13, height: 1.3),
        ),
        trailing: Icon(Icons.chevron_right, color: colors.textSoft),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _tile(
            context: context,
            icon: Icons.info_outline,
            title: 'Thông tin app',
            subtitle: 'App chơi game GBA miễn phí',
          ),
          _tile(
            context: context,
            icon: Icons.storage,
            title: 'Dữ liệu local',
            subtitle:
                'Tài khoản, thư viện và yêu thích được lưu bằng SharedPreferences',
          ),
          _tile(
            context: context,
            icon: Icons.notifications,
            title: 'Thông báo',
            subtitle: 'Bật/tắt thông báo trong app',
          ),
          _tile(
            context: context,
            icon: Icons.dark_mode,
            title: 'Giao diện',
            subtitle: 'Dark / Light / Pink mode',
            onTap: () => _showThemeDialog(context),
          ),
          _tile(
            context: context,
            icon: Icons.info,
            title: 'Về chúng tôi',
            subtitle: 'Nhóm Pinky',
          ),
          _tile(
            context: context,
            icon: Icons.verified,
            title: 'Phiên bản',
            subtitle: 'v1.0.0',
          ),
          _tile(
            context: context,
            icon: Icons.logout,
            title: 'Đăng xuất',
            subtitle: 'Thoát khỏi tài khoản local hiện tại',
            iconColor: colors.danger,
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
