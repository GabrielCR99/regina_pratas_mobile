import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';
import '../helpers/constants.dart';
import '../local_storage/local_storage.dart';
import '../navigator/app_navigator.dart';
import '../notifier/default_change_notifier.dart';

class AuthStore extends DefaultChangeNotifier {
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;
  final FirebaseAuth _auth;

  AuthStore({
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
    required FirebaseAuth auth,
  })  : _localStorage = localStorage,
        _localSecureStorage = localSecureStorage,
        _auth = auth;

  UserModel? loggedUser;

  User? get currentUser => _auth.currentUser;

  Future<void> loadLoggedUser() async {
    final user = await _localStorage
        .read<String>(Constants.localStorageLoggedUserDataKey);

    loggedUser =
        user != null ? UserModel.fromJson(user) : const UserModel.empty();

    notifyListeners();
    _auth.authStateChanges().listen((user) async {
      if (user == null) {
        await logout();
      }
    });
  }

  Future<void> updateDisplayName(String name) async {
    await currentUser?.updateDisplayName(name);
    await currentUser?.reload();
    notifyListeners();
  }

  Future<void> logout() async {
    await _localStorage.clear();
    await _localSecureStorage.clear();
    loggedUser = const UserModel.empty();
    AppNavigator.to.pushNamedAndRemoveUntil('/login', (_) => false);
  }
}
