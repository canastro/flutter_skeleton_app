// ignore_for_file: do_not_use_environment

import 'config/app_config.dart';
import 'src/main.dart';

const _qaConfig = AppConfig(
  endpointOrigin: 'api.shooda.test',
  environment: AppConfigEnvironment.qa,
  appTitle: 'Shooda - QA',
);

void main() {
  mainWithConfig(_qaConfig);
}