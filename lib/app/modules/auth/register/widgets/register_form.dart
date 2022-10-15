part of '../register_page.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();
  final _phoneEC = TextEditingController();
  final _documentEC = TextEditingController();

  final _controller = Modular.get<RegisterController>();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    _phoneEC.dispose();
    _documentEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextformField(
            labelText: 'Nome',
            controller: _nameEC,
            keyboardType: TextInputType.name,
            validator: Validatorless.required('Nome é obrigatório'),
          ),
          const SizedBox(height: 20),
          AppTextformField(
            labelText: 'E-mail',
            controller: _emailEC,
            keyboardType: TextInputType.emailAddress,
            validator: Validatorless.multiple([
              Validatorless.required('E-mail é obrigatório'),
              Validatorless.email('E-mail inválido'),
            ]),
          ),
          const SizedBox(height: 20),
          AppTextformField(
            labelText: 'Celular',
            keyboardType: TextInputType.phone,
            controller: _phoneEC,
            validator: Validatorless.multiple(
              [Validatorless.required('Celular é obrigatório')],
            ),
            inputFormatters: [Formatters.phoneFormatter],
          ),
          const SizedBox(height: 20),
          AppTextformField(
            labelText: 'CPF',
            controller: _documentEC,
            keyboardType: TextInputType.number,
            validator: Validatorless.multiple([
              Validatorless.required('CPF é obrigatório'),
              Validatorless.cpf('CPF inválido'),
            ]),
            inputFormatters: [Formatters.cpfFormatter],
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
          const SizedBox(height: 20),
          AppTextformField(
            labelText: 'Confirmar senha',
            controller: _confirmPasswordEC,
            validator: Validatorless.multiple([
              Validatorless.required('Confirmar senha é obrigatória'),
              Validatorless.compare(
                _passwordEC,
                'Confirmar senha deve ser igual a senha',
              ),
            ]),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          AppDefaultButton(
            label: 'Cadastrar',
            onPressed: _onPressedRegister,
          ),
        ],
      ),
    );
  }

  void _onPressedRegister() {
    final formValid = _formKey.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus();
    if (formValid) {
      FocusScope.of(context).unfocus();
      _controller.register(
        name: _nameEC.text,
        email: _emailEC.text,
        phone: _phoneEC.text,
        document: _documentEC.text,
        password: _passwordEC.text,
      );
    }
  }
}
