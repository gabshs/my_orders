import 'dart:convert';

class Customer {
  int id;
  final String name;
  final String phone;
  final DateTime birthday;

  Customer({
    this.id,
    this.name,
    this.phone,
    this.birthday,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      birthday: DateTime.parse(json['birthday']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'birthday': birthday.toIso8601String()
    };
  }
}

List<Customer> customerFromJson(String json) {
  final data = jsonDecode(json);
  return List<Customer>.from(data.map((item) => Customer.fromJson(item)));
}

String customerToJson(Customer customer) {
  final json = customer.toJson();
  return jsonEncode(json);
}
