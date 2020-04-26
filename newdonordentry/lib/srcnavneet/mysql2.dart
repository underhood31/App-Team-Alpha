// import 'package:mysql1/mysql1.dart';

// //  host: 'remotemysql.com',
// //       port: 3306,
// //       user: 'ED3QOAIOQK',
// //       password: 'yz51KaPFRg',
// //       db: 'ED3QOAIOQK'
//   // static String host = 'localhost',
//   //               user = 'navneet',
//   //               password = 'Qwerty12@',
//   //               db = 'obds';
//   // static int port = 3306;

// class Mysql2_ {
//   static String host = 'remotemysql.com',
//                 user = 'ED3QOAIOQK',
//                 password = 'yz51KaPFRg',
//                 db = 'ED3QOAIOQK';
//   static int port = 3306;

//   Mysql2_();

//   Future<MySqlConnection> getConnection() async {
//     var settings = new ConnectionSettings(
//       host: host,
//       port: port,
//       user: user,
//       password: password,
//       db: db
//     );
//     return await MySqlConnection.connect(settings);
//   }
// }