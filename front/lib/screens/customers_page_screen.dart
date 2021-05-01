import 'package:flutter/material.dart';
import 'package:front/api/api_service.dart';
import 'package:front/models/customer.dart';
import 'package:front/widgets/build_app_bar_widget.dart';
import 'package:front/widgets/list_customers_widget.dart';

class CustomersPageScreen extends StatefulWidget {
  final List<Customer> customers;

  CustomersPageScreen({this.customers});

  @override
  _CustomersPageScreenState createState() => _CustomersPageScreenState();
}

class _CustomersPageScreenState extends State<CustomersPageScreen> {
  final array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.of(context).pushNamed('/clientes/form');
          if (result != null) {
            setState(() {});
          }
        },
      ),
      body: Center(
        child: Container(
          width: 1000,
          height: 500,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.only(top: 100),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Column(
                children: [
                  Text(
                    'Clientes',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Container(
                    color: Color(0xFFE5E5E5),
                    margin: EdgeInsets.only(bottom: 1),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ID'),
                        Text('Nome'),
                        Text('Telefone'),
                        Text('Data de Nascimento'),
                        Text('Ações'),
                      ],
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
                          return ListCustomers(customers: customers);
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
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
