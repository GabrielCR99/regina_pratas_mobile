import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/auth/auth_store.dart';
import '../../../core/navigator/app_navigator.dart';
import '../../../core/notifier/default_listener_notifier.dart';

class AuthHomePage extends StatefulWidget {
  const AuthHomePage({super.key});

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
  @override
  void initState() {
    super.initState();
    final controller = context.read<AuthStore>();
    DefaultListenerNotifier(changeNotifier: controller).listener(
      everCallback: (notifier, _) {
        if (notifier is AuthStore) {
          if (notifier.loggedUser != null &&
              notifier.loggedUser!.email.isNotEmpty) {
            AppNavigator.to.pushNamedAndRemoveUntil('/home', (_) => false);
          } else {
            AppNavigator.to.pushNamedAndRemoveUntil('/login', (_) => false);
          }
        }
      },
    );

    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.loadLoggedUser());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SPLASH WORKS', style: TextStyle(fontSize: 50)),
      ),
    );
  }
}
