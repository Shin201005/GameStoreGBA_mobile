import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin app')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _card(
            context,
            icon: Icons.sports_esports,
            title: 'GameStore GBA',
            content:
                'GameStore GBA là ứng dụng chơi game giả lập GBA trên mobile. Ứng dụng cho phép người dùng xem danh sách game, xem chi tiết, thêm yêu thích, thêm thư viện và chơi game thông qua EmulatorJS.',
          ),
          _card(
            context,
            icon: Icons.storage,
            title: 'Dữ liệu',
            content:
                'Phiên bản demo không sử dụng database thật. Tài khoản, thư viện, yêu thích và trạng thái quản trị được lưu local bằng SharedPreferences.',
          ),
          _card(
            context,
            icon: Icons.verified,
            title: 'Phiên bản',
            content: 'Phiên bản hiện tại: v1.0.0\nNền tảng: Flutter Mobile',
          ),
        ],
      ),
    );
  }

  Widget _card(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    final colors = context.colors;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colors.accent),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: TextStyle(
                    color: colors.textSoft,
                    fontSize: 14,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
