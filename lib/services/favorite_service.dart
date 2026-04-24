import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const _key = 'favorite_games';

  Future<List<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);

    if (data == null) return [];

    return List<int>.from(jsonDecode(data));
  }

  Future<void> toggleFavorite(int gameId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getFavorites();

    if (list.contains(gameId)) {
      list.remove(gameId);
    } else {
      list.add(gameId);
    }

    await prefs.setString(_key, jsonEncode(list));
  }

  Future<bool> isFavorite(int gameId) async {
    final list = await getFavorites();
    return list.contains(gameId);
  }
}
