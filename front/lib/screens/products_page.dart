import 'package:flutter/material.dart';
import 'package:front/api/api_service.dart';
import 'package:front/models/product.dart';
import 'package:front/widgets/build_app_bar_widget.dart';
import 'package:front/widgets/list_products_widget.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/produtos/form'),
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
                    'Produtos',
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
                        Text('Preço'),
                        Text('Ações'),
                      ],
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
                          return ListProducts(products: products);
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
