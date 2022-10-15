import 'package:mobx/mobx.dart';

import '../../core/exceptions/failure.dart';
import '../../core/logger/app_logger.dart';
import '../../core/ui/widgets/loader.dart';
import '../../core/ui/widgets/messages.dart';
import '../../services/product/product_service.dart';

part 'products_controller.g.dart';

class ProductsController = ProductsControllerBase with _$ProductsController;

abstract class ProductsControllerBase with Store {
  final ProductService _productService;
  final AppLogger _logger;

  const ProductsControllerBase({
    required ProductService productService,
    required AppLogger logger,
  })  : _productService = productService,
        _logger = logger;

  Future<void> getProducts() async {
    try {
      Loader.show();
      await _productService.getProducts();
      Loader.hide();
    } on Failure catch (e) {
      const errorMessage = 'Erro ao buscar produtos';
      Loader.hide();
      _logger.error(e.message ?? errorMessage);

      Messages.alert(e.message ?? errorMessage);
    }
  }
}
