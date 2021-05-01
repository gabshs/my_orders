import 'package:flutter/material.dart';
import 'package:front/api/api_service.dart';
import 'package:front/models/product.dart';
import 'package:front/widgets/build_app_bar_widget.dart';

class ProductFormScreen extends StatefulWidget {
  final Product product;

  ProductFormScreen({this.product});

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();

  bool _isFieldNameValid;
  bool _isFieldPriceValid;

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();

  @override
  void initState() {
    if (widget.product != null) {
      _isFieldNameValid = true;
      _controllerName.text = widget.product.name;
      _isFieldPriceValid = true;
      _controllerPrice.text = widget.product.price.toStringAsFixed(2);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
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
                    widget.product != null ? 'Editar Produto' : 'Novo Produto',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  TextField(
                    controller: _controllerName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Nome",
                      errorText: _isFieldNameValid == null || _isFieldNameValid
                          ? null
                          : "Nome obrigatório",
                    ),
                    onChanged: (value) {
                      bool isFieldValid = value.trim().isNotEmpty;
                      if (isFieldValid != _isFieldNameValid) {
                        setState(() => _isFieldNameValid = isFieldValid);
                      }
                    },
                  ),
                  TextField(
                    controller: _controllerPrice,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Preço",
                      errorText:
                          _isFieldPriceValid == null || _isFieldPriceValid
                              ? null
                              : "Preço é obrigatório",
                    ),
                    onChanged: (value) {
                      bool isFieldValid = value.trim().isNotEmpty;
                      if (isFieldValid != _isFieldPriceValid) {
                        setState(() => _isFieldPriceValid = isFieldValid);
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      child: Text(
                        widget.product == null
                            ? "Enviar".toUpperCase()
                            : "Atualizar".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        setState(() => _isLoading = true);
                        String name = _controllerName.text.toString();
                        double price =
                            double.parse(_controllerPrice.text.toString());

                        Product product = Product(name: name, price: price);
                        if (widget.product == null) {
                          _apiService.createProduct(product).then((isSuccess) {
                            setState(() => _isLoading = false);
                            if (isSuccess) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/produtos');
                            } else {
                              return SnackBar(
                                content: Text("Falha ao enviar"),
                              );
                            }
                          });
                        } else {
                          product.id = widget.product.id;
                          _apiService.updateProduct(product).then((isSuccess) {
                            setState(() => _isLoading = false);
                            if (isSuccess) {
                              // Navigator.of(context)
                              //     .pushReplacementNamed('/clientes');
                              Navigator.of(context)
                                  .popAndPushNamed('/produtos');
                            } else {
                              return SnackBar(
                                content: Text("Falha ao atualizar dados"),
                              );
                            }
                          });
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
    ;
  }
}
