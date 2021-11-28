import '../repositories/authentication_repository.dart';

/// Calls [AuthenticationRepository.logout].
abstract class LogoutUseCase {
  Future<void> call();
}

class LogoutUseCaseImpl implements LogoutUseCase {
  final AuthenticationRepository repository;

  LogoutUseCaseImpl(this.repository);

  @override
  Future<void> call() async {
    await repository.logout();
  }
}
