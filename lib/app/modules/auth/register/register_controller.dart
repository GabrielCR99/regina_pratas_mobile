import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/exceptions/failure.dart';
import '../../../core/exceptions/user_exists_exception.dart';
import '../../../core/logger/app_logger.dart';
import '../../../core/ui/widgets/loader.dart';
import '../../../core/ui/widgets/messages.dart';
import '../../../services/user/user_service.dart';

part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {
  final UserService _service;
  final AppLogger _logger;

  const RegisterControllerBase({
    required UserService service,
    required AppLogger logger,
  })  : _service = service,
        _logger = logger;

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String document,
    required String password,
  }) async {
    try {
      Loader.show();

      await _service.register(values: [name, email, phone, document, password]);
      Loader.hide();
      Messages.success(
        'Usuário cadastrado com sucesso! Por favor, confirme seu e-mail.',
      );
      Modular.to.pop();
    } on UserExistsException {
      Loader.hide();
      Messages.alert('Usuário já cadastrado');
    } on Failure catch (e) {
      _logger.error('Erro ao cadastrar usuário', e);
      Loader.hide();
      Messages.alert(e.message ?? 'Erro ao cadastrar usuário.');
    }
  }
}
