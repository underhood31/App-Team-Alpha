import 'package:mysql1/mysql1.dart';
import '../main.dart';

//  host: 'remotemysql.com',
//       port: 3306,
//       user: 'ED3QOAIOQK',
//       password: 'yz51KaPFRg',
//       db: 'ED3QOAIOQK'
class Mysql {
 
  Future<MySqlConnection> getConnection() async {
    var settings = sql_cred;
    return await MySqlConnection.connect(settings);
  }
}