import 'package:get_it/get_it.dart';

import '../../config/app_config.dart';
import '../core/data/http_client.dart';
import '../features/authentication/data/datasources/authentication_local_datasource.dart';
import '../features/authentication/data/datasources/authentication_remote_datasource.dart';
import '../features/authentication/data/repositories/authentication_repository.dart';
import '../features/authentication/domain/repositories/authentication_repository.dart';
import '../features/authentication/domain/use_cases/authenticate_user.dart';
import '../features/authentication/domain/use_cases/load_session.dart';
import '../features/authentication/domain/use_cases/logout.dart';

final GetIt getIt = GetIt.instance;

/// Register dependencies that are available globally.
void registerGlobalDependencies(AppConfig config) {
  getIt.registerSingleton<AppConfig>(config);
  getIt.registerFactory<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<HttpClient>(() => HttpClient(getIt<AppConfig>()));
  getIt.registerFactory<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(getIt<HttpClient>()),
  );
  getIt.registerFactory<LoadSessionUseCase>(
    () => LoadSessionUseCaseImpl(getIt<AuthenticationRepository>()),
  );
  getIt.registerFactory<LogoutUseCase>(
    () => LogoutUseCaseImpl(getIt<AuthenticationRepository>()),
  );
  getIt.registerFactory<AuthenticateUserUseCase>(
    () => AuthenticateUserUseCaseImpl(getIt<AuthenticationRepository>()),
  );
  getIt.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImpl(
      localDataSource: getIt<AuthenticationLocalDataSource>(),
      remoteDataSource: getIt<AuthenticationRemoteDataSource>(),
    ),
  );
}
