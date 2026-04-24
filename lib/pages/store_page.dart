import 'package:flutter/material.dart';
import '../main.dart';
import '../models/game_model.dart';
import '../services/game_service.dart';
import '../widgets/game_card.dart';
import 'game_detail_page.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final GameService _gameService = GameService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Store')),
      body: FutureBuilder<List<GameModel>>(
        future: _gameService.getGames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Lỗi tải danh sách game',
                style: TextStyle(color: AppColors.text),
              ),
            );
          }

          final games = snapshot.data ?? [];

          if (games.isEmpty) {
            return const Center(
              child: Text(
                'Chưa có game nào',
                style: TextStyle(color: AppColors.textSoft),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: games.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.72,
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
