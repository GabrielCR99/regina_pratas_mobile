import '../../../core/exceptions/failure.dart';
import '../../../core/exceptions/user_exists_exception.dart';
import '../../../core/navigator/app_navigator.dart';
import '../../../core/notifier/default_change_notifier.dart';
import '../../../services/user/user_service.dart';

class RegisterController extends DefaultChangeNotifier {
  final UserService _service;

  RegisterController({required UserService service}) : _service = service;

  String? infoMessage;

  bool get hasInfo => infoMessage != null;

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String document,
  }) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      await _service.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        document: document,
      );
      infoMessage =
          'Usuário cadastrado com sucesso! Por favor, confirme seu e-mail.';
      success();
      AppNavigator.to.pop();
    } on UserExistsException {
      setError('Usuário já cadastrado');
    } on Failure catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
