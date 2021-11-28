import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthenticationLocalDataSource {
  /// Returns the session token from [SharedPreferences].
  Future<String?> getSessionToken();

  /// Sets the session token on [SharedPreferences].
  Future<void> setSessionToken(String token);

  /// Clears the session token from [SharedPreferences].
  Future<void> clearSessionToken();
}

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  AuthenticationLocalDataSourceImpl();

  @override
  Future<String?> getSessionToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('sessionToken');
  }

  @override
  Future<void> setSessionToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('sessionToken', token);
  }

  @override
  Future<void> clearSessionToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('sessionToken');
  }
}
