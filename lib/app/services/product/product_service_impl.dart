import '../../models/product_model.dart';
import '../../repositories/product/product_repository.dart';
import 'product_service.dart';

class ProductServiceImpl implements ProductService {
  final ProductRepository _productRepository;

  const ProductServiceImpl({required ProductRepository productRepository})
      : _productRepository = productRepository;

  @override
  Future<List<ProductModel>> getProducts() => _productRepository.getProducts();
}
