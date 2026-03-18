import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _usersKey = 'calcpro_users';
  static const _currentUserKey = 'calcpro_current_user';
  static const _seededKey = 'calcpro_seeded_v1';

  /// Sentinel value stored as the current user when browsing as guest.
  static const guestUsername = '__guest__';

  static String _hashPassword(String password) {
    final bytes = utf8.encode('${password}calcpro_salt_v1');
    return sha256.convert(bytes).toString();
  }

  static Future<List<Map<String, dynamic>>> _getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_usersKey);
    if (usersJson == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(usersJson));
  }

  static Future<void> _saveUsers(List<Map<String, dynamic>> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  /// Seeds the default account on first launch so the app has a
  /// ready-to-use account without manual registration.
  /// Credentials: username = ahmedshiref15 / password = 123456
  static Future<void> seedDefaultUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_seededKey) == true) return;

    final users = await _getUsers();
    final alreadyExists = users.any(
      (u) =>
          (u['email'] as String).toLowerCase() == 'ahmedshiref15@gmail.com',
    );

    if (!alreadyExists) {
      users.add({
        'username': 'ahmedshiref15',
        'email': 'ahmedshiref15@gmail.com',
        'password': _hashPassword('123456'),
        'createdAt': DateTime.now().toIso8601String(),
      });
      await _saveUsers(users);
    }

    await prefs.setBool(_seededKey, true);
  }

  /// Registers a new user. Returns null on success, or an error message.
  static Future<String?> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final trimmedUsername = username.trim().toLowerCase();
    final trimmedEmail = email.trim().toLowerCase();

    if (trimmedUsername.length < 3) {
      return 'Username must be at least 3 characters.';
    }
    if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w+$').hasMatch(trimmedEmail)) {
      return 'Please enter a valid email address.';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters.';
    }

    final users = await _getUsers();

    final usernameExists = users.any(
      (u) => (u['username'] as String).toLowerCase() == trimmedUsername,
    );
    if (usernameExists) return 'Username already taken.';

    final emailExists = users.any(
      (u) => (u['email'] as String).toLowerCase() == trimmedEmail,
    );
    if (emailExists) return 'Email already registered.';

    users.add({
      'username': username.trim(),
      'email': trimmedEmail,
      'password': _hashPassword(password),
      'createdAt': DateTime.now().toIso8601String(),
    });

    await _saveUsers(users);
    return null;
  }

  /// Logs in a user. Returns null on success, or an error message.
  static Future<String?> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    final trimmed = usernameOrEmail.trim().toLowerCase();
    final hashed = _hashPassword(password);

    final users = await _getUsers();

    final user = users.firstWhere(
      (u) =>
          (u['username'] as String).toLowerCase() == trimmed ||
          (u['email'] as String).toLowerCase() == trimmed,
      orElse: () => {},
    );

    if (user.isEmpty) return 'No account found with that username or email.';
    if (user['password'] != hashed) return 'Incorrect password.';

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, user['username'] as String);
    return null;
  }

  /// Logs out the current user.
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  /// Returns the currently logged-in username, or null if not logged in.
  static Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUserKey);
  }

  static Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }

  /// Starts a guest session without requiring credentials.
  static Future<void> loginAsGuest() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, guestUsername);
  }

  /// Returns true when the active session belongs to a guest.
  static Future<bool> isGuestUser() async {
    final user = await getCurrentUser();
    return user == guestUsername;
  }
}
