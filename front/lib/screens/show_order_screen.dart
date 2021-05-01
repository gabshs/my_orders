import 'package:flutter/material.dart';
import 'package:front/models/order.dart';
import 'package:front/widgets/build_app_bar_widget.dart';
import 'package:intl/intl.dart';

class ShowOrderScreen extends StatelessWidget {
  final Order order;

  ShowOrderScreen({this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(bottom: 50),
            width: 1000,
            height: 800,
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
                      'Pedido nº ${order.id}',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30, bottom: 10),
                      child: Text(
                        'Cliente',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xFFE5E5E5),
                      margin: EdgeInsets.only(bottom: 1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ID'),
                          Text('Nome'),
                          Text('Telefone'),
                          Text('Data de Nascimento'),
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xFFE5E5E5),
                      margin: EdgeInsets.only(bottom: 1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(order.customer.id.toString()),
                          Text(order.customer.name),
                          Text(order.customer.phone),
                          Text(DateFormat('dd/MM/y')
                              .format(order.customer.birthday)),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30, bottom: 10),
                      child: Text(
                        'Produtos',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xFFE5E5E5),
                      margin: EdgeInsets.only(bottom: 1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ID'),
                          Text('Nome'),
                          Text('Valor'),
                        ],
                      ),
                    ),
                    ...order.products.map(
                      (p) {
                        return Container(
                          color: Color(0xFFE5E5E5),
                          margin: EdgeInsets.only(bottom: 1),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(p.id.toString()),
                              Text(p.name),
                              Text(p.price.toStringAsFixed(2)),
                            ],
                          ),
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30, bottom: 10),
                      child: Text(
                        'Valor Total',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        order.price.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30, bottom: 10),
                      child: Text(
                        "Pedido Realizado no dia ${DateFormat('dd/MM/yy HH:mm').format(order.date)}",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
