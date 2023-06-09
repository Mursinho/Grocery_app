import '../core/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}
