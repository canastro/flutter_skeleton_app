import 'package:flutter/material.dart';
import 'package:banksy_ui/core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../config/app_config.dart';
import '../config/routes.dart';
import 'di/di.dart';
import 'features/authentication/presentation/pages/sign_in_page.dart';
import 'features/authentication/presentation/stores/authentication_store.dart';
import 'features/shared/widgets/type_builder.dart';

void mainWithConfig(AppConfig config) {
  registerGlobalDependencies(config);

  runApp(
    ChangeNotifierProvider<AuthenticationStore>(
      create: (_) => AuthenticationStore(),
      child: BanksyUiProvider(
        child: const AppRoot(),
        data: BanksyUiData(),
      ),
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
      theme: BanksyUiData.of(context).materialLightTheme,
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
    final authenticationStore = context.watch<AuthenticationStore>();

    return TypeBuilder(
      value: authenticationStore.value,
      typeBuilders: {
        AuthStateAuthenticated: TypeBuilderFactory<AuthStateAuthenticated>(
          (context, state) {
            return const Text('Logged');
          },
        ),
        AuthStateInitial: TypeBuilderFactory<AuthStateInitial>(
          (context, state) {
            return const SizedBox.shrink();
          },
        ),
      },
      defaultBuilder: (context, state) {
        return const SignInPage();
      },
    );
  }
}
