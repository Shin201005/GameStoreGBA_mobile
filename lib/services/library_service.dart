import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LibraryService {
  static const _key = 'library_games';

  Future<List<int>> getLibraryGames() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);

    if (data == null) return [];

    return List<int>.from(jsonDecode(data));
  }

  Future<void> addToLibrary(int gameId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getLibraryGames();

    if (!list.contains(gameId)) {
      list.add(gameId);
    }

    await prefs.setString(_key, jsonEncode(list));
  }

  Future<bool> isInLibrary(int gameId) async {
    final list = await getLibraryGames();
    return list.contains(gameId);
  }

  Future<void> removeFromLibrary(int gameId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getLibraryGames();

    list.remove(gameId);

    await prefs.setString(_key, jsonEncode(list));
  }

  Future<void> toggleLibrary(int gameId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getLibraryGames();

    if (list.contains(gameId)) {
      list.remove(gameId);
    } else {
      list.add(gameId);
    }

    await prefs.setString(_key, jsonEncode(list));
  }
}
