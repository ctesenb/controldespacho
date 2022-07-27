import 'package:flutter/material.dart';

import '../../menu/menu_drawer.dart';
import 'entrega_screen.dart';

class EntregaUI extends StatefulWidget {
  static String id = "entrega_ui";
  @override
  State<EntregaUI> createState() => _EntregaUIState();
}

class _EntregaUIState extends State<EntregaUI> {
  //Poner el state para manejar el body mediante el menu, tonces usamos estados para actualizar nuestras vistas :3 recien se me ocurrio asi que ekizde XD
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Control Plus",
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/icons/logo-control-plus.png',
            height: 40,
          ),
        ),
        drawer: MenuLateral(),
        body: EntregaScreen(),
      ),
    );
  }
}
