import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

import '../../core/exceptions/auth_exception.dart';
import '../../core/exceptions/failure.dart';
import '../../core/exceptions/user_exists_exception.dart';
import '../../core/logger/app_logger.dart';
import '../../core/rest_client/rest_client.dart';
import '../../core/rest_client/rest_client_exception.dart';
import '../../models/confirm_login_model.dart';
import '../../models/social_network_model.dart';
import '../../models/user_model.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient;
  final AppLogger _logger;
  final FirebaseAuth _auth;

  const UserRepositoryImpl({
    required RestClient restClient,
    required AppLogger logger,
    required FirebaseAuth auth,
  })  : _restClient = restClient,
        _logger = logger,
        _auth = auth;

  @override
  Future<void> register({required List<String> values}) async {
    try {
      await _restClient.unauth().post<void>(
        '/auth/register',
        data: {
          'name': values.first,
          'email': values[1],
          'phone': values[2],
          'document': values[3],
          'password': values[4],
          'role': 'usuario',
        },
      );
    } on RestClientException catch (e, s) {
      _logger.error(e.error, e, s);

      if (e.statusCode == HttpStatus.badRequest &&
          (e.response.data['message'] as String)
              .contains('User already exists')) {
        _logger.error(e.error, e, s);
        Error.throwWithStackTrace(UserExistsException(), s);
      }

      Error.throwWithStackTrace(
        const Failure(message: 'Ocorreu um erro ao registrar o usuário!'),
        s,
      );
    }
  }

  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _restClient.unauth().post<Map<String, dynamic>>(
        '/auth/',
        data: {
          'email': email,
          'password': password,
          'role': 'user',
          'social_login': false,
        },
      );

      return response.data!['access_token'];
    } on RestClientException catch (e, s) {
      _loginRestClientError(e, s);
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      final loginTypes = await _auth.fetchSignInMethodsForEmail(email);

      if (loginTypes.contains('password')) {
        await _auth.sendPasswordResetEmail(email: email);
      } else if (loginTypes.contains('Google')) {
        throw const AuthException(message: 'Cadastro realizado pelo Google!');
      } else {
        throw const AuthException(message: 'E-mail não cadastrado!');
      }
    } on PlatformException catch (_, s) {
      Error.throwWithStackTrace(
        const AuthException(message: 'Erro ao resetar senha'),
        s,
      );
    }
  }

  @override
  Future<ConfirmLoginModel> confirmLogin() async {
    try {
      final deviceToken = await FirebaseMessaging.instance.getToken();

      final response = await _restClient.auth().patch<Map<String, dynamic>>(
        '/auth/confirm',
        data: {
          'ios_token': Platform.isIOS ? deviceToken : null,
          'android_token': Platform.isAndroid ? deviceToken : null,
        },
      );

      return ConfirmLoginModel.fromMap(response.data!);
    } on RestClientException catch (e, s) {
      _logger.error('Erro ao confirmar login', e, s);

      Error.throwWithStackTrace(
        const Failure(message: 'Erro ao confirmar login'),
        s,
      );
    }
  }

  @override
  Future<UserModel> getLoggedUser() async {
    try {
      final response = await _restClient.get<Map<String, dynamic>>('/user/');

      return UserModel.fromMap(response.data!);
    } on RestClientException catch (e, s) {
      const errorMessage = 'Erro ao buscar dados do usuário logado';
      _logger.error(errorMessage, e, s);

      Error.throwWithStackTrace(
        const Failure(message: errorMessage),
        s,
      );
    }
  }

  @override
  Future<String> loginSocial(SocialNetworkModel model) async {
    try {
      final response = await _restClient.unauth().post<Map<String, dynamic>>(
        '/auth/',
        data: {
          'email': model.email,
          'social_login': true,
          'avatar': model.avatar,
          'social_type': model.type,
          'social_key': model.id,
          'supplier_user': false,
          'role': 'usuario',
          'name': model.name,
        },
      );

      return response.data!['access_token'];
    } on RestClientException catch (e, s) {
      _loginRestClientError(e, s);
    }
  }

  Never _loginRestClientError(
    RestClientException error,
    StackTrace stackTrace,
  ) {
    if (error.statusCode == HttpStatus.forbidden) {
      return Error.throwWithStackTrace(
        const Failure(
          message: 'Usuário inconsistente. Entre em contato com o suporte',
        ),
        stackTrace,
      );
    }
    _logger.error('Erro ao realizar login', error, stackTrace);

    return Error.throwWithStackTrace(
      const Failure(
        message: 'Erro ao realizar login. Tente novamente mais tarde',
      ),
      stackTrace,
    );
  }
}
