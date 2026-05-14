import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../services/favorite_service.dart';
import '../services/library_service.dart';
import '../theme/app_theme.dart';
import 'play_game_page.dart';

class GameDetailPage extends StatefulWidget {
  final GameModel game;

  const GameDetailPage({super.key, required this.game});

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  final FavoriteService _favoriteService = FavoriteService();
  final LibraryService _libraryService = LibraryService();

  bool _isFavorite = false;
  bool _isInLibrary = false;

  int selectedRating = 5;

  final TextEditingController reviewController = TextEditingController();

  List<Map<String, dynamic>> reviews = [
    {
      'username': 'pokemon_master',
      'rating': 5,
      'comment': 'Game rất hay, chơi mượt và không bị lag trên điện thoại.',
    },
    {
      'username': 'gba_fan',
      'rating': 4,
      'comment': 'Điều khiển ổn nhưng nút ảo hơi nhỏ trên màn hình.',
    },
    {
      'username': 'retro_player',
      'rating': 5,
      'comment': 'Gợi nhớ tuổi thơ, thích nhất phần giao diện tối.',
    },
    {
      'username': 'admin',
      'rating': 5,
      'comment': 'Game đã được kiểm tra và hoạt động ổn định.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadFavorite();
    _loadLibrary();
  }

  Future<void> _loadFavorite() async {
    final result = await _favoriteService.isFavorite(widget.game.id);

    if (!mounted) return;

    setState(() => _isFavorite = result);
  }

  Future<void> _toggleFavorite() async {
    await _favoriteService.toggleFavorite(widget.game.id);
    await _loadFavorite();
  }

  Future<void> _loadLibrary() async {
    final result = await _libraryService.isInLibrary(widget.game.id);

    if (!mounted) return;

    setState(() => _isInLibrary = result);
  }

  Future<void> _toggleLibrary() async {
    final wasInLibrary = _isInLibrary;

    await _libraryService.toggleLibrary(widget.game.id);

    await _loadLibrary();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          wasInLibrary ? 'Đã xóa khỏi thư viện' : 'Đã thêm vào thư viện',
        ),
      ),
    );
  }

  void _submitReview() {
    final text = reviewController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      reviews.insert(0, {
        'username': 'Bạn',
        'rating': selectedRating,
        'comment': text,
      });

      reviewController.clear();

      selectedRating = 5;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã gửi đánh giá')));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

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
                    color: colors.card2,

                    child: Icon(
                      Icons.videogame_asset,
                      color: colors.accent,
                      size: 70,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Text(
              widget.game.title,

              style: TextStyle(
                color: colors.text,
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

            Text(
              'Mô tả',

              style: TextStyle(
                color: colors.text,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              widget.game.description,

              style: TextStyle(
                color: colors.textSoft,
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
                  backgroundColor: colors.accent,
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
                      foregroundColor: colors.text,
                      side: BorderSide(color: colors.border),
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

                      color: _isFavorite ? Colors.red : colors.text,
                    ),

                    label: Text(_isFavorite ? 'Đã thích' : 'Favorite'),

                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.text,
                      side: BorderSide(color: colors.border),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            const _RatingSummary(
              average: 4.4,
              totalReviews: '45,6 N',
              ratingCounts: {5: 80, 4: 14, 3: 8, 2: 4, 1: 6},
            ),

            const SizedBox(height: 18),

            _AddReviewBox(
              selectedRating: selectedRating,
              controller: reviewController,

              onRatingChanged: (value) {
                setState(() {
                  selectedRating = value;
                });
              },

              onSubmit: _submitReview,
            ),

            const SizedBox(height: 20),

            Text(
              'Bài đánh giá nổi bật',

              style: TextStyle(
                color: colors.text,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 14),

            ...reviews.map((review) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),

                child: _ReviewCard(
                  username: review['username'],
                  rating: review['rating'],
                  comment: review['comment'],
                ),
              );
            }),
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
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colors.border),
      ),

      child: Row(
        children: [
          Icon(icon, size: 16, color: colors.accent),

          const SizedBox(width: 6),

          Text(text, style: TextStyle(color: colors.textSoft)),
        ],
      ),
    );
  }
}

class _RatingSummary extends StatelessWidget {
  final double average;
  final String totalReviews;
  final Map<int, int> ratingCounts;

  const _RatingSummary({
    required this.average,
    required this.totalReviews,
    required this.ratingCounts,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final maxValue = ratingCounts.values.reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            'Xếp hạng và đánh giá',

            style: TextStyle(
              color: colors.text,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Column(
                children: [
                  Text(
                    average.toStringAsFixed(1).replaceAll('.', ','),

                    style: TextStyle(
                      color: colors.text,
                      fontSize: 48,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < average.round()
                            ? Icons.star
                            : Icons.star_border,

                        color: colors.accent,
                        size: 16,
                      );
                    }),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '$totalReviews bài đánh giá',

                    style: TextStyle(color: colors.textSoft, fontSize: 12),
                  ),
                ],
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  children: [5, 4, 3, 2, 1].map((star) {
                    final value = ratingCounts[star] ?? 0;

                    final percent = maxValue == 0 ? 0.0 : value / maxValue;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 7),

                      child: Row(
                        children: [
                          SizedBox(
                            width: 12,

                            child: Text(
                              '$star',

                              style: TextStyle(
                                color: colors.textSoft,
                                fontSize: 12,
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(99),

                              child: LinearProgressIndicator(
                                value: percent,
                                minHeight: 9,
                                backgroundColor: colors.bgSoft,

                                valueColor: AlwaysStoppedAnimation<Color>(
                                  colors.accent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddReviewBox extends StatelessWidget {
  final int selectedRating;
  final TextEditingController controller;
  final Function(int) onRatingChanged;
  final VoidCallback onSubmit;

  const _AddReviewBox({
    required this.selectedRating,
    required this.controller,
    required this.onRatingChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            'Viết đánh giá của bạn',

            style: TextStyle(
              color: colors.text,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: List.generate(5, (index) {
              final star = index + 1;

              return IconButton(
                onPressed: () => onRatingChanged(star),

                icon: Icon(
                  star <= selectedRating ? Icons.star : Icons.star_border,

                  color: Colors.amber,
                ),
              );
            }),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: controller,
            maxLines: 3,
            style: TextStyle(color: colors.text),

            decoration: InputDecoration(
              hintText: 'Nhập bình luận của bạn...',
              hintStyle: TextStyle(color: colors.textSoft),
              filled: true,
              fillColor: colors.bgSoft,

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: colors.border),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: colors.accent),
              ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,

            child: ElevatedButton.icon(
              onPressed: onSubmit,
              icon: const Icon(Icons.send),
              label: const Text('Gửi đánh giá'),

              style: ElevatedButton.styleFrom(
                backgroundColor: colors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String username;
  final int rating;
  final String comment;

  const _ReviewCard({
    required this.username,
    required this.rating,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: colors.accent.withOpacity(0.18),

                child: Text(
                  username[0].toUpperCase(),

                  style: TextStyle(
                    color: colors.accent,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      username,

                      style: TextStyle(
                        color: colors.text,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 2),

                            child: Icon(
                              index < rating ? Icons.star : Icons.star_border,

                              color: Colors.amber,
                              size: 16,
                            ),
                          );
                        }),

                        const SizedBox(width: 6),

                        Text(
                          '2 ngày trước',

                          style: TextStyle(
                            color: colors.textSoft,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Icon(Icons.more_vert, color: colors.textSoft),
            ],
          ),

          const SizedBox(height: 14),

          Text(
            comment,

            style: TextStyle(color: colors.text, fontSize: 14, height: 1.5),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Text(
                'Bài đánh giá này có hữu ích không?',

                style: TextStyle(color: colors.textSoft, fontSize: 12),
              ),

              const Spacer(),

              IconButton(
                onPressed: () {},

                icon: Icon(
                  Icons.thumb_up_alt_outlined,
                  color: colors.textSoft,
                  size: 20,
                ),
              ),

              IconButton(
                onPressed: () {},

                icon: Icon(
                  Icons.thumb_down_alt_outlined,
                  color: colors.textSoft,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
