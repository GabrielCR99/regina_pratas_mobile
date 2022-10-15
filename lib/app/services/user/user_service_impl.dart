import 'package:firebase_auth/firebase_auth.dart';

import '../../core/exceptions/failure.dart';
import '../../core/exceptions/user_exists_exception.dart';
import '../../core/exceptions/user_not_exists_exception.dart';
import '../../core/helpers/constants.dart';
import '../../core/local_storage/local_storage.dart';
import '../../core/logger/app_logger.dart';
import '../../models/social_login_type.dart';
import '../../models/social_network_model.dart';
import '../../repositories/social/social_repository.dart';
import '../../repositories/user/user_repository.dart';
import 'user_service.dart';

class UserServiceImpl implements UserService {
  final AppLogger _logger;
  final UserRepository _repository;
  final SocialRepository _socialRepository;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;

  const UserServiceImpl({
    required AppLogger logger,
    required UserRepository repository,
    required SocialRepository socialRepository,
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
  })  : _logger = logger,
        _repository = repository,
        _localStorage = localStorage,
        _localSecureStorage = localSecureStorage,
        _socialRepository = socialRepository;

  @override
  Future<void> register({required List<String> values}) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;

      final userMethods =
          await firebaseAuth.fetchSignInMethodsForEmail(values[1]);

      if (userMethods.isNotEmpty) {
        throw UserExistsException();
      }

      await _repository.register(values: values);

      final credentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: values[1],
        password: values[4],
      );

      await credentials.user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _logger.error('Error while creating firebase user', e, s);

      Error.throwWithStackTrace(
        const Failure(message: 'Error creating user'),
        s,
      );
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;

      final loginMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginMethods.isEmpty) {
        throw UserNotExistsException();
      }

      if (loginMethods.contains('password')) {
        final credentials = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final verifiedUser = credentials.user?.emailVerified ?? false;

        if (!verifiedUser) {
          await credentials.user?.sendEmailVerification();
          throw const Failure(
            message: 'E-mail não confirmado. Verifique sua caixa de spam.',
          );
        }

        final user = await _repository.login(email: email, password: password);
        await _saveAccessToken(user);
        await _confirmLogin();
        await _getUserData();
      } else {
        throw const Failure(message: 'Login não encontrado');
      }
    } on FirebaseAuthException catch (e, s) {
      _logger.error('Invalid user or password $e');
      Error.throwWithStackTrace(
        const Failure(message: 'Usuário ou senha inválidos'),
        s,
      );
    }
  }

  @override
  Future<void> forgotPassword({required String email}) =>
      _repository.forgotPassword(email: email);

  Future<void> _saveAccessToken(String accessToken) => _localStorage
      .write<String>(Constants.localStorageAccessTokenKey, accessToken);

  Future<void> _confirmLogin() async {
    final confirmLoginModel = await _repository.confirmLogin();
    await _saveAccessToken(confirmLoginModel.accessToken);
    await _localSecureStorage.write(
      Constants.localStorageRefreshTokenKey,
      confirmLoginModel.refreshToken,
    );
  }

  Future<void> _getUserData() async {
    final userModel = await _repository.getLoggedUser();
    await _localStorage.write<String>(
      Constants.localStorageLoggedUserDataKey,
      userModel.toJson(),
    );
  }

  @override
  Future<void> socialLogin(SocialLoginType type) async {
    try {
      final SocialNetworkModel socialNetworkModel;
      final AuthCredential authCredential;
      final firebaseAuth = FirebaseAuth.instance;

      switch (type) {
        case SocialLoginType.facebook:
          socialNetworkModel = await _socialRepository.facebookLogin();
          authCredential =
              FacebookAuthProvider.credential(socialNetworkModel.accessToken);
          break;
        case SocialLoginType.google:
          socialNetworkModel = await _socialRepository.googleLogin();
          authCredential = GoogleAuthProvider.credential(
            accessToken: socialNetworkModel.accessToken,
            idToken: socialNetworkModel.id,
          );
          break;
      }

      final loginMethods = await firebaseAuth
          .fetchSignInMethodsForEmail(socialNetworkModel.email);

      if (loginMethods.isNotEmpty && !loginMethods.contains(type.domain)) {
        throw Failure(message: 'Login não pode ser feito por ${type.value}.');
      }

      await firebaseAuth.signInWithCredential(authCredential);
      final result = await _repository.loginSocial(socialNetworkModel);
      await _saveAccessToken(result);
      await _confirmLogin();
      await _getUserData();
    } on FirebaseAuthException catch (e, s) {
      _logger.error('Erro ao realizar login com ${type.value}', e, s);
      Error.throwWithStackTrace(
        const Failure(message: 'Erro ao realizar login'),
        s,
      );
    }
  }
}
