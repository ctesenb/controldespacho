/*
host: 'mysql-43314-0.cloudclusters.net',
      port: 19751,
      user: 'admin',
      password: 'adbO1NJG',
      db: 'neo-deter'
      */
import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = 'mysql-83344-0.cloudclusters.net',
      user = 'admin',
      password = '01Ekrb3X',
      db = 'controldespacho';
  static int port = 10031;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);
    return await MySqlConnection.connect(settings);
  }
}
