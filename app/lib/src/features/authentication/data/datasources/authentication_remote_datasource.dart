import '../../../../core/data/http_client.dart';

abstract class AuthenticationRemoteDataSource {
  /// Authenticates the user using the given credentials.
  Future<String> authenticate(String email, String password);
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final HttpClient _httpClient;

  AuthenticationRemoteDataSourceImpl(this._httpClient);

  @override
  Future<String> authenticate(String email, String password) async {
    final response = await _httpClient.post<Map<String, dynamic>>(
      '/login',
      data: {'email': email, 'password': password},
    );

    return response.data!['session'] as String;
  }
}
