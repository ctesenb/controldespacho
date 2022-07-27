import 'package:controldespacho/src/pages/carga/carga_ui.dart';
import 'package:controldespacho/src/pages/entrega/entrega_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'pages/llegada/llegada_ui.dart';
import 'pages/login/login_ui.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control de Despacho',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: AnimatedSplashScreen(
        splash: 'assets/icons/logo-control-plus.png',
        nextScreen: LoginUI(),
        splashTransition: SplashTransition.rotationTransition,
        pageTransitionType: PageTransitionType.fade,
      ),
      routes: {
        LoginUI.id: (context) => LoginUI(),
        EntregaUI.id: (context) => EntregaUI(),
        CargaUI.id: (context) => CargaUI(),
        LlegadaUI.id: (context) => LlegadaUI(),
      },
    );
  }
}
