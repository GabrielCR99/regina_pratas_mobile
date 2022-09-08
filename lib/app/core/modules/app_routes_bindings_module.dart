import 'package:flutter/cupertino.dart';
import 'package:provider/single_child_widget.dart';

import 'app_page.dart';

abstract class AppRoutesBindingsModule {
  final Map<String, WidgetBuilder> _routes;
  final List<SingleChildWidget>? _bindings;

  AppRoutesBindingsModule({
    required Map<String, WidgetBuilder> routes,
    List<SingleChildWidget>? bindings,
  })  : _routes = routes,
        _bindings = bindings;

  Map<String, WidgetBuilder> get routes => _routes.map(
        (key, pageBuilder) => MapEntry(
          key,
          (_) => AppPage(page: pageBuilder, bindings: _bindings),
        ),
      );

  Widget getPage(BuildContext context, {required String path}) {
    final widgetBuilder = _routes[path];
    if (widgetBuilder != null) {
      return AppPage(page: widgetBuilder, bindings: _bindings);
    }

    throw Exception();
  }
}
