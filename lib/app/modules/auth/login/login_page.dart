import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/navigator/app_navigator.dart';
import '../../../core/notifier/default_listener_notifier.dart';
import '../../../core/ui/extensions/screen_size_extension.dart';
import '../../../core/ui/extensions/theme_extension.dart';
import '../../../core/ui/widgets/app_default_button.dart';
import '../../../core/ui/widgets/app_textform_field.dart';
import '../../../core/ui/widgets/messages.dart';
import '../../../core/ui/widgets/rounded_button_with_icon.dart';
import '../../../models/social_login_type.dart';
import 'login_controller.dart';

part 'widgets/login_divider.dart';
part 'widgets/login_form.dart';
part 'widgets/login_register_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
      everCallback: (notifier, _) {
        if (notifier is LoginController) {
          if (notifier.hasInfo) {
            Messages.info(notifier.infoMessage!);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 50.h),
            Placeholder(fallbackWidth: 162.w, fallbackHeight: 162.h),
            const SizedBox(height: 20),
            const _LoginForm(),
            const _OrSeparator(),
            const _LoginRegisterButtons(),
          ],
        ),
      ),
    );
  }
}

class _OrSeparator extends StatelessWidget {
  const _OrSeparator();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _LoginDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'ou',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: context.primaryColor,
            ),
          ),
        ),
        const _LoginDivider(),
      ],
    );
  }
}
