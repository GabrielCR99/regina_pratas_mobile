import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/notifier/default_listener_notifier.dart';
import '../../../core/ui/extensions/screen_size_extension.dart';
import '../../../core/ui/widgets/app_default_button.dart';
import '../../../core/ui/widgets/app_textform_field.dart';
import '../../../core/ui/widgets/messages.dart';
import 'register_controller.dart';

part 'widgets/register_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: context.read<RegisterController>())
        .listener(
      everCallback: (notifier, _) {
        if (notifier is RegisterController) {
          if (notifier.hasInfo) {
            Messages.success(notifier.infoMessage!);
          }
        }
      },
    );
  }

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
