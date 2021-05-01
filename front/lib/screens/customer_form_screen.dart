import 'package:flutter/material.dart';
import 'package:front/api/api_service.dart';
import 'package:front/models/customer.dart';
import 'package:front/widgets/build_app_bar_widget.dart';
import 'package:intl/intl.dart';

class CustomerFormScreen extends StatefulWidget {
  final Customer customer;

  CustomerFormScreen({this.customer});

  @override
  _CustomerFormScreenState createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldNameValid;
  bool _isFieldPhoneValid;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    if (widget.customer != null) {
      _isFieldNameValid = true;
      _controllerName.text = widget.customer.name;
      _isFieldPhoneValid = true;
      _controllerPhone.text = widget.customer.phone;
      _selectedDate = widget.customer.birthday;
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
                    widget.customer != null ? 'Editar Cliente' : 'Novo Cliente',
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
                    controller: _controllerPhone,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Telefone",
                      errorText:
                          _isFieldPhoneValid == null || _isFieldPhoneValid
                              ? null
                              : "Telefone é obrigatório",
                    ),
                    onChanged: (value) {
                      bool isFieldValid = value.trim().isNotEmpty;
                      if (isFieldValid != _isFieldPhoneValid) {
                        setState(() => _isFieldPhoneValid = isFieldValid);
                      }
                    },
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(_selectedDate == null
                              ? 'Nenhuma data selecionada'
                              : 'Data de Nascimento: ${DateFormat('dd/MM/y').format(_selectedDate)}'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              textStyle:
                                  TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              setState(() {
                                _selectedDate = value;
                              });
                            });
                          },
                          child: Text('Selecionar Data'),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      child: Text(
                        widget.customer == null
                            ? "Enviar".toUpperCase()
                            : "Atualizar".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        setState(() => _isLoading = true);
                        String name = _controllerName.text.toString();
                        String phone = _controllerPhone.text.toString();

                        Customer customer = Customer(
                            name: name, phone: phone, birthday: _selectedDate);
                        if (widget.customer == null) {
                          _apiService
                              .createCustomer(customer)
                              .then((isSuccess) {
                            setState(() => _isLoading = false);
                            if (isSuccess) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/clientes');
                            } else {
                              return SnackBar(
                                content: Text("Falha ao enviar"),
                              );
                            }
                          });
                        } else {
                          customer.id = widget.customer.id;
                          _apiService
                              .updateCustomer(customer)
                              .then((isSuccess) {
                            setState(() => _isLoading = false);
                            if (isSuccess) {
                              // Navigator.of(context)
                              //     .pushReplacementNamed('/clientes');
                              Navigator.of(context)
                                  .popAndPushNamed('/clientes');
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
  }
}
