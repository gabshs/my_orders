import 'package:flutter/material.dart';
import 'package:front/api/api_service.dart';
import 'package:front/models/order.dart';
import 'package:front/widgets/build_app_bar_widget.dart';
import 'package:front/widgets/list_orders_widget.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/pedidos/form'),
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
                    'Pedidos',
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
                        Text('Pedido'),
                        Text('Nome'),
                        Text('Valor'),
                        Text('Data'),
                        Text('Ações'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: apiService.getOrders(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                                'Oppsss. Houve um erro inesperado: ${snapshot.error.toString()}'),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          List<Order> orders = snapshot.data;
                          return ListOrders(orders: orders);
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
