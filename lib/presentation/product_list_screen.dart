import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/product.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];
  final TextEditingController _nameController = TextEditingController();
  String _selectedCategory = CategoryList.categories[0];
  final TextEditingController _priceController = TextEditingController();
  SharedPreferences? _prefs;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
      });
      fetchProducts();
    });
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });

    // Simulating a loading delay of 1 second
    await Future.delayed(Duration(seconds: 1));

    final String? productListJson = _prefs?.getString('productList');
    if (productListJson != null) {
      final List<dynamic> productListData = json.decode(productListJson);
      final List<Product> products = productListData
          .map((productMap) => Product.fromJson(productMap))
          .toList();

      setState(() {
        productList = products;
        isLoading = false;
      });
    } else {
      setState(() {
        productList = [];
        isLoading = false;
      });
    }
  }

  void addProduct() {
    final String name = _nameController.text;
    final double price = double.parse(_priceController.text);
    final Product newProduct = Product(
      id: productList.length + 1,
      name: name,
      category: _selectedCategory,
      price: price,
    );

    setState(() {
      productList.add(newProduct);
    });

    Navigator.pop(context); // Close the add product dialog

    _saveProductList(); // Save the updated product list to SharedPreferences
  }

  void _showAddProductDialog() {
    final _nameController = TextEditingController();
    final _priceController = TextEditingController();
    String? _selectedCategory;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                onChanged: (String? value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                items: CategoryList.categories
                    .map<DropdownMenuItem<String>>(
                      (String category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                decoration: InputDecoration(labelText: 'Category'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newProduct = Product(
                  id: productList.length + 1,
                  name: _nameController.text,
                  price: double.parse(_priceController.text),
                  category: _selectedCategory ?? '',
                );

                setState(() {
                  productList.add(newProduct);
                });

                _saveProductList(); // Save the updated product list to SharedPreferences

                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _saveProductList() {
    final List<dynamic> productListData =
        productList.map((product) => product.toJson()).toList();
    final String productListJson = json.encode(productListData);
    _prefs?.setString('productList', productListJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products List'),
      ),
      body: Stack(
        children: [
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (!isLoading && productList.isNotEmpty)
            ListView.builder(
              padding: EdgeInsets.only(bottom: 80),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text(product.name),
                  subtitle: Text('Category: ${product.category}'),
                  trailing: Text('\₪${product.price.toStringAsFixed(2)}'),
                );
              },
            ),
          if (!isLoading && productList.isEmpty)
            Center(
              child: Text('No products available.'),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
