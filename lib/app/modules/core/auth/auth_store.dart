import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/local_storage/local_storage.dart';
import '../../../models/user_model.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;
  final FirebaseAuth _auth;

  AuthStoreBase({
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
    required FirebaseAuth auth,
  })  : _localStorage = localStorage,
        _localSecureStorage = localSecureStorage,
        _auth = auth;

  @readonly
  UserModel? _loggedUser;

  @computed
  User? get currentUser => _auth.currentUser;

  @action
  Future<void> loadLoggedUser() async {
    final user = await _localStorage
        .read<String>(Constants.localStorageLoggedUserDataKey);

    _loggedUser =
        user != null ? UserModel.fromJson(user) : const UserModel.empty();

    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user == null) {
        await logout();
      }
    });
  }

  @action
  Future<void> updateDisplayName(String name) async {
    await currentUser?.updateDisplayName(name);
    await currentUser?.reload();
  }

  @action
  Future<void> logout() async {
    await _localStorage.clear();
    await _localSecureStorage.clear();
    _loggedUser = const UserModel.empty();
    Modular.to.navigate('/auth/login/');
  }
}
