import 'package:flutter/material.dart';
import 'package:front/api/api_service.dart';
import 'package:front/models/order.dart';
import 'package:front/screens/product_form_screen.dart';
import 'package:front/screens/show_order_screen.dart';
import 'package:intl/intl.dart';

class ListOrders extends StatefulWidget {
  final List<Order> orders;

  ListOrders({this.orders});

  @override
  _ListOrdersState createState() => _ListOrdersState();
}

class _ListOrdersState extends State<ListOrders> {
  ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.orders.length,
      itemBuilder: (context, index) {
        Order order = widget.orders[index];
        return Container(
          color: Color(0xFFE5E5E5),
          margin: EdgeInsets.only(bottom: 1),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${order.id}'),
              Text(order.customer.name),
              Text(order.price.toStringAsFixed(2)),
              Text(DateFormat('dd/MM/y HH:mm').format(order.date)),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ShowOrderScreen(order: order);
                            },
                          ),
                        );
                      }),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmDialog(Order order) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cuidado!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Tem certeza que deseja deletar esse Pedido?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Sim'),
              onPressed: () {
                api.deleteOrder(order.id);
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            ElevatedButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
