import 'package:flutter/material.dart';
import 'package:front/api/api_service.dart';
import 'package:front/models/customer.dart';
import 'package:front/screens/customer_form_screen.dart';
import 'package:intl/intl.dart';

class ListCustomers extends StatefulWidget {
  const ListCustomers({
    Key key,
    @required this.customers,
  }) : super(key: key);

  final List<Customer> customers;

  @override
  _ListCustomersState createState() => _ListCustomersState();
}

class _ListCustomersState extends State<ListCustomers> {
  ApiService api = ApiService();
  @override
  Widget build(BuildContext context) {
    return widget.customers.length > 0
        ? ListView.builder(
            itemCount: widget.customers.length,
            itemBuilder: (context, index) {
              Customer customer = widget.customers[index];
              return Container(
                color: Color(0xFFE5E5E5),
                margin: EdgeInsets.only(bottom: 1),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${customer.id}'),
                    Text(customer.name),
                    Text(customer.phone),
                    Text(DateFormat('dd/MM/y').format(customer.birthday)),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CustomerFormScreen(customer: customer);
                                },
                              ),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _confirmDialog(customer);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          )
        : Center();
  }

  Future<void> _confirmDialog(Customer customer) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cuidado!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Tem certeza que deseja deletar esse Cliente?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Sim'),
              onPressed: () {
                api.deleteCustomer(customer.id);
                Navigator.of(context).pushReplacementNamed('/clientes');
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
