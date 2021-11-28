import 'package:flutter/material.dart';
import 'package:picasso/core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../config/app_config.dart';
import '../config/routes.dart';
import 'di/di.dart';
import 'features/authentication/presentation/pages/sign_in_page.dart';

void mainWithConfig(AppConfig config) {
  registerGlobalDependencies(config);

  runApp(
    PicassoProvider(
      child: const AppRoot(),
      data: PicassoData(),
    ),
  );
}

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final config = getIt<AppConfig>();
    return MaterialApp(
      title: config.appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
      debugShowCheckedModeBanner: false,
      theme: PicassoData.of(context).materialLightTheme,
      themeMode: ThemeMode.light,
      routes: {
        kSiginRoute: (context) => const SignInPage(),
      },
      home: _Home(),
    );
  }
}

class _Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SignInPage();
  }
}
