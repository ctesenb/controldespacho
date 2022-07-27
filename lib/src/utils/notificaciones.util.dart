import 'package:flutter/material.dart';
//import 'package:appnoname/src/pages/factura/ordenCompraPage.dart';

mostraralerta(BuildContext context, String header, String mensaje) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(header),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
      });
}

mostraralerta2(BuildContext context, String header, String mensaje) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(header),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pushNamed(context, 'menu'),
                child: Text('Ok'))
          ],
        );
      });
}


mostrarAlertaMetodo(BuildContext context, String header, String mensaje,
    VoidCallback onPressed) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(header),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(onPressed: () => onPressed, child: Text('Ok'))
          ],
        );
      });
}

mostrarAlertaVacia(String tittle) {
  return Center(
      child: Card(
    elevation: 5.0,
    child: Container(
        width: 300.0,
        height: 200.0,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.red,
              size: 50.0,
            ),
            SizedBox(height: 20.0),
            Text(tittle),
          ],
        ))),
  ));
}
