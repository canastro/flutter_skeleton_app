abstract class AuthenticationRepository {
  Future<String> authenticate(String email, String password);

  Future<void> logout();

  Future<String?> loadSession();
}
