import 'package:flutter/material.dart';
import '../../menu/menu_drawer.dart';
import 'login_screen.dart';

/*
*LOGIN GUI
*/
class LoginUI extends StatefulWidget {
  static String id = "login_ui";

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Control de Depacho",
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
        body: LoginScreen(),
      ),
    );
  }
}
