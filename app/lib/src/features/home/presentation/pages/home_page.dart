import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/routes.dart';
import '../../../authentication/presentation/stores/authentication_store.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void handleLogout(BuildContext context) async {
    final authStore = context.read<AuthenticationStore>();
    await authStore.logout();

    Navigator.of(context, rootNavigator: true)
        .pushReplacementNamed(kSiginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          child: Column(
            children: [
              const Text('Home'),
              ElevatedButton(
                onPressed: () => handleLogout(context),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
