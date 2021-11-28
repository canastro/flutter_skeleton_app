import '../repositories/authentication_repository.dart';

/// Calls [AuthenticationRepository.authenticate].
abstract class AuthenticateUserUseCase {
  Future<String> call(String email, String password);
}

class AuthenticateUserUseCaseImpl implements AuthenticateUserUseCase {
  final AuthenticationRepository repository;

  AuthenticateUserUseCaseImpl(this.repository);

  @override
  Future<String> call(String email, String password) async =>
      repository.authenticate(email, password);
}
