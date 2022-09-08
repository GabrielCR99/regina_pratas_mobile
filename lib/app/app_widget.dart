import 'package:asuka/asuka.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/navigator/app_navigator.dart';
import 'core/ui/ui_config.dart';
import 'modules/auth/auth_module.dart';
import 'modules/base/base_module.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: UiConfig.title,
        theme: UiConfig.theme,
        navigatorKey: AppNavigator.navigatorKey,
        navigatorObservers: [Asuka.asukaHeroController],
        initialRoute: '/',
        builder: Asuka.builder,
        locale: const Locale('pt', 'BR'),
        supportedLocales: const [Locale('pt', 'BR')],
        localizationsDelegates: const [
          ...GlobalMaterialLocalizations.delegates,
          DefaultCupertinoLocalizations.delegate,
        ],
        routes: {
          ...AuthModule().routes,
          ...BaseModule().routes,
        },
      ),
    );
  }
}
