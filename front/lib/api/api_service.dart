import 'dart:convert';

import 'package:front/models/customer.dart';
import 'package:front/models/order.dart';
import 'package:front/models/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:3000';

  Future<List<Customer>> getCustomers() async {
    final response = await http.get(Uri.parse('$baseUrl/customers'));
    if (response.statusCode == 200) {
      return customerFromJson(response.body);
    }
  }

  Future<bool> createCustomer(Customer data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/customers"),
      headers: {"content-type": "application/json"},
      body: customerToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateCustomer(Customer data) async {
    final response = await http.put(
      Uri.parse("$baseUrl/customers/${data.id}"),
      headers: {"content-type": "application/json"},
      body: customerToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCustomer(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/customers/$id"),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      return productFromJson(response.body);
    }
  }

  Future<bool> createProduct(Product data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/products"),
      headers: {"content-type": "application/json"},
      body: productToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProduct(Product data) async {
    final response = await http.put(
      Uri.parse("$baseUrl/products/${data.id}"),
      headers: {"content-type": "application/json"},
      body: productToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteProduct(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/products/$id"),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Order>> getOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/orders'));
    if (response.statusCode == 200) {
      return orderFromJson(response.body);
    }
  }

  Future<bool> createOrder(Order data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/orders"),
      headers: {"content-type": "application/json"},
      body: orderToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<Order> showOrder(Order data) async {
    final response = await http.get(Uri.parse('$baseUrl/orders/${data.id}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Order.fromJson(data);
    }
  }

  Future<bool> deleteOrder(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/orders/$id"),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
