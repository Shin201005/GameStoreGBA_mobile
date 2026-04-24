import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../services/game_service.dart';
import '../theme/app_theme.dart';
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

  String _selectedCategory = 'All';
  List<String> _categories = ['All'];

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  Future<void> _loadGames() async {
    final games = await _gameService.getGames();

    if (!mounted) return;

    setState(() {
      _allGames = games;
      _filteredGames = games;
      _categories = [
        'All',
        ...games.map((game) => game.category).toSet().toList(),
      ];
      _isLoading = false;
    });
  }

  void _applyFilter({String? query, String? category}) {
    if (query != null) _query = query;
    if (category != null) _selectedCategory = category;

    setState(() {
      _filteredGames = _allGames.where((game) {
        final matchName = game.title.toLowerCase().contains(
          _query.toLowerCase(),
        );

        final matchCategory =
            _selectedCategory == 'All' || game.category == _selectedCategory;

        return matchName && matchCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                _applyFilter(query: value);
              },
              style: TextStyle(color: colors.text),
              decoration: InputDecoration(
                hintText: 'Tìm game...',
                hintStyle: TextStyle(color: colors.textSoft),
                prefixIcon: Icon(Icons.search, color: colors.textSoft),
                filled: true,
                fillColor: colors.card,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: colors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: colors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: colors.accent, width: 1.4),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 42,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;

                return ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) {
                    _applyFilter(category: category);
                  },
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : colors.text,
                    fontWeight: FontWeight.w600,
                  ),
                  selectedColor: colors.accent,
                  backgroundColor: colors.card,
                  side: BorderSide(color: colors.border),
                  checkmarkColor: Colors.white,
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          if (_isLoading)
            Expanded(
              child: Center(
                child: CircularProgressIndicator(color: colors.accent),
              ),
            )
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
                  childAspectRatio: 0.66,
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
