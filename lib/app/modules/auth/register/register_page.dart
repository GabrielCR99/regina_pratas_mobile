import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/helpers/formatters.dart';
import '../../../core/ui/extensions/screen_size_extension.dart';
import '../../../core/ui/widgets/app_default_button.dart';
import '../../../core/ui/widgets/app_textform_field.dart';
import 'register_controller.dart';

part 'widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar usuário'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Placeholder(fallbackWidth: 162.w, fallbackHeight: 162.h),
          const SizedBox(height: 20),
          const _RegisterForm(),
        ],
      ),
    );
  }
}
