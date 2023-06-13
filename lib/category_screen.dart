import 'package:flutter/material.dart';
import '../core/product.dart'; // Import the Product and CategoryList classes

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: CategoryList.categories.length,
        itemBuilder: (context, index) {
          String category = CategoryList.categories[index];
          return ListTile(
            title: Text(category),
            onTap: () {
              // Handle tapping on a category
              Navigator.pop(context, category);
            },
          );
        },
      ),
    );
  }
}
