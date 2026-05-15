import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _usersKey = 'local_users';
  static const String _currentUserKey = 'current_user';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _hasSeenOnboardingKey = 'has_seen_onboarding';

  Future<List<UserModel>> getAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_usersKey);

    if (data == null) return [];

    final List list = jsonDecode(data);

    return list.map((item) {
      return UserModel.fromMap(Map<String, dynamic>.from(item));
    }).toList();
  }

  Future<void> _saveAllUsers(List<UserModel> users) async {
    final prefs = await SharedPreferences.getInstance();

    final data = users.map((user) => user.toMap()).toList();

    await prefs.setString(_usersKey, jsonEncode(data));
  }

  Future<bool> register(UserModel user) async {
    final users = await getAllUsers();

    final emailExists = users.any((oldUser) {
      return oldUser.email.trim().toLowerCase() ==
          user.email.trim().toLowerCase();
    });

    if (emailExists) {
      return false;
    }

    users.add(user);

    await _saveAllUsers(users);

    await logout();

    return true;
  }

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await getAllUsers();

    final inputEmail = email.trim().toLowerCase();

    UserModel? foundUser;

    for (final user in users) {
      final isValid =
          user.email.trim().toLowerCase() == inputEmail &&
          user.password == password;

      if (isValid) {
        foundUser = user;
        break;
      }
    }

    if (foundUser == null) {
      return false;
    }

    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_currentUserKey, foundUser.toJson());

    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_isLoggedInKey, false);
    await prefs.remove(_currentUserKey);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();

    final userJson = prefs.getString(_currentUserKey);

    if (userJson == null) return null;

    return UserModel.fromJson(userJson);
  }

  Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_hasSeenOnboardingKey) ?? false;
  }

  Future<void> setHasSeenOnboarding(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_hasSeenOnboardingKey, value);
  }
}
