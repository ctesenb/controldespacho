import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../login/login_helper.dart';

class CargaScreen extends StatefulWidget {
  CargaScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<CargaScreen> createState() => _CargaScreenState();
}

final controller = Get.put(LoginHelper());


class _CargaScreenState extends State<CargaScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Carga()); //Carga();
  }
}

class Carga extends StatelessWidget {
  const Carga({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            //EN CONTRUCCION
            children: [
              Text('EN CONSTRUCCION'),
            ],
          ),
        ),
      ),
    );
  }
}
