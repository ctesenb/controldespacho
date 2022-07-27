import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../llegada/llegada_screen.dart';
import 'login_helper.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginHelper());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Obx(() {
          if (controller.googleAccount.value == null) {
            return Login(controller: controller);
          } else {
            return LlegadaScreen();
            //return PerfilScreen();
          }
        }),
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginHelper controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(
            'assets/icons/controldespacho.png',
            height: 100,
          ),
          const SizedBox(
            height: 35,
          ),
          const Text(
            "Inicia sesión con Google",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              shadows: [
                Shadow(
                  blurRadius: 2,
                  color: Colors.black,
                  offset: Offset(1, 1),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 25,
          ),
          SignInButton(
            Buttons.Google,
            text: 'Iniciar con Google',
            padding: const EdgeInsets.all(4.0),
            elevation: 12.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onPressed: () {
              controller.signInWithGoogle();
            },
          )
        ],
      ),
    );
  }
}
