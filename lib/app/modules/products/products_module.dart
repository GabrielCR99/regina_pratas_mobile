import 'package:flutter_modular/flutter_modular.dart';

import '../core/product/product_core_module.dart';
import 'products_controller.dart';
import 'products_page.dart';

class ProductsModule extends Module {
  @override
  List<Module> get imports => [ProductCoreModule()];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => ProductsController(productService: i(), logger: i()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const ProductsPage()),
  ];
}
