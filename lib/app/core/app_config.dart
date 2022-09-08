import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../firebase_options.dart';
import 'helpers/environments.dart';

class AppConfig {
  const AppConfig();

  Future<void> configureApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _setScreenOrientationToPortrait();
    await _firebaseCoreConfig();
    await _loadEnvs();
  }

  Future<void> _firebaseCoreConfig() async => Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

  Future<void> _loadEnvs() async => Environments.loadEnvs();

  Future<void> _setScreenOrientationToPortrait() async =>
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
}
