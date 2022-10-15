import 'package:flutter_modular/flutter_modular.dart';

import 'orders_page.dart';

class OrdersModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const OrdersPage()),
  ];
}
