import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'presentation/product_list_screen.dart';
import 'category_screen.dart';
import '../core/product.dart';


void main() {
  runApp(GroceryApp());
  storeProducts();
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
            onTap: () async {
              String selectedCategory = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryScreen()),
            );
            if (selectedCategory != null) {
              // Do something with the selected category
              print('Selected Category: $selectedCategory');
            }  // Handle tapping on Categories
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
          ListTile(
            leading: Icon(Icons.drafts),
            title: Text('Draft'),
            onTap: () {
              // Handle tapping on Draft
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Exit'),
                    content: Text('Are you sure you want to exit the app?'),
                    actions: [
                      TextButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}





