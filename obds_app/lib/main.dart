import 'package:flutter/material.dart';
import './src/login.dart';
import 'package:mysql1/mysql1.dart';

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

ConnectionSettings sql_cred;

void main(){
  runApp(
      MaterialApp(
      title: 'Protsahan India Foundation',
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      home: (LoginPage()),
    )
  );
}

