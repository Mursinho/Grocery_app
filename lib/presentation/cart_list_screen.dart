import 'package:flutter/material.dart';
import '../core/product.dart';

class CartListScreen extends StatelessWidget {
  final List<Product> cartProducts;

  CartListScreen({required this.cartProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart List'),
      ),
      body: cartProducts.isNotEmpty
      ? ListView.builder(
        itemCount: cartProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartProducts[index].name),
            subtitle: Text('\$${cartProducts[index].price.toStringAsFixed(2)}'),
          );
        },
      )
      : Center(
              child: Text('Your cart is empty!'),
            ),
    );
  }
}

