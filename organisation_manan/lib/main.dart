import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import './src/Organisations.dart';
class Field{
  int id;
  String name;
  var fieldData;
  Field(int i, String n){
    id = i;
    name = n;
  }
  void set(int i, String n){
    id = i;
    name = n;
  }  
}
ConnectionSettings sql_cred=new ConnectionSettings(
      host: 'remotemysql.com',
      port: 3306,
      user: 'ED3QOAIOQK',
      password: 'yz51KaPFRg',
      db: 'ED3QOAIOQK'
    );  
void main()
{
  runApp(
    MaterialApp(
      title:'Organ and Blood Donation System',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: (Organisation('ORG_951')),
    )
  );
}