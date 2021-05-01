import 'package:flutter/material.dart';
import 'package:front/api/api_service.dart';
import 'package:front/models/customer.dart';
import 'package:front/models/order.dart';
import 'package:front/models/product.dart';
import 'package:front/widgets/build_app_bar_widget.dart';

class OrderFormScreen extends StatefulWidget {
  @override
  _OrderFormScreenState createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  ApiService apiService = ApiService();

  int customerCount = 0;
  Customer customer;
  List<Product> products = [];

  int selectedRadio = 0;
  int product;
  bool selected = false;
  List<bool> productStatus = [false, false, false, false, false, false, false];
  double totalValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: Container(
          width: 1000,
          height: 600,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.only(top: 30),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Column(
                children: [
                  Text(
                    'Novo Pedido',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'Selecione o Cliente',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: apiService.getCustomers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                                'Oppsss. Houve um erro inesperado: ${snapshot.error.toString()}'),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          List<Customer> customers = snapshot.data;
                          return ListView.builder(
                            itemCount: customers.length,
                            itemBuilder: (context, index) {
                              Customer c = customers[index];
                              return ListTile(
                                title: Text(c.name),
                                leading: Radio(
                                  value: c.id,
                                  groupValue: selectedRadio,
                                  onChanged: (value) {
                                    setState(() {
                                      customerCount = value;
                                      customer = c;
                                      selectedRadio = value;
                                    });
                                    print(c.id);
                                    print(customer.id);
                                  },
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'Selecione os Produtos',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: apiService.getProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                                'Oppsss. Houve um erro inesperado: ${snapshot.error.toString()}'),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          List<Product> products = snapshot.data;

                          return ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  title: Text(products[index].name),
                                  subtitle: Text(
                                      products[index].price.toStringAsFixed(2)),
                                  value: productStatus[index],
                                  onChanged: (value) {
                                    setState(() {
                                      productStatus[index] =
                                          !productStatus[index];
                                    });
                                    productStatus.forEach((element) {
                                      print(element);
                                    });
                                  },
                                );
                              });
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      child: Text(
                        "Enviar".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        List<Product> p = await apiService.getProducts();
                        for (int i = 0; i < productStatus.length; i++) {
                          if (productStatus[i] == true) {
                            products.add(p[i]);
                          }
                        }

                        products
                            .forEach((element) => totalValue += element.price);
                        productStatus.forEach((status) {});
                        Order order = Order(
                          customer: customer,
                          products: products,
                          price: totalValue,
                          date: DateTime.now(),
                        );
                        apiService.createOrder(order).then((isSuccess) {
                          if (isSuccess) {
                            Navigator.of(context).pushReplacementNamed('/');
                          } else {
                            return SnackBar(
                              content: Text("Falha ao enviar"),
                            );
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
