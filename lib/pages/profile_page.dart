import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import 'settings_page.dart';
import 'admin/admin_main_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String gender = 'Nam';
  String birthday = '14/05/2004';
  String bio = 'Yêu thích game GBA và Pokemon';

  Widget _infoCard(BuildContext context, String title, String value) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: colors.textSoft, fontSize: 13)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: colors.text,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _editableInfoCard({
    required BuildContext context,
    required String title,
    required String value,
    required Function(String) onSave,
  }) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: colors.textSoft, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showEditDialog(
                context: context,
                title: title,
                oldValue: value,
                onSave: onSave,
              );
            },
            icon: Icon(Icons.edit, color: colors.accent),
          ),
        ],
      ),
    );
  }

  void _showEditDialog({
    required BuildContext context,
    required String title,
    required String oldValue,
    required Function(String) onSave,
  }) {
    final colors = context.colors;
    final controller = TextEditingController(text: oldValue);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: colors.card,
          title: Text('Sửa $title', style: TextStyle(color: colors.text)),
          content: TextField(
            controller: controller,
            style: TextStyle(color: colors.text),
            decoration: InputDecoration(
              hintText: title,
              hintStyle: TextStyle(color: colors.textSoft),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colors.accent),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Hủy', style: TextStyle(color: colors.textSoft)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.accent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                onSave(controller.text.trim());
                Navigator.pop(context);
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder(
        future: authService.getCurrentUser(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          final isAdmin = user?.username.toLowerCase() == 'admin';

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: colors.accent),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colors.bgSoft,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: colors.border),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: colors.accent.withOpacity(0.2),
                      child: Icon(Icons.person, size: 40, color: colors.accent),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      user?.username ?? 'Người dùng',
                      style: TextStyle(
                        color: colors.text,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.email ?? 'Chưa có email',
                      style: TextStyle(color: colors.textSoft, fontSize: 14),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              _infoCard(context, 'Tên người dùng', user?.username ?? 'Chưa có'),
              const SizedBox(height: 12),

              _infoCard(
                context,
                'Trạng thái tài khoản',
                isAdmin ? 'Quản trị viên' : 'Người dùng',
              ),
              const SizedBox(height: 12),

              _infoCard(context, 'Email', user?.email ?? 'Chưa có'),
              const SizedBox(height: 12),

              _editableInfoCard(
                context: context,
                title: 'Giới tính',
                value: gender,
                onSave: (value) {
                  setState(() {
                    gender = value.isEmpty ? gender : value;
                  });
                },
              ),

              const SizedBox(height: 12),

              _editableInfoCard(
                context: context,
                title: 'Ngày sinh',
                value: birthday,
                onSave: (value) {
                  setState(() {
                    birthday = value.isEmpty ? birthday : value;
                  });
                },
              ),

              const SizedBox(height: 12),

              _editableInfoCard(
                context: context,
                title: 'Thông tin cá nhân',
                value: bio,
                onSave: (value) {
                  setState(() {
                    bio = value.isEmpty ? bio : value;
                  });
                },
              ),

              const SizedBox(height: 18),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.card,
                  foregroundColor: colors.text,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  side: BorderSide(color: colors.border),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsPage()),
                  );
                },
                icon: const Icon(Icons.settings),
                label: const Text(
                  'Mở Settings',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),

              if (isAdmin) ...[
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.accent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AdminMainPage()),
                    );
                  },
                  icon: const Icon(Icons.admin_panel_settings),
                  label: const Text(
                    'Mở trang quản trị',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
