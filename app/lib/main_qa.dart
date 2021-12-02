import 'config/app_config.dart';
import 'src/main.dart';

const _qaConfig = AppConfig(
  endpointOrigin: 'api.demo.test',
  environment: AppConfigEnvironment.qa,
  appTitle: 'Flutter Skeleton App - QA',
);

void main() {
  mainWithConfig(_qaConfig);
}
