import 'package:asuka/asuka.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/ui/ui_config.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular
      ..setObservers([Asuka.asukaHeroController])
      ..setInitialRoute('/auth/');

    return ScreenUtilInit(
      builder: (_, __) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: UiConfig.title,
        theme: UiConfig.theme,
        routerDelegate: Modular.routerDelegate,
        routeInformationParser: Modular.routeInformationParser,
        builder: Asuka.builder,
        locale: const Locale('pt', 'BR'),
        supportedLocales: const [Locale('pt', 'BR')],
        localizationsDelegates: const [
          ...GlobalMaterialLocalizations.delegates,
          DefaultCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
