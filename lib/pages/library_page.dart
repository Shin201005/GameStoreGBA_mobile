import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../services/game_service.dart';
import '../services/library_service.dart';
import '../theme/app_theme.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/game_card.dart';
import 'game_detail_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final GameService _gameService = GameService();
  final LibraryService _libraryService = LibraryService();

  List<GameModel> _libraryGames = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLibrary();
  }

  Future<void> _loadLibrary() async {
    final allGames = await _gameService.getGames();
    final libraryIds = await _libraryService.getLibraryGames();

    final games = allGames.where((game) {
      return libraryIds.contains(game.id);
    }).toList();

    if (!mounted) return;

    setState(() {
      _libraryGames = games;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(title: const Text('Library')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: colors.accent))
          : _libraryGames.isEmpty
          ? const EmptyStateWidget(message: 'Thư viện đang trống')
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _libraryGames.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, index) {
                final game = _libraryGames[index];

                return GameCard(
                  game: game,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GameDetailPage(game: game),
                      ),
                    );

                    _loadLibrary();
                  },
                );
              },
            ),
    );
  }
}
