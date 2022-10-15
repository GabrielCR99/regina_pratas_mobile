import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../models/user_model.dart';
import '../../core/auth/auth_store.dart';

class AuthHomePage extends StatefulWidget {
  const AuthHomePage({super.key});

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
  final _controller = Modular.get<AuthStore>();

  @override
  void initState() {
    super.initState();

    reaction<UserModel?>((_) => _controller.loggedUser, (loggedUser) {
      if (loggedUser != null && loggedUser.email.isNotEmpty) {
        Modular.to.navigate('/home/products/');
      } else {
        Modular.to.navigate('/auth/login/');
      }
    });

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _controller.loadLoggedUser());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Placeholder(
          fallbackHeight: 200,
          fallbackWidth: 200,
        ),
      ),
    );
  }
}
