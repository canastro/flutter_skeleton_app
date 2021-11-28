import '../repositories/authentication_repository.dart';

/// Tries to load session from [AuthenticationRepository].
abstract class LoadSessionUseCase {
  Future<String?> call();
}

class LoadSessionUseCaseImpl implements LoadSessionUseCase {
  final AuthenticationRepository repository;

  LoadSessionUseCaseImpl(this.repository);

  @override
  Future<String?> call() async {
    final session = await repository.loadSession();
    return session == null || session.isEmpty ? null : session;
  }
}
