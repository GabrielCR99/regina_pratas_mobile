import '../../core/exceptions/failure.dart';
import '../../core/logger/app_logger.dart';
import '../../core/rest_client/rest_client.dart';
import '../../core/rest_client/rest_client_exception.dart';
import '../../models/product_model.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final RestClient _restClient;
  final AppLogger _logger;

  const ProductRepositoryImpl({
    required RestClient restClient,
    required AppLogger logger,
  })  : _restClient = restClient,
        _logger = logger;

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _restClient.auth().get('/products/');

      return (response.data as List)
          .cast<Map<String, dynamic>>()
          .map<ProductModel>(ProductModel.fromMap)
          .toList();
    } on RestClientException catch (e, s) {
      _logger.error(e.error, e, s);

      Error.throwWithStackTrace(
        const Failure(message: 'Ocorreu um erro ao buscar os produtos!'),
        s,
      );
    }
  }
}
