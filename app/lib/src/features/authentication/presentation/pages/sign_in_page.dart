import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:banksy_ui/core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:banksy_ui/widgets.dart';
import 'package:provider/provider.dart';

import '../stores/authentication_store.dart';

const _kPasswordMin = 7;
const _kPasswordMax = 129;

/// [StatefulWidget] that holds the sign-in form.
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();

  late final routeArguments =
      ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
  late final emailTextController =
      TextEditingController(text: routeArguments?['email'] ?? '');
  final passwordTextController = TextEditingController(text: '');
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  Future<void> handleSubmitForm() async {
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();

    final authenticationStore = context.read<AuthenticationStore>();
    await authenticationStore.authenticate(
      emailTextController.value.text,
      passwordTextController.value.text,
    );

    // Navigator.pushReplacementNamed(context, kWorkspaceRoute);
  }

  @override
  Widget build(BuildContext context) {
    final theme = BanksyUiData.themeOf(context);
    final localization = AppLocalizations.of(context)!;
    final picassoPalette = BanksyUiPalette.of(context);
    final authenticationStore = context.watch<AuthenticationStore>();
    final authenticationState = authenticationStore.value;

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localization.signIn,
                style: theme.textTheme.headline2!.copyWith(
                  color: picassoPalette.green.shade900,
                ),
              ),
              const Spacing(multiplier: 4),
              TextFormField(
                controller: emailTextController,
                validator: ValidationBuilder(
                  requiredMessage: localization.missingRequiredField(
                    localization.email,
                  ),
                ).email(localization.invalidEmail).build(),
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                autocorrect: false,
                focusNode: emailFocus,
                onFieldSubmitted: (_) {
                  emailFocus.requestFocus();
                  handleSubmitForm();
                },
                decoration: InputDecoration(
                  labelText: localization.email,
                ),
              ),
              const Spacing(multiplier: 2),
              TextFormField(
                controller: passwordTextController,
                onFieldSubmitted: (_) {
                  passwordFocus.requestFocus();
                  handleSubmitForm();
                },
                focusNode: passwordFocus,
                validator: ValidationBuilder(
                  requiredMessage: localization.missingRequiredField(
                    localization.password,
                  ),
                )
                    .minLength(
                      _kPasswordMin,
                      localization.minLength(
                        localization.password,
                        _kPasswordMin,
                      ),
                    )
                    .maxLength(
                      _kPasswordMax,
                      localization.maxLength(
                        localization.password,
                        _kPasswordMax,
                      ),
                    )
                    .build(),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: localization.password,
                ),
              ),
              if (authenticationState is AuthStateError)
                ServerError(state: authenticationState),
              const Spacing(multiplier: 2),
              ElevatedButton(
                child: Text(localization.submit),
                onPressed: handleSubmitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Renders [Text] to indicate errors coming from the server side.
class ServerError extends StatelessWidget {
  final AuthStateError state;

  const ServerError({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final textStyle = TextStyle(
      color: Theme.of(context).errorColor,
    );

    final text = state.isUnauthorized
        ? localization.invalidCredentials
        : localization.unexpectedError;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
