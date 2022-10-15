import '../../models/product_model.dart';

abstract class ProductService {
  Future<List<ProductModel>> getProducts();
}
