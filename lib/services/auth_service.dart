import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _userKey = 'local_user';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _hasSeenOnboardingKey = 'has_seen_onboarding';

  Future<bool> register(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();

    final existingUser = prefs.getString(_userKey);
    if (existingUser != null) {
      final oldUser = UserModel.fromJson(existingUser);
      if (oldUser.email.trim().toLowerCase() ==
          user.email.trim().toLowerCase()) {
        return false;
      }
    }

    await prefs.setString(_userKey, user.toJson());
    await prefs.setBool(_isLoggedInKey, false);
    return true;
  }

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);

    if (userJson == null) return false;

    final user = UserModel.fromJson(userJson);

    final isValid =
        user.email.trim().toLowerCase() == email.trim().toLowerCase() &&
        user.password == password;

    if (isValid) {
      await prefs.setBool(_isLoggedInKey, true);
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);

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
