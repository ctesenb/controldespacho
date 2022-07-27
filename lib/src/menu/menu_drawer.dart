import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../pages/carga/carga_ui.dart';
import '../pages/entrega/entrega_ui.dart';
import '../pages/llegada/llegada_ui.dart';
import '/src/pages/login/login_helper.dart';

class MenuLateral extends StatefulWidget {
  @override
  State<MenuLateral> createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/icons/logo-control-plus.png',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          /*ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              validarMenu();
              if (menu == true) {
                Get.to(PerfilUI());
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Perfil"),
                    content: const Text("No hay sesión iniciada"),
                    actions: [
                      ElevatedButton(
                        child: const Text("Cerrar"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              }
            },
          ),*/
          ListTile(
            leading: Icon(Icons.production_quantity_limits),
            title: Text('Carga de Mecaderia'),
            onTap: () {
              print('Carga de Mecaderia');
              validarMenu();
              if (menu == true) {
                Get.to(CargaUI());
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Carga de Mecaderia"),
                    content: const Text("No hay sesión iniciada"),
                    actions: [
                      ElevatedButton(
                        child: const Text("Cerrar"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.production_quantity_limits),
            title: Text('Llegada del Cliente'),
            onTap: () {
              print('Llegada del Cliente');
              validarMenu();
              if (menu == true) {
                Get.to(LlegadaUI());
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Llegada del Cliente"),
                    content: const Text("No hay sesión iniciada"),
                    actions: [
                      ElevatedButton(
                        child: const Text("Cerrar"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.production_quantity_limits),
            title: Text('Entrega de Pedidos'),
            onTap: () {
              print('Entrega de Pedidos');
              validarMenu();
              if (menu == true) {
                Get.to(EntregaUI());
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Entrega de Pedidos"),
                    content: const Text("No hay sesión iniciada"),
                    actions: [
                      ElevatedButton(
                        child: const Text("Cerrar"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              }
            },
          ),/*
          ListTile(
            leading: Icon(Icons.clear),
            title: Text('empty'),
            onTap: () {
              validarMenu();
              if (menu == true) {
                //PAGINA DE DESTINO
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("empty"),
                    content: const Text("No hay sesión iniciada"),
                    actions: [
                      ElevatedButton(
                        child: const Text("Cerrar"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.clear),
            title: Text('empty'),
            onTap: () {
              validarMenu();
              if (menu == true) {
                //PAGINA DE DESTINO
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("empty"),
                    content: const Text("No hay sesión iniciada"),
                    actions: [
                      ElevatedButton(
                        child: const Text("Cerrar"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.clear),
            title: Text('empty'),
            onTap: () {
              validarMenu();
              if (menu == true) {
                //PAGINA DE DESTINO
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("empty"),
                    content: const Text("No hay sesión iniciada"),
                    actions: [
                      ElevatedButton(
                        child: const Text("Cerrar"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar Sesión'),
            onTap: () {
              validarMenu();
              if (menu == true) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Cerrar sesión"),
                    content:
                        const Text("¿Está seguro que desea cerrar sesión?"),
                    actions: [
                      ElevatedButton(
                        child: const Text("Cancelar"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      ElevatedButton(
                        child: const Text("Cerrar sesión"),
                        onPressed: () {
                          controller.signOutWithGoogle();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              } else {
                //Desing dialogo para decir que no hay sesión iniciada
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Cerrar sesión"),
                    content: const Text("No hay sesión iniciada"),
                    actions: [
                      ElevatedButton(
                        child: const Text("Cerrar"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              }
            },
          ),*/
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Salir'),
            onTap: () {
              //desing dialogo para decir que se va a salir de la aplicación
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Salir"),
                  content: const Text("¿Está seguro que desea salir?"),
                  actions: [
                    ElevatedButton(
                      child: const Text("Cancelar"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ElevatedButton(
                      child: const Text("Salir"),
                      onPressed: () => SystemNavigator.pop(),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/*
*CONTROLADOR DE LOGIN
*/
final controller = Get.put(LoginHelper());
/*
*VALIDADOR DEL MENU
*/
bool menu = false;
bool validarMenu() {
  if (controller.googleAccount.value != null) {
    return menu = true;
  } else {
    return menu = false;
  }
}
