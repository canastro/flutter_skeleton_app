import '../../../../core/data/http_client.dart';

abstract class AuthenticationRemoteDataSource {
  /// Authenticates the user using the given credentials.
  Future<String> authenticate(String email, String password);

  /// Calls the logout endpoint to terminate the current user's session.
  Future<void> logout();
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final HttpClient _httpClient;

  AuthenticationRemoteDataSourceImpl(this._httpClient);

  @override
  Future<String> authenticate(String email, String password) async {
    // final response = await _httpClient.post<Map<String, dynamic>>(
    //   '/login',
    //   data: {'email': email, 'password': password},
    // );

    // return response.data!['session'] as String;

    // TODO: replace with actual server call
    return 'mocked_session';
  }

  @override
  Future<void> logout() async {
    // return _httpClient.post<Map<String, dynamic>>('/logout');

    // TODO: replace with actual server call
    await Future.delayed(const Duration(milliseconds: 50));
  }
}
