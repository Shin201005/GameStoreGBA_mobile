class GameModel {
  final int id;
  final String title;
  final String rom;
  final String category;
  final String cover;
  final String description;
  final double rating;

  GameModel({
    required this.id,
    required this.title,
    required this.rom,
    required this.category,
    required this.cover,
    required this.description,
    required this.rating,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      title: json['title'],
      rom: json['rom'],
      category: json['category'],
      cover: json['cover'],
      description: json['description'],
      rating: (json['rating'] as num).toDouble(),
    );
  }
}
