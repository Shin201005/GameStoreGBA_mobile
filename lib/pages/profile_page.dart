import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import 'settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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

              _infoCard(context, 'Email', user?.email ?? 'Chưa có'),
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
            ],
          );
        },
      ),
    );
  }
}
