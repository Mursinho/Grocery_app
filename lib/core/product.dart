import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
    );
  }
}

List<Product> cartProducts = [
  /*Product(
      id: 4,
      name: 'Almonds',
      price: 4.99,
      category: 'Nuts',
    ),
    Product(
      id: 5,
      name: 'Milk',
      price: 2.49,
      category: 'Dairy',
    ),
    Product(
      id: 6,
      name: 'Chicken Breast',
      price: 5.99,
      category: 'Meat',
    ),
    Product(
      id: 7,
      name: 'Bread',
      price: 1.99,
      category: 'Bakery',
    ),
    Product(
      id: 8,
      name: 'Pasta',
      price: 2.49,
      category: 'Pantry',
    ),*/

];

List<Product> productList = [
    Product(
      id: 1,
      name: 'Apple',
      price: 1.99,
      category: 'Fruits',
    ),
    Product(
      id: 2,
      name: 'Banana',
      price: 0.99,
      category: 'Fruits',
    ),
    Product(
      id: 3,
      name: 'Carrot',
      price: 0.75,
      category: 'Vegetables',
    ),
    Product(
      id: 4,
      name: 'Almonds',
      price: 4.99,
      category: 'Nuts',
    ),
    Product(
      id: 5,
      name: 'Milk',
      price: 2.49,
      category: 'Dairy',
    ),
    Product(
      id: 6,
      name: 'Chicken Breast',
      price: 5.99,
      category: 'Meat',
    ),
    Product(
      id: 7,
      name: 'Bread',
      price: 1.99,
      category: 'Bakery',
    ),
    Product(
      id: 8,
      name: 'Pasta',
      price: 2.49,
      category: 'Pantry',
    ),
    Product(
      id: 9,
      name: 'Orange Juice',
      price: 3.49,
      category: 'Beverages',
    ),
    Product(
      id: 10,
      name: 'Dish Soap',
      price: 1.99,
      category: 'Household',
    ),
    Product(
      id: 11,
      name: 'Shampoo',
      price: 4.99,
      category: 'Personal Care',
    ),
    Product(
      id: 12,
      name: 'Toothbrush',
      price: 2.99,
      category: 'Personal Care',
    ),
    Product(
      id: 13,
      name: 'Orange',
      price: 1.49,
      category: 'Fruits',
    ),
    Product(
      id: 14,
      name: 'Tomato',
      price: 0.99,
      category: 'Vegetables',
    ),
    Product(
      id: 15,
      name: 'Eggs',
      price: 2.99,
      category: 'Dairy',
    ),
    Product(
      id: 16,
      name: 'Salmon Fillet',
      price: 9.99,
      category: 'Seafood',
    ),
    Product(
      id: 17,
      name: 'Avocado',
      price: 1.99,
      category: 'Fruits',
    ),
    Product(
      id: 18,
      name: 'Brown Rice',
      price: 2.49,
      category: 'Pantry',
    ),
    Product(
      id: 19,
      name: 'Peanut Butter',
      price: 3.99,
      category: 'Pantry',
    ),
    Product(
      id: 20,
      name: 'Yogurt',
      price: 1.99,
      category: 'Dairy',
    ),
    Product(
      id: 21,
      name: 'Onion',
      price: 0.79,
      category: 'Vegetables',
    ),
    Product(
      id: 22,
      name: 'Ice Cream',
      price: 4.99,
      category: 'Frozen',
    ),
    
  ];

class CategoryList {
  static List<String> categories = [
    'Fruits',
    'Vegetables',
    'Dairy',
    'Meat',
    'Seafood',
    'Bakery',
    'Frozen',
    'Pantry',
    'Beverages',
    'Nuts',
    'Household',
    'Personal Care',
    'Other',
  ];
}

Future<void> storeProducts() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Convert the list of products to a list of JSON maps
  List<Map<String, dynamic>> productListJson =
      productList.map((product) => product.toJson()).toList();

  // Convert the list of JSON maps to a JSON string
  String productListString = jsonEncode(productListJson);

  // Store the JSON string in shared preferences
  await prefs.setString('productList', productListString);

  print('Products stored in shared preferences.');
}