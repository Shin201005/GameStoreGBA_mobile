import 'package:flutter/material.dart';

import '../../models/game_model.dart';
import '../../services/game_service.dart';
import '../../theme/app_theme.dart';

class AdminTotalGamesPage extends StatefulWidget {
  const AdminTotalGamesPage({super.key});

  @override
  State<AdminTotalGamesPage> createState() => _AdminTotalGamesPageState();
}

class _AdminTotalGamesPageState extends State<AdminTotalGamesPage> {
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

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(title: const Text('Tổng game hiện có')),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: colors.accent))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: games.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Tổng số: ${games.length} game',
                      style: TextStyle(
                        color: colors.text,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  );
                }

                final game = games[index - 1];

                return Container(
                  height: 130,
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.card,
                    border: Border.all(color: colors.border),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          game.cover,
                          width: 86,
                          height: 106,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return Container(
                              width: 86,
                              height: 106,
                              color: colors.card2,
                              child: Icon(
                                Icons.videogame_asset,
                                color: colors.accent,
                                size: 32,
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              game.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: colors.text,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              game.category,
                              style: TextStyle(
                                color: colors.textSoft,
                                fontSize: 13,
                              ),
                            ),

                            const Spacer(),

                            Row(
                              children: [
                                Icon(
                                  _statusIcon(game.status),
                                  color: _statusColor(game.status),
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _statusText(game.status),
                                  style: TextStyle(
                                    color: colors.textSoft,
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Miễn phí',
                                  style: TextStyle(
                                    color: colors.accent,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
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

  Color _statusColor(String status) {
    switch (status) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'approved':
        return Icons.check_circle;
      case 'pending':
        return Icons.hourglass_bottom;
      case 'rejected':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  String _statusText(String status) {
    switch (status) {
      case 'approved':
        return 'Đã duyệt';
      case 'pending':
        return 'Chờ duyệt';
      case 'rejected':
        return 'Từ chối';
      default:
        return status;
    }
  }
}
