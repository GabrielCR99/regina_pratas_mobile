import '../../../core/exceptions/auth_exception.dart';
import '../../../core/exceptions/failure.dart';
import '../../../core/exceptions/user_not_exists_exception.dart';
import '../../../core/logger/app_logger.dart';
import '../../../core/navigator/app_navigator.dart';
import '../../../core/notifier/default_change_notifier.dart';
import '../../../models/social_login_type.dart';
import '../../../services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _service;
  final AppLogger _logger;

  LoginController({
    required UserService userService,
    required AppLogger logger,
  })  : _service = userService,
        _logger = logger;

  String? infoMessage;

  bool get hasInfo => infoMessage != null;

  Future<void> login({required String email, required String password}) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      await _service.login(email: email, password: password);
      success();
      AppNavigator.to.pushNamedAndRemoveUntil('/home', (_) => false);
    } on Failure catch (e) {
      final errorMessage = e.message ?? 'Erro ao relizar login';
      _logger.error(errorMessage);
      setError(errorMessage);
    } on UserNotExistsException {
      const errorMessage = 'Usuário não encontrado';
      _logger.error(errorMessage);
      setError(errorMessage);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _service.forgotPassword(email: email);
      infoMessage = 'Senha enviada para seu email!';
    } on AuthException catch (e) {
      setError(e.message);
    } on Exception {
      setError('Erro ao resetar a senha!');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> socialLogin(SocialLoginType type) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _service.socialLogin(type);
      success();
    } on Failure catch (e, s) {
      final errorMessage = e.message ?? 'Erro ao relizar login';
      _logger.error(errorMessage, e, s);
      setError(errorMessage);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
