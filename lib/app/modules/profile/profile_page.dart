import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/ui/widgets/loader.dart';
import '../core/auth/auth_store.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Sair do aplicativo'),
                content: const Text('Deseja realmente sair do aplicativo?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Não'),
                  ),
                  TextButton(
                    onPressed: () => _onPressedLogout(context),
                    child: const Text('Sim'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(),
    );
  }

  Future<void> _onPressedLogout(BuildContext context) async {
    final navigator = Navigator.of(context);
    Loader.show();
    await Modular.get<AuthStore>().logout();
    Loader.hide();
    navigator.pop();
  }
}
