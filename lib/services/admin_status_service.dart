import 'package:shared_preferences/shared_preferences.dart';

class AdminStatusService {
  static const _gamePrefix = 'admin_game_status_';
  static const _userPrefix = 'admin_user_status_';

  Future<void> saveGameStatus(int gameId, String status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_gamePrefix$gameId', status);
  }

  Future<String?> getGameStatus(int gameId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('$_gamePrefix$gameId');
  }

  Future<void> saveUserStatus(String username, String status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_userPrefix$username', status);
  }

  Future<String?> getUserStatus(String username) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('$_userPrefix$username');
  }
}
