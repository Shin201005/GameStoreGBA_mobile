import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../services/game_service.dart';
import '../theme/app_theme.dart';
import '../widgets/game_card.dart';
import '../widgets/empty_state_widget.dart';
import 'game_detail_page.dart';
import 'search_page.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final GameService _gameService = GameService();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: colors.text),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<GameModel>>(
        future: _gameService.getGames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: colors.accent),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Lỗi tải danh sách game',
                style: TextStyle(color: colors.text),
              ),
            );
          }

          final games = snapshot.data ?? [];

          if (games.isEmpty) {
            return const EmptyStateWidget(message: 'Chưa có game nào');
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: games.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.66,
            ),
            itemBuilder: (context, index) {
              final game = games[index];

              return GameCard(
                game: game,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GameDetailPage(game: game),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
