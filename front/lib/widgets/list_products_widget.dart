import 'package:flutter/material.dart';
import 'package:front/api/api_service.dart';
import 'package:front/models/product.dart';
import 'package:front/screens/product_form_screen.dart';

class ListProducts extends StatefulWidget {
  final List<Product> products;

  ListProducts({this.products});

  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        Product product = widget.products[index];
        return Container(
          color: Color(0xFFE5E5E5),
          margin: EdgeInsets.only(bottom: 1),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${product.id}'),
              Text(product.name),
              Text(product.price.toStringAsFixed(2)),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductFormScreen(product: product);
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
                      _confirmDialog(product);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmDialog(Product product) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cuidado!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Tem certeza que deseja deletar esse Produto?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Sim'),
              onPressed: () {
                api.deleteProduct(product.id);
                Navigator.of(context).pushReplacementNamed('/produtos');
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
