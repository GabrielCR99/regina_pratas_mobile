import 'package:flutter_modular/flutter_modular.dart';

import '../cart/cart_module.dart';
import '../orders/orders_module.dart';
import '../products/products_module.dart';
import '../profile/profile_module.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [Bind.lazySingleton((_) => HomeController())];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => HomePage(),
      transition: TransitionType.fadeIn,
      children: [
        ModuleRoute('/products', module: ProductsModule()),
        ModuleRoute('/cart', module: CartModule()),
        ModuleRoute('/orders', module: OrdersModule()),
        ModuleRoute('/profile', module: ProfileModule()),
      ],
    ),
  ];
}
