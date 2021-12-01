import '../../domain/repositories/authentication_repository.dart';
import '../datasources/authentication_local_datasource.dart';
import '../datasources/authentication_remote_datasource.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource localDataSource;

  AuthenticationRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  /// Calls [AuthenticationRemoteDataSource.authenticate] and updates the
  /// [AuthenticationLocalDataSource] session token.
  @override
  Future<String> authenticate(String email, String password) async {
    localDataSource.clearSessionToken();
    final session = await remoteDataSource.authenticate(email, password);
    localDataSource.setSessionToken(session);
    return session;
  }

  /// Clears [AuthenticationLocalDataSource] session token.
  @override
  Future<void> logout() async {
    localDataSource.clearSessionToken();
    await remoteDataSource.logout();
  }

  /// Loads session from [AuthenticationLocalDataSource].
  @override
  Future<String?> loadSession() => localDataSource.getSessionToken();
}
