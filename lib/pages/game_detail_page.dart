import 'package:flutter/material.dart';
import '../main.dart';
import '../models/game_model.dart';
import '../services/favorite_service.dart';
import 'play_game_page.dart';
import '../services/library_service.dart';

class GameDetailPage extends StatefulWidget {
  final GameModel game;

  const GameDetailPage({super.key, required this.game});

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  final FavoriteService _favoriteService = FavoriteService();
  bool _isFavorite = false;
  final LibraryService _libraryService = LibraryService();
  bool _isInLibrary = false;
  @override
  void initState() {
    super.initState();
    _loadFavorite();
    _loadLibrary();
  }

  void _loadFavorite() async {
    final result = await _favoriteService.isFavorite(widget.game.id);
    setState(() {
      _isFavorite = result;
    });
  }

  void _toggleFavorite() async {
    await _favoriteService.toggleFavorite(widget.game.id);
    _loadFavorite();
  }

  void _loadLibrary() async {
    final result = await _libraryService.isInLibrary(widget.game.id);
    setState(() {
      _isInLibrary = result;
    });
  }

  void _toggleLibrary() async {
    await _libraryService.toggleLibrary(widget.game.id);
    _loadLibrary();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isInLibrary ? 'Đã xóa khỏi thư viện' : 'Đã thêm vào thư viện',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.game.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                widget.game.cover,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    width: double.infinity,
                    height: 220,
                    color: AppColors.card2,
                    child: const Icon(
                      Icons.videogame_asset,
                      color: AppColors.accent,
                      size: 70,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            Text(
              widget.game.title,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                _InfoChip(text: widget.game.category, icon: Icons.category),
                const SizedBox(width: 10),
                _InfoChip(
                  text: widget.game.rating.toString(),
                  icon: Icons.star,
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Text(
              'Mô tả',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              widget.game.description,
              style: const TextStyle(
                color: AppColors.textSoft,
                height: 1.5,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PlayGamePage(
                        title: widget.game.title,
                        rom: widget.game.rom,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _toggleLibrary,
                    icon: Icon(_isInLibrary ? Icons.check : Icons.library_add),
                    label: Text(_isInLibrary ? 'Đã thêm' : 'Library'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.text,
                      side: const BorderSide(color: AppColors.border),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _toggleFavorite,
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : null,
                    ),
                    label: Text(_isFavorite ? 'Đã thích' : 'Favorite'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.text,
                      side: const BorderSide(color: AppColors.border),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String text;
  final IconData icon;

  const _InfoChip({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.accent),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: AppColors.textSoft)),
        ],
      ),
    );
  }
}
