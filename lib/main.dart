import 'package:flutter/material.dart';

import 'app/app_module.dart';
import 'app/core/app_config.dart';

Future<void> main() async {
  await const AppConfig().configureApp();
  runApp(const AppModule());
}
