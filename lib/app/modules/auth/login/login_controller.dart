import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/exceptions/auth_exception.dart';
import '../../../core/exceptions/failure.dart';
import '../../../core/exceptions/user_not_exists_exception.dart';
import '../../../core/logger/app_logger.dart';
import '../../../core/ui/widgets/loader.dart';
import '../../../core/ui/widgets/messages.dart';
import '../../../models/social_login_type.dart';
import '../../../services/user/user_service.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final UserService _service;
  final AppLogger _logger;

  const LoginControllerBase({
    required UserService service,
    required AppLogger logger,
  })  : _service = service,
        _logger = logger;

  Future<void> login({required String email, required String password}) async {
    try {
      Loader.show();
      await _service.login(email: email, password: password);
      Loader.hide();
      Modular.to.navigate('/home/products/');
    } on Failure catch (e) {
      final errorMessage = e.message ?? 'Erro ao relizar login';
      _logger.error(errorMessage);
      Loader.hide();
      Messages.alert(errorMessage);
    } on UserNotExistsException {
      const errorMessage = 'Usuário não encontrado';
      _logger.error(errorMessage);
      Loader.hide();
      Messages.alert(errorMessage);
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      Loader.show();
      await _service.forgotPassword(email: email);
      Loader.hide();
      Messages.info('Senha enviada para seu email!');
    } on AuthException catch (e) {
      Loader.hide();
      Messages.alert(e.message);
    } on Exception {
      Loader.hide();
      Messages.alert('Erro ao enviar email de recuperação de senha');
    }
  }

  Future<void> socialLogin(SocialLoginType type) async {
    try {
      Loader.show();
      await _service.socialLogin(type);
      Loader.hide();
      Modular.to.navigate('/auth/');
    } on Failure catch (e, s) {
      Loader.hide();
      final errorMessage = e.message ?? 'Erro ao relizar login';
      _logger.error(errorMessage, e, s);
      Messages.alert(e.message ?? errorMessage);
    }
  }
}
