import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'presentation/product_list_screen.dart';


void main() {
  runApp(GroceryApp());
}

class GroceryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
      routes: {
        '/productList': (context) => ProductListScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery App'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Products List'),
            onTap: () {
              Navigator.pushNamed(context, '/productList');
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
            onTap: () {
              // Handle tapping on Categories
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Shopping Cart'),
            onTap: () {
              // Handle tapping on Shopping Cart
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // Handle tapping on Notifications
            },
          ),
        ],
      ),
    );
  }
}





