import 'package:flutter/material.dart';
import '../main.dart';
import '../models/game_model.dart';
import '../services/game_service.dart';
import '../widgets/game_card.dart';
import '../widgets/empty_state_widget.dart';
import 'game_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GameService _gameService = GameService();
  List<GameModel> _allGames = [];
  List<GameModel> _filteredGames = [];

  bool _isLoading = true;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  Future<void> _loadGames() async {
    final games = await _gameService.getGames();
    setState(() {
      _allGames = games;
      _filteredGames = games;
      _isLoading = false;
    });
  }

  void _search(String value) {
    setState(() {
      _query = value;

      _filteredGames = _allGames.where((game) {
        return game.title.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: _search,
              style: const TextStyle(color: AppColors.text),
              decoration: InputDecoration(
                hintText: 'Tìm game...',
                hintStyle: const TextStyle(color: AppColors.textSoft),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.card,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            ),
          ),

          if (_isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_filteredGames.isEmpty)
            const Expanded(
              child: EmptyStateWidget(message: 'Không tìm thấy game'),
            )
          else
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _filteredGames.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final game = _filteredGames[index];

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
            ),
        ],
      ),
    );
  }
}
