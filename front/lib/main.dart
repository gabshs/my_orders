import 'package:flutter/material.dart';
import 'package:front/screens/customer_form_screen.dart';
import 'package:front/screens/customers_page_screen.dart';
import 'package:front/screens/home_page_screen.dart';
import 'package:front/screens/order_form_screen.dart';
import 'package:front/screens/product_form_screen.dart';
import 'package:front/screens/products_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My orders',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: {
        '/': (ctx) => HomePageScreen(),
        '/pedidos/form': (ctx) => OrderFormScreen(),
        '/clientes': (ctx) => CustomersPageScreen(),
        '/clientes/form': (ctx) => CustomerFormScreen(),
        '/produtos': (ctx) => ProductsPage(),
        '/produtos/form': (ctx) => ProductFormScreen(),
        '/produtos/mostrar': (ctx) => ProductFormScreen(),
      },
    );
  }
}
