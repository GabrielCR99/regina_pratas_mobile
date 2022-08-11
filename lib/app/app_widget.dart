import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/ui/ui_config.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Modular
      ..setObservers([asuka.asukaHeroController])
      ..setInitialRoute('/auth/');

    return ScreenUtilInit(
      builder: (_, __) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
        builder: asuka.builder,
        title: UiConfig.title,
        theme: UiConfig.theme,
      ),
    );
  }
}
