import 'package:flutter/material.dart';
import '../core/product.dart';
import '../domain/get_products_use_case.dart';
import '../data/fake_product_repository.dart';


class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late GetProductsUseCase getProductsUseCase;
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    getProductsUseCase = GetProductsUseCase(FakeProductRepository());
    fetchProducts();
  }

  void fetchProducts() async {
    final products = await getProductsUseCase.execute();
    setState(() {
      productList = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(productList[index].name),
            subtitle: Text('\$${productList[index].price.toStringAsFixed(2)}'), // Display the price
          );
        },
      ),
    );
  }
}

