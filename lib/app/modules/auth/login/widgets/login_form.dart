part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _loginFocus = FocusNode();

  late final _controller = context.read<LoginController>();

  @override
  void dispose() {
    _loginEC.dispose();
    _passwordEC.dispose();
    _loginFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextformField(
            labelText: 'Login',
            controller: _loginEC,
            focusNode: _loginFocus,
            validator: Validatorless.multiple([
              Validatorless.required('Login é obrigatório'),
              Validatorless.email('Email inválido'),
            ]),
          ),
          const SizedBox(height: 20),
          AppTextformField(
            labelText: 'Senha',
            controller: _passwordEC,
            validator: Validatorless.multiple([
              Validatorless.required('Senha é obrigatória'),
              Validatorless.min(6, 'Senha deve ter no mínimo 6 caracteres'),
            ]),
            obscureText: true,
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: _forgotPassword,
              child: const Text('Esqueci minha senha'),
            ),
          ),
          AppDefaultButton(onPressed: _login, label: 'Entrar'),
        ],
      ),
    );
  }

  void _login() {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      _controller.login(email: _loginEC.text, password: _passwordEC.text);
    }
  }

  void _forgotPassword() {
    if (_loginEC.text.isNotEmpty) {
      _controller.forgotPassword(email: _loginEC.text);
    } else {
      _loginFocus.requestFocus();
      Messages.alert('Digite um E-mail para recuperar a senha');
    }
  }
}
