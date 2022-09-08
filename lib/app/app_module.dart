import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_widget.dart';
import 'core/auth/auth_store.dart';
import 'core/database/sqlite_connection_factory.dart';
import 'core/local_storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart';
import 'core/local_storage/local_storage.dart';
import 'core/local_storage/shared_preferences/shared_preferences_local_storage_impl.dart';
import 'core/logger/app_logger.dart';
import 'core/logger/app_logger_impl.dart';
import 'core/rest_client/dio/dio_rest_client.dart';
import 'core/rest_client/rest_client.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(create: (_) => SqliteConnectionFactory(), lazy: false),
        Provider<AppLogger>(create: (_) => AppLoggerImpl()),
        Provider<LocalStorage>(
          create: (_) => SharedPreferencesLocalStorageImpl(),
        ),
        Provider<LocalSecureStorage>(
          create: (_) => FlutterSecureStorageLocalStorageImpl(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthStore(
            localStorage: context.read(),
            localSecureStorage: context.read(),
            auth: context.read(),
          ),
        ),
        Provider<RestClient>(
          create: (context) => DioRestClient(
            authStore: context.read(),
            localSecureStorage: context.read(),
            localStorage: context.read(),
            logger: context.read(),
            baseOptions: context.read(),
          ),
        ),
      ],
      child: const AppWidget(),
    );
  }
}
