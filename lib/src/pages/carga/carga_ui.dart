import 'package:flutter/material.dart';

import '../../menu/menu_drawer.dart';
import 'carga_screen.dart';

class CargaUI extends StatefulWidget {
  static String id = "carga_ui";
  @override
  State<CargaUI> createState() => _CargaUIState();
}

class _CargaUIState extends State<CargaUI> {
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
        body: CargaScreen(),
      ),
    );
  }
}
