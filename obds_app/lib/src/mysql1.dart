import 'package:mysql1/mysql1.dart';
import '../main.dart';

//  host: 'remotemysql.com',
//       port: 3306,
//       user: 'ED3QOAIOQK',
//       password: 'yz51KaPFRg',
//       db: 'ED3QOAIOQK'
class Mysql {
  static String host = sql_cred.host,
                user = sql_cred.user,
                password = sql_cred.password,
                db = sql_cred.db;
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db
    );
    return await MySqlConnection.connect(settings);
  }
}