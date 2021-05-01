import 'dart:convert';

import 'package:front/models/customer.dart';
import 'package:front/models/product.dart';

class Order {
  int id;
  final Customer customer;
  List<Product> products;
  double price;
  final DateTime date;

  Order({this.id, this.customer, this.products, this.price, this.date});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customer: Customer.fromJson(json['customer']),
      products:
          List<Product>.from(json['products'].map((p) => Product.fromJson(p))),
      price: double.parse(json['price']),
      date: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customer.id,
      'product_ids': products.map((p) => p.id).toList(),
      'price': price,
    };
  }
}

List<Order> orderFromJson(String json) {
  final data = jsonDecode(json);
  return List<Order>.from(data.map((item) => Order.fromJson(item)));
}

String orderToJson(Order order) {
  final json = order.toJson();
  return jsonEncode(json);
}
