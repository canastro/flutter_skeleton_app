import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

enum AppConfigEnvironment {
  /// For the QA environment
  qa,

  /// For when running pointing to prod data
  prod,

  /// For when running on tests
  test,
}

@immutable
class AppConfig extends Equatable {
  final String endpointOrigin;
  final AppConfigEnvironment environment;
  final String appTitle;

  const AppConfig({
    required this.endpointOrigin,
    required this.environment,
    required this.appTitle,
  });

  /// Deserializes [AppConfig] from a JSON compliant [Map].
  factory AppConfig.fromJson(Map<String, dynamic> json) {
    final endpointOrigin = json['endpointOrigin'] as String;
    final appTitle = json['appTitle'] as String;
    final environmentString = json['environment'] as String;

    late final AppConfigEnvironment environment;
    if (environmentString == 'qa') {
      environment = AppConfigEnvironment.qa;
    } else if (environmentString == 'prod') {
      environment = AppConfigEnvironment.prod;
    } else {
      environment = AppConfigEnvironment.test;
    }

    return AppConfig(
      endpointOrigin: endpointOrigin,
      environment: environment,
      appTitle: appTitle,
    );
  }

  /// Serializes [AppConfig] into a JSON compliant [Map].
  Map<String, dynamic> toJson() {
    late final String environmentString;

    switch (environment) {
      case AppConfigEnvironment.qa:
        environmentString = 'qa';
        break;
      case AppConfigEnvironment.prod:
        environmentString = 'prod';
        break;
      case AppConfigEnvironment.test:
        environmentString = 'test';
        break;
    }

    return <String, dynamic>{
      'endpointOrigin': endpointOrigin,
      'environment': environmentString,
      'appTitle': appTitle,
    };
  }

  @override
  List<Object?> get props => [
        endpointOrigin,
        environment,
        appTitle,
      ];
}
