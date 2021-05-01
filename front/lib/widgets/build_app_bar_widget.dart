import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    shadowColor: Colors.deepPurple,
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextButton(
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed('/clientes'),
          child: Text(
            'Clientes',
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextButton(
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed('/produtos'),
          child: Text(
            'Produtos',
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
          child: Text(
            'Pedidos',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ],
  );
}
