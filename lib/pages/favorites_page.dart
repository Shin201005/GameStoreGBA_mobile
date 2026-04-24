import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../services/game_service.dart';
import '../services/favorite_service.dart';
import '../widgets/game_card.dart';
import '../widgets/empty_state_widget.dart';
import 'game_detail_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final GameService _gameService = GameService();
  final FavoriteService _favoriteService = FavoriteService();

  List<GameModel> _favoriteGames = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final allGames = await _gameService.getGames();
    final favoriteIds = await _favoriteService.getFavorites();

    final favorites = allGames
        .where((game) => favoriteIds.contains(game.id))
        .toList();

    setState(() {
      _favoriteGames = favorites;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoriteGames.isEmpty
          ? const EmptyStateWidget(message: 'Chưa có game yêu thích')
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _favoriteGames.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final game = _favoriteGames[index];

                return GameCard(
                  game: game,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GameDetailPage(game: game),
                      ),
                    );

                    _loadFavorites();
                  },
                );
              },
            ),
    );
  }
}
