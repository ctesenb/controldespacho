import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

String horaActual = '';
Future<void> getTime() async {
  try {
    final response = await get(
        Uri.parse('http://worldtimeapi.org/api/timezone/America/Lima'));
    Map data = jsonDecode(response.body);
    //print(data);
    String datetime = data['datetime'];
    String offset = data['utc_offset'].toString().substring(1, 3);
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: (-1) * int.parse(offset)));
    print(now.toString().substring(11, 19));
    horaActual = now.toString().substring(11, 19);
  } catch (e) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss').format(now);
    horaActual = formattedDate;
  }
}
