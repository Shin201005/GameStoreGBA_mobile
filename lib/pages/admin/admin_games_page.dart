import 'package:flutter/material.dart';

import '../../models/game_model.dart';
import '../../services/admin_status_service.dart';
import '../../services/game_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/game_card.dart';

class AdminGamesPage extends StatefulWidget {
  const AdminGamesPage({super.key});

  @override
  State<AdminGamesPage> createState() => _AdminGamesPageState();
}

class _AdminGamesPageState extends State<AdminGamesPage> {
  final gameService = GameService();
  final adminStatusService = AdminStatusService();

  List<GameModel> games = [];

  bool isLoading = true;

  String searchText = '';
  String selectedFilter = 'Tất cả';

  @override
  void initState() {
    super.initState();
    loadGames();
  }

  Future<void> loadGames() async {
    final data = await gameService.getGames();

    final updatedGames = <GameModel>[];

    for (final game in data) {
      final savedStatus = await adminStatusService.getGameStatus(game.id);

      updatedGames.add(game.copyWith(status: savedStatus ?? game.status));
    }

    setState(() {
      games = updatedGames;
      isLoading = false;
    });
  }

  List<GameModel> get filteredGames {
    return games.where((game) {
      final keyword = searchText.toLowerCase();

      final matchSearch =
          game.title.toLowerCase().contains(keyword) ||
          game.category.toLowerCase().contains(keyword);

      bool matchFilter = true;

      switch (selectedFilter) {
        case 'Đã duyệt':
          matchFilter = game.status == 'approved';
          break;
        case 'Chờ duyệt':
          matchFilter = game.status == 'pending';
          break;
        case 'Đã từ chối':
          matchFilter = game.status == 'rejected';
          break;
      }

      return matchSearch && matchFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(title: const Text('Trò chơi')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                style: TextStyle(color: colors.text),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm nội dung',
                  hintStyle: TextStyle(color: colors.textSoft),
                  prefixIcon: Icon(Icons.search, color: colors.textSoft),
                  filled: true,
                  fillColor: colors.card,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: colors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: colors.accent),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterButton(
                      text: 'Tất cả',
                      isSelected: selectedFilter == 'Tất cả',
                      onTap: () {
                        setState(() {
                          selectedFilter = 'Tất cả';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    _FilterButton(
                      text: 'Đã duyệt',
                      isSelected: selectedFilter == 'Đã duyệt',
                      onTap: () {
                        setState(() {
                          selectedFilter = 'Đã duyệt';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    _FilterButton(
                      text: 'Chờ duyệt',
                      isSelected: selectedFilter == 'Chờ duyệt',
                      onTap: () {
                        setState(() {
                          selectedFilter = 'Chờ duyệt';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    _FilterButton(
                      text: 'Đã từ chối',
                      isSelected: selectedFilter == 'Đã từ chối',
                      onTap: () {
                        setState(() {
                          selectedFilter = 'Đã từ chối';
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Tổng game: ${filteredGames.length}',
                style: TextStyle(
                  color: colors.text,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: colors.accent),
                      )
                    : filteredGames.isEmpty
                    ? Center(
                        child: Text(
                          'Không tìm thấy game',
                          style: TextStyle(color: colors.textSoft),
                        ),
                      )
                    : GridView.builder(
                        itemCount: filteredGames.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 18,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.72,
                            ),
                        itemBuilder: (context, index) {
                          final game = filteredGames[index];

                          return Stack(
                            children: [
                              GameCard(game: game, onTap: () {}),

                              Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _statusColor(game.status),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    _statusText(game.status),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: PopupMenuButton<String>(
                                  color: colors.card,
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: colors.text,
                                  ),
                                  onSelected: (value) async {
                                    final originalIndex = games.indexWhere(
                                      (g) => g.id == game.id,
                                    );

                                    if (originalIndex == -1) return;

                                    setState(() {
                                      games[originalIndex] = game.copyWith(
                                        status: value,
                                      );
                                    });

                                    await adminStatusService.saveGameStatus(
                                      game.id,
                                      value,
                                    );
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 'approved',
                                      child: Text(
                                        'Duyệt',
                                        style: TextStyle(color: colors.text),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'pending',
                                      child: Text(
                                        'Chờ duyệt',
                                        style: TextStyle(color: colors.text),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'rejected',
                                      child: Text(
                                        'Từ chối',
                                        style: TextStyle(color: colors.text),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
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

class _FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? colors.accent : colors.card2,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? colors.accent : colors.border),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : colors.text,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
