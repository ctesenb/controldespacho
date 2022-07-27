import 'dart:ffi';

import 'package:controldespacho/src/connection/db.dart';
import 'package:controldespacho/src/services/horaactual.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majascan/majascan.dart';
import '../login/login_helper.dart';
import '/src/utils/notificaciones.util.dart' as util;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class LlegadaScreen extends StatefulWidget {
  LlegadaScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<LlegadaScreen> createState() => _LlegadaScreenState();
}

class _LlegadaScreenState extends State<LlegadaScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Llegada()); //Llegada();
  }
}

class Llegada extends StatefulWidget {
  const Llegada({
    Key? key,
  }) : super(key: key);

  @override
  State<Llegada> createState() => _LlegadaState();
}

class _LlegadaState extends State<Llegada> {
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
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Logo
              Image.asset(
                'assets/icons/controldespacho.png',
                height: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              //Fila de dos columnas
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Codigo del Pedido',
                          ),
                          controller: numPedido,
                          readOnly: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nombre del Cliente',
                          ),
                          controller: nomCliente,
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 80,
                      maxWidth: 160,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        shadowColor: Colors.teal,
                      ),
                      //Image.asset('assets/buttons/qr_scan.png'),
                      onPressed: () => abrirMajaScan(),
                      child: Container(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'ESCANEAR\n',
                              style: TextStyle(fontSize: 15),
                            ),
                            Image.asset(
                              'assets/buttons/qr-code.png',
                              height: 80,
                            ),
                            Text(
                              '\nQR',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 250,
                      maxWidth: 300,
                    ),
                    child: ElevatedButton.icon(
                      icon:
                          Image.asset('assets/buttons/pedido.png', height: 50, alignment: Alignment.center,),
                      label: const Text(
                        'LLEGADA',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Roboto',
                            letterSpacing: 1.5),
                      ),
                      style: ElevatedButton.styleFrom(
                        onSurface: Colors.teal,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                        shadowColor: Colors.teal,
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
                                    title: const Text('Confirmar Llegada'),
                                    content: Text(
                                        '¿Esta seguro que desea confirmar la Llegada?\n\nPedido: $pedido\nCliente: $cliente\n'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Cancelar'),
                                        onPressed: () => Get.back(),
                                      ),
                                      TextButton(
                                        child: const Text('Confirmar'),
                                        onPressed: () {
                                          getTime();
                                          confirmarLlegada();
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
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 250,
                      maxWidth: 300,
                    ),
                    child: ElevatedButton.icon(
                      icon:
                          Image.asset('assets/buttons/entrega.png', height: 50, alignment: Alignment.center,),
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
                                          getTime();
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
                          : null,
                      style: ElevatedButton.styleFrom(
                        onSurface: Colors.teal,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                        shadowColor: Colors.teal,
                      ),
                      label: const Text(
                        'ENTREGA',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Roboto',
                            letterSpacing: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 250,
                      maxWidth: 300,
                    ),
                    child: ElevatedButton.icon(
                      icon:
                          Image.asset('assets/buttons/carga.png', height: 50, alignment: Alignment.center,),
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
                                        'EN CONSTRUCCION'),
                                  ),
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        onSurface: Colors.teal,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                        shadowColor: Colors.teal,
                      ),
                      label: const Text(
                        'CARGA',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Roboto',
                            letterSpacing: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  entregarPedido() async {
    try {
      var db = Mysql();
      confirmarPedido();
      diaHora = DateTime.now().day.toString() + " " + horaActual;
      String entrega = horaActual;

      String query =
          'UPDATE registrodespacho SET entrega = "$entrega" WHERE idpedido = "$pedido"';

      if (codigoExiste == true) {
        db.getConnection().then((conn) async {
          await conn.query(query).then((value) {
            print('Registro de Entrega Exitoso');
            print(value);
            setState(() {
              numPedido.text = '';
              nomCliente.text = '';
            });
            setState(() {
              util.mostraralerta(context, 'Registro de Entrega Exitoso',
                  '\nPedido: $pedido\nCliente: $cliente');
              numPedido.text = '';
              nomCliente.text = '';
            });
          });
        });
      }
    } catch (e) {
      util.mostraralerta(context, 'Alerta', 'No se pudo confirmar la Entrega');
      print('Error al Entregar: ' + e.toString());
    }
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
        util.mostraralerta(context, 'Alerta', 'No se pudo escanear');
      });
      print(e);
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

  confirmarLlegada() async {
    try {
      Position position = await obtenerGeolocalizacion();
      var db = Mysql();
      db.getConnection().then(
        (conn) {
          String idpedido = pedido;
          String idusuariogoogle = controller.googleAccount.value!.email;
          String geolocalizacion = position.longitude.toString() +
              ',' +
              position.latitude.toString();
          diaHora = DateTime.now().day.toString() + " " + horaActual;
          String llegada = horaActual;

          String query =
              'INSERT INTO registrodespacho (idpedido,idusuariogoogle,geolocalizacion,diahora,llegada) VALUES ("$idpedido","$idusuariogoogle","$geolocalizacion","$diaHora","$llegada")';
          conn.query(query).then((result) {
            print('Registro de Llegada Exitoso');
            print(result);
            setState(() {
              util.mostraralerta(context, 'Registro de Llegada Exitoso',
                  '\nPedido: $idpedido\nCliente: $cliente');
              numPedido.text = '';
              nomCliente.text = '';
            });
          });
        },
      );
    } catch (e) {
      util.mostraralerta(context, 'Alerta', 'No se pudo confirmar la Llegada');
      print('Error Llegada: $e');
    }
  }

  bool serviceEnabled = false;
  late LocationPermission permission;
  obtenerGeolocalizacion() async {
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission == Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          util.mostraralerta(
              context, 'Alerta', 'El permiso de ubicacion no esta activado');
          return Future.error('Permiso denegado');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        util.mostraralerta(
            context, 'Alerta', 'El permiso de ubicacion no esta activado');
        return Future.error('Permiso denegado permanentemente');
      }
      if (!serviceEnabled) {
        util.mostraralerta(
            context, 'Alerta', 'El servicio de ubicacion no esta activado');
        return Future.error('Servicio desactivado');
      }
      return Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print('Error de Permisos Ubicacion: $e');
    }
  }
}
