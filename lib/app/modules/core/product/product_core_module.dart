import 'package:flutter_modular/flutter_modular.dart';

import '../../../repositories/product/product_repository.dart';
import '../../../repositories/product/product_repository_impl.dart';
import '../../../services/product/product_service.dart';
import '../../../services/product/product_service_impl.dart';

class ProductCoreModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<ProductRepository>(
      (i) => ProductRepositoryImpl(
        restClient: i(),
        logger: i(),
      ),
      export: true,
    ),
    Bind.lazySingleton<ProductService>(
      (i) => ProductServiceImpl(productRepository: i()),
      export: true,
    ),
  ];
}
