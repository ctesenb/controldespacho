import 'dart:math' as math;
import 'package:flutter/material.dart';

class Responsive {
  //Variables
  late double width, height, inch;
  //Principal
  Responsive(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    inch = math.sqrt(math.pow(width, 2) + math.pow(height, 2));
  }
  //wp
  double wp(double percent) {
    return width * percent / 100;
  }

  //hp
  double hp(double percent) {
    return height * percent / 100;
  }

  //ip
  double ip(double percent) {
    return inch * percent / 100;
  }
}

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
