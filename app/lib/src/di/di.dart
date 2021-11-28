import 'package:get_it/get_it.dart';

import '../../config/app_config.dart';

final GetIt getIt = GetIt.instance;

/// Register dependencies that are available globally.
void registerGlobalDependencies(AppConfig config) {
  getIt.registerSingleton<AppConfig>(config);
}
