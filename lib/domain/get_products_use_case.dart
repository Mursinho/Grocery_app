import '../core/product.dart';
import '../data/product_repository.dart';


class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<Product>> execute() {
    return repository.getProducts();
  }
}
