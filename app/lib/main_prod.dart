import 'config/app_config.dart';
import 'src/main.dart';

const _qaConfig = AppConfig(
  endpointOrigin: 'api.demo.com',
  environment: AppConfigEnvironment.prod,
  appTitle: 'Flutter Skeleton App',
);

void main() {
  mainWithConfig(_qaConfig);
}
