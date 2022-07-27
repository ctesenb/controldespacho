import 'package:flutter/material.dart';

import '../../menu/menu_drawer.dart';
import 'llegada_screen.dart';

class LlegadaUI extends StatefulWidget {
  static String id = "llegada_ui";
  @override
  State<LlegadaUI> createState() => _LlegadaUIState();
}

class _LlegadaUIState extends State<LlegadaUI> {
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
        body: LlegadaScreen(),
      ),
    );
  }
}
