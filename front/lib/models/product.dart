import 'dart:convert';

class Product {
  int id;
  final String name;
  final double price;

  Product({this.id, this.name, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}

List<Product> productFromJson(String json) {
  final data = jsonDecode(json);
  return List<Product>.from(data.map((item) => Product.fromJson(item)));
}

String productToJson(Product product) {
  final json = product.toJson();
  return jsonEncode(json);
}
