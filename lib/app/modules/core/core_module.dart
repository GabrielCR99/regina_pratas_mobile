import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/database/sqlite_connection_factory.dart';
import '../../core/local_storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart';
import '../../core/local_storage/local_storage.dart';
import '../../core/local_storage/shared_preferences/shared_preferences_local_storage_impl.dart';
import '../../core/logger/app_logger.dart';
import '../../core/logger/app_logger_impl.dart';
import '../../core/rest_client/dio/dio_rest_client.dart';
import '../../core/rest_client/rest_client.dart';
import 'auth/auth_store.dart';

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((_) => FirebaseAuth.instance, export: true),
    Bind.lazySingleton((_) => SqliteConnectionFactory(), export: true),
    Bind.lazySingleton<AppLogger>((_) => AppLoggerImpl(), export: true),
    Bind.lazySingleton<LocalStorage>(
      (_) => SharedPreferencesLocalStorageImpl(),
      export: true,
    ),
    Bind.lazySingleton<LocalSecureStorage>(
      (_) => FlutterSecureStorageLocalStorageImpl(),
      export: true,
    ),
    Bind.lazySingleton(
      (i) => AuthStore(
        localStorage: i(),
        localSecureStorage: i(),
        auth: i(),
      ),
      export: true,
    ),
    Bind.lazySingleton<RestClient>(
      (i) => DioRestClient(
        authStore: i(),
        localSecureStorage: i(),
        localStorage: i(),
        logger: i(),
      ),
      export: true,
    ),
  ];
}
