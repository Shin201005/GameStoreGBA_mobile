import 'package:flutter/material.dart';

import '../../models/game_model.dart';
import '../../services/game_service.dart';
import '../../theme/app_theme.dart';
import 'admin_total_games_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final gameService = GameService();

  List<GameModel> games = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadGames();
  }

  Future<void> loadGames() async {
    final data = await gameService.getGames();

    setState(() {
      games = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final approvedCount = games.where((g) => g.status == 'approved').length;

    final pendingCount = games.where((g) => g.status == 'pending').length;

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(title: const Text('Trang chủ Admin')),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: colors.accent))
          : SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    height: 190,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colors.bgSoft,
                      border: Border.all(color: colors.border),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GameStore Admin',
                          style: TextStyle(
                            color: colors.text,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Quản lý game, người dùng và thống kê',
                          style: TextStyle(color: colors.textSoft),
                        ),

                        const Spacer(),

                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '$approvedCount đã duyệt',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '$pendingCount chờ duyệt',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _StatBox(title: 'Người chơi', value: '12'),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _StatBox(
                          title: 'Game hiện có',
                          value: '${games.length}',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AdminTotalGamesPage(),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _StatBox(title: 'Doanh thu', value: '0đ'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  Text(
                    'Các hoạt động gần đây',
                    style: TextStyle(
                      color: colors.text,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.card,
                      border: Border.all(color: colors.border),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        _ActivityItem(
                          icon: Icons.login,
                          title: 'Admin vừa đăng nhập vào hệ thống',
                        ),

                        Divider(color: colors.border),

                        _ActivityItem(
                          icon: Icons.sports_esports,
                          title: 'Pokemon Emerald đã được tải',
                        ),

                        Divider(color: colors.border),

                        _ActivityItem(
                          icon: Icons.favorite,
                          title: 'Pokemon Leaf Green được thêm vào yêu thích',
                        ),

                        Divider(color: colors.border),

                        _ActivityItem(
                          icon: Icons.library_books,
                          title:
                              'Dragon Ball Legacy of Goku được thêm vào thư viện',
                        ),

                        Divider(color: colors.border),

                        _ActivityItem(
                          icon: Icons.star,
                          title: 'Pokemon Emerald nhận đánh giá 4.7 sao',
                        ),

                        Divider(color: colors.border),

                        _ActivityItem(
                          icon: Icons.person_add,
                          title: 'Người dùng mới đã đăng ký tài khoản',
                        ),

                        Divider(color: colors.border),

                        _ActivityItem(
                          icon: Icons.admin_panel_settings,
                          title: 'Admin đã duyệt một trò chơi mới',
                        ),

                        Divider(color: colors.border),

                        _ActivityItem(
                          icon: Icons.update,
                          title: 'Dữ liệu game đã được cập nhật',
                        ),

                        Divider(color: colors.border),

                        _ActivityItem(
                          icon: Icons.notifications,
                          title: 'Thông báo hệ thống đã được gửi',
                        ),

                        Divider(color: colors.border),

                        _ActivityItem(
                          icon: Icons.security,
                          title: 'Trạng thái tài khoản người dùng đã thay đổi',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onTap;

  const _StatBox({required this.title, required this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 105,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.card,
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.analytics, color: colors.accent, size: 24),

            const Spacer(),

            Text(
              value,
              style: TextStyle(
                color: colors.text,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colors.textSoft, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ActivityItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        Icon(icon, color: colors.accent, size: 22),

        const SizedBox(width: 12),

        Expanded(
          child: Text(title, style: TextStyle(color: colors.text)),
        ),
      ],
    );
  }
}
