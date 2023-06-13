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

