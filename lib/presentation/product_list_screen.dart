import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

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

  void _showEditProductDialog(Product product, int index) {
    final TextEditingController _editNameController =
        TextEditingController(text: product.name);
    final TextEditingController _editPriceController =
        TextEditingController(text: product.price.toString());
    String? _editSelectedCategory = product.category;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _editNameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _editPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              DropdownButtonFormField<String>(
                value: _editSelectedCategory,
                onChanged: (String? value) {
                  setState(() {
                    _editSelectedCategory = value;
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
                final updatedProduct = Product(
                  id: product.id,
                  name: _editNameController.text,
                  price: double.parse(_editPriceController.text),
                  category: _editSelectedCategory ?? '',
                );

                setState(() {
                  productList[index] = updatedProduct;
                });

                _saveProductList(); // Save the updated product list to SharedPreferences

                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showRemoveProductDialog(Product product, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Product'),
          content: Text('Are you sure you want to remove this product?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  productList.removeAt(index);
                });

                _saveProductList(); // Save the updated product list to SharedPreferences

                Navigator.of(context).pop();
              },
              child: Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  void _addToCart(Product product) {
    setState(() {
    cartProducts.add(product);
  });
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Added to cart: ${product.name}'),
    duration: Duration(seconds: 2),
  ),
);
  }

  void _saveProductList() {
    final List<dynamic> productListData =
        productList.map((product) => product.toJson()).toList();
    final String productListJson = json.encode(productListData);
    _prefs?.setString('productList', productListJson);
  }

  void _clearProductList() {
    setState(() {
      productList = [];
    });

    _saveProductList(); // Save the updated empty product list to SharedPreferences
  }

  void _exportProductList() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/product_list.txt';
    print('File path: $filePath');
    final file = File('${directory.path}/product_list.txt');
    final productListData =
        productList.map((product) => product.toJson()).toList();
    final productListJson = json.encode(productListData);
    await file.writeAsString(productListJson);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('File path: $filePath'),
      ),
        //content: Text('Product list exported successfully.'),
    );
  }

  void _importProductList() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['txt'],
  );

  if (result != null && result.files.isNotEmpty) {
    final File file = File(result.files.first.path!);
    final String contents = await file.readAsString();
    final List<dynamic> productListData = json.decode(contents);

    final List<Product> importedProducts = productListData
        .map((productMap) => Product.fromJson(productMap))
        .toList();

    setState(() {
      productList = importedProducts;
    });

    _saveProductList(); // Save the imported product list to SharedPreferences

    final snackBar = SnackBar(
      content: Text('Product list imported successfully'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

void _showClearConfirmationDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Clear List'),
        content: Text('Are you sure you want to clear the product list?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _clearProductList();
              Navigator.of(context).pop();
            },
            child: Text('Clear'),
          ),
        ],
      );
    },
  );
}



@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Product List'),
      actions: [
        PopupMenuButton<String>(
          onSelected: (String value) {
            if (value == 'save') {
              _exportProductList();
            } else if (value == 'clear') {
              _showClearConfirmationDialog();
            } else if (value == 'import') {
             _importProductList();
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'save',
                child: Text('Save List'),
              ),
              PopupMenuItem<String>(
                value: 'clear',
                child: Text('Clear List'),
              ),
              PopupMenuItem<String>(
                value: 'import',
                child: Text('Import Product List'),
              ),
            ];
          },
        ),
      ],
    ),
    body: isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : productList.isEmpty
            ? Center(
                child: Text('No products'),
              )
            : ListView.builder(
  itemCount: productList.length,
  itemBuilder: (BuildContext context, int index) {
    final product = productList[index];
    return ListTile(
      leading: CircleAvatar(
        child: Text('${product.id}'),
      ),
      title: Text(product.name),
      subtitle: Text(product.category),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('\$${product.price.toStringAsFixed(2)}'),
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'edit') {
                _showEditProductDialog(product, index);
              } else if (value == 'remove') {
                _showRemoveProductDialog(product, index);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                PopupMenuItem<String>(
                  value: 'remove',
                  child: Text('Remove'),
                ),
              ];
            },
          ),
          IconButton(
            onPressed: () {
              if (cartProducts.contains(product)) {
                showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Product already in cart'),
                    content: Text('The product you are trying to add is already in your cart.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
                );
                
              } else {
              _addToCart(product);
              }
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      onTap: () => _showEditProductDialog(product, index),
      onLongPress: () => _showEditProductDialog(product, index),
    );
  },
),

    floatingActionButton: FloatingActionButton(
      onPressed: _showAddProductDialog,
      child: Icon(Icons.add),
    ),
  );
}
}