import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppPage extends StatelessWidget {
  final List<SingleChildWidget>? _bindings;
  final WidgetBuilder _page;

  const AppPage({
    required WidgetBuilder page,
    List<SingleChildWidget>? bindings,
    super.key,
  })  : _bindings = bindings,
        _page = page;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _bindings ?? [Provider(create: (_) => Object())],
      child: Builder(builder: _page),
    );
  }
}
