part of '../login_page.dart';

class _LoginRegisterButtons extends StatelessWidget {
  const _LoginRegisterButtons();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LoginController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SignInButton(
          Buttons.Google,
          text: 'Continuar com Google',
          onPressed: () => controller.socialLogin(SocialLoginType.google),
          shape: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
        ),
        SignInButton(
          Buttons.FacebookNew,
          text: 'Continuar com Facebook',
          onPressed: () => controller.socialLogin(SocialLoginType.facebook),
          shape: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
        ),
        RoundedButtonWithIcon(
          color: Colors.black,
          width: 0.6.sw,
          icon: Icons.email,
          onTap: () => AppNavigator.to.pushNamed('/register'),
          label: 'Cadastrar-se',
        ),
      ],
    );
  }
}
