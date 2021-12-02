import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:banksy_ui/core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../config/app_config.dart';
import '../config/routes.dart';
import 'di/di.dart';
import 'features/authentication/presentation/pages/sign_in_page.dart';
import 'features/authentication/presentation/stores/authentication_store.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/shared/widgets/type_builder.dart';

/// Force enable crashlytics collection enabled if we’re testing it.
const _kTestingCrashlytics = true;

void mainWithConfig(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  registerGlobalDependencies(config);

  await Firebase.initializeApp();

  runZonedGuarded(
    () {
      runApp(
        ChangeNotifierProvider<AuthenticationStore>(
          create: (_) => AuthenticationStore(),
          child: BanksyUiProvider(
            child: const AppRoot(),
            data: BanksyUiData(),
          ),
        ),
      );
    },
    FirebaseCrashlytics.instance.recordError,
  );
}

class AppRoot extends StatefulWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  Future<void> _initializeFirebaseApp() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
      _kTestingCrashlytics || !kDebugMode,
    );

    // Pass all uncaught errors to Crashlytics.
    FlutterExceptionHandler? originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      originalOnError?.call(errorDetails);
    };
  }

  @override
  Widget build(BuildContext context) {
    final config = getIt<AppConfig>();
    return FutureBuilder(
        future: _initializeFirebaseApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            // TODO: Display a better splash error page.
            return const Text('Failed to load firebase');
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
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
                kHomeRoute: (context) => const HomePage(),
              },
              home: _InitialPage(),
            );
          }

          // Otherwise, show something whilst waiting for initialization
          // to complete
          return const CircularProgressIndicator();
        });
  }
}

class _InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authenticationStore = context.watch<AuthenticationStore>();

    return TypeBuilder(
      value: authenticationStore.value,
      typeBuilders: {
        AuthStateAuthenticated: TypeBuilderFactory<AuthStateAuthenticated>(
          (context, state) {
            return const HomePage();
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
