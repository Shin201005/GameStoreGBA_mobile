import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../services/game_service.dart';
import '../widgets/game_card.dart';
import '../theme/app_theme.dart';
import 'game_detail_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GameService _gameService = GameService();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: FutureBuilder<List<GameModel>>(
        future: _gameService.getGames(),
        builder: (context, snapshot) {
          final games = snapshot.data ?? [];
          final featuredGames = games.take(4).toList();

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // 🔥 Banner
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.accent2, colors.accent],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'GameStore Mobile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Chơi GBA game trực tiếp bằng EmulatorJS.',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SearchPage()),
                        );
                      },
                      icon: const Icon(Icons.search),
                      label: const Text('Tìm game'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: colors.accent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'Game nổi bật',
                style: TextStyle(
                  color: colors.text,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),

              if (snapshot.connectionState == ConnectionState.waiting)
                const Center(child: CircularProgressIndicator())
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: featuredGames.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.66,
                  ),
                  itemBuilder: (context, index) {
                    final game = featuredGames[index];

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
                ),
            ],
          );
        },
      ),
    );
  }
}
