import 'package:controldespacho/src/connection/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:majascan/majascan.dart';
import '../../services/horaactual.dart';
import '../login/login_helper.dart';
import '/src/utils/notificaciones.util.dart' as util;

class EntregaScreen extends StatefulWidget {
  EntregaScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<EntregaScreen> createState() => _EntregaScreenState();
}

final controller = Get.put(LoginHelper());

class _EntregaScreenState extends State<EntregaScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Entrega()); //Entrega();
  }
}

class Entrega extends StatefulWidget {
  const Entrega({
    Key? key,
  }) : super(key: key);

  @override
  State<Entrega> createState() => _EntregaState();
}

class _EntregaState extends State<Entrega> {
  final controller = Get.put(LoginHelper());
  String qr = '# Pedido';
  var numPedido = TextEditingController();
  var nomCliente = TextEditingController();
  String pedido = '';
  String cliente = '';

  bool isButtonEnabled = false;
  String diaHora = '';

  void initState() {
    super.initState();
  }

  void dispose() {
    numPedido.dispose();
    nomCliente.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Entrega\nde\nPedidos',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: Colors.teal),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: InkWell(
                        splashColor: Colors.teal,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.qr_code_scanner,
                              color: Colors.white,
                              size: 60,
                            ),
                            Text('Escanear QR'),
                          ],
                        ),
                      ),
                      onPressed: () => abrirMajaScan()),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: numPedido,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Numero de Pedido',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nomCliente,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nombre del Cliente',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: InkWell(
                        splashColor: Colors.teal,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 80,
                            ),
                            Text('Entregar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        onSurface: Colors.teal,
                      ),
                      onPressed: isButtonEnabled
                          ? () {
                              if (numPedido.text.isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  'Debe escanear el codigo del pedido',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  borderRadius: 10,
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: Duration(seconds: 2),
                                );
                              } else if (nomCliente.text.isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  'Debe escanear el codigo del pedido',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  borderRadius: 10,
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: Duration(seconds: 2),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Confirmar Entrega'),
                                    content: Text(
                                        '¿Esta seguro que desea confirmar la Entrega?\n\nPedido: $pedido\nCliente: $cliente\n'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Cancelar'),
                                        onPressed: () => Get.back(),
                                      ),
                                      TextButton(
                                        child: const Text('Confirmar'),
                                        onPressed: () {
                                          entregarPedido();
                                          setState(() {
                                            isButtonEnabled = false;
                                          });
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          : null),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  abrirMajaScan() async {
    try {
      String? qrResult = await MajaScan.startScan(
        title: 'Escanear...',
        titleColor: Colors.amberAccent[700],
        qRCornerColor: Colors.orange,
        qRScannerColor: Colors.orange,
      );
      setState(() {
        qr = qrResult ?? 'Escaneo Invalido';
        var temp = qr.split("|");
        pedido = temp[0];
        cliente = temp[1];
        numPedido.text = pedido;
        nomCliente.text = cliente;
        isButtonEnabled = true;
      });
      print(qr);
    } on PlatformException catch (e) {
      if (e.code == MajaScan.CameraAccessDenied) {
        setState(() {
          util.mostraralerta(
              context, 'Alerta', 'No se puede acceder a la camara');
        });
      } else {
        setState(() {
          util.mostraralerta(context, 'Alerta', 'Escaneo invalido $e');
        });
      }
    } on FormatException {
      setState(() {
        util.mostraralerta(context, 'Alerta', 'Escaneo invalido');
      });
    } catch (e) {
      setState(() {
        util.mostraralerta(context, 'Alerta', 'Error: $e');
      });
      print(e);
    }
  }

  entregarPedido() async {
    try {
      var db = Mysql();
      diaHora = DateTime.now().day.toString() + " " + horaActual;
      String entrega = 'L | ' + diaHora;

      String query =
          'UPDATE registrodespacho SET entrega = "$entrega" WHERE idpedido = "$pedido"';
      confirmarPedido();
      if (codigoExiste == true) {
        db.getConnection().then((conn) async {
          await conn.query(query).then((value) {
            print('Entrega de Pedido: $pedido');
            print(value);
            setState(() {
              numPedido.text = '';
              nomCliente.text = '';
            });
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Registro de Entrega Exitoso'),
                content: Text('\nPedido: $pedido\nCliente: $cliente'),
                actions: [
                  TextButton(
                    child: const Text('Aceptar'),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            );

            Get.back();
          });
        });
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(
                '\nPedido: $pedido\nCliente: $cliente\n\nNo se encontro el pedido en el registro de llegada'),
            actions: [
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content:
              Text('No se pudo registrar la entrega del pedido: $pedido\n\n'),
          actions: [
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );

      print('Error al Entregar: ' + e.toString());
    }
  }

  bool codigoExiste = false;

  confirmarPedido() async {
    try {
      var db = Mysql();
      String query = 'SELECT * FROM registrodespacho WHERE idpedido = $pedido';
      db.getConnection().then((conn) {
        conn.query(query).then((result) {
          print(result);
          if (result.length > 0) {
            setState(() {
              codigoExiste = true;
            });
          } else {
            setState(() {
              codigoExiste = false;
            });
          }
        });
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('No se pudo confirmar el pedido: $pedido\n\n'),
          actions: [
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );
      print('Error al confirmar si el pedido existe: ' + e.toString());
    }
  }
}
