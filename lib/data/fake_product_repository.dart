import '../core/product.dart';
import 'product_repository.dart';


class FakeProductRepository implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    // Implement your logic to retrieve products here
    // This could be fetching data from an API, a local database, or returning fake data
    return Future.delayed(Duration(seconds: 1), () {
      return [
        Product(id: '1', name: 'Apples', price: 1.99),
        Product(id: '2', name: 'Bananas', price: 0.99),
        Product(id: '3', name: 'Oranges', price: 2.49),
        Product(id: '4', name: 'Grapes', price: 3.99),
        Product(id: '5', name: 'Strawberries', price: 4.99),
      ];
    });
  }
}

