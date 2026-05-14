import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final notifications = [
      {
        'title': 'Game mới được thêm',
        'content': 'Pokemon Emerald đã được thêm vào danh sách game.',
        'time': 'Hôm nay',
        'icon': Icons.sports_esports,
      },
      {
        'title': 'Cập nhật thư viện',
        'content': 'Bạn có thể thêm game vào Library để truy cập nhanh hơn.',
        'time': 'Hôm qua',
        'icon': Icons.library_books,
      },
      {
        'title': 'Thông báo hệ thống',
        'content': 'Dữ liệu app đang được lưu local bằng SharedPreferences.',
        'time': '2 ngày trước',
        'icon': Icons.info,
      },
      {
        'title': 'Game được yêu thích',
        'content':
            'Pokemon Leaf Green đang là game được yêu thích nhất tuần này.',
        'time': '3 ngày trước',
        'icon': Icons.favorite,
      },

      {
        'title': 'Cập nhật giao diện',
        'content':
            'Dark Mode, Light Mode và Pink Mode đã được thêm vào Settings.',
        'time': '4 ngày trước',
        'icon': Icons.palette,
      },

      {
        'title': 'Trang quản trị',
        'content':
            'Admin hiện có thể thay đổi trạng thái game và tài khoản người dùng.',
        'time': '1 tuần trước',
        'icon': Icons.admin_panel_settings,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Thông báo')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.card,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colors.border),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: colors.accent.withOpacity(0.15),
                  child: Icon(item['icon'] as IconData, color: colors.accent),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: TextStyle(
                          color: colors.text,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['content'] as String,
                        style: TextStyle(
                          color: colors.textSoft,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['time'] as String,
                        style: TextStyle(
                          color: colors.accent,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
