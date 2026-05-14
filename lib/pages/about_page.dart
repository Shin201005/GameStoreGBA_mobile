import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(title: const Text('Về chúng tôi')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: colors.bgSoft,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: colors.border),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 42,
                  backgroundColor: colors.accent.withOpacity(0.18),
                  child: Icon(Icons.groups, size: 42, color: colors.accent),
                ),
                const SizedBox(height: 14),
                Text(
                  'Nhóm Pinky',
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Nhóm phát triển ứng dụng GameStore GBA Mobile.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.textSoft,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _section(
            context,
            title: 'Mục tiêu',
            content:
                'Xây dựng một ứng dụng mobile đơn giản giúp người dùng xem danh sách game GBA, tìm kiếm game, lưu game yêu thích và chơi game trực tiếp bằng trình giả lập.',
          ),
          _section(
            context,
            title: 'Công nghệ sử dụng',
            content:
                'Ứng dụng được xây dựng bằng Flutter. Dữ liệu demo được đọc từ file JSON và dữ liệu người dùng được lưu local bằng SharedPreferences.',
          ),
          _section(
            context,
            title: 'Ghi chú',
            content:
                'Đây là phiên bản demo phục vụ học tập, chưa triển khai database, server thật hoặc hệ thống thanh toán.',
          ),
        ],
      ),
    );
  }

  Widget _section(
    BuildContext context, {
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
    );
  }
}
