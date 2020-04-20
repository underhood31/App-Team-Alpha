import 'package:flutter/material.dart';
import 'package:obdsapp/src/doctor.dart';
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
      title: 'Organ and Blood Dontaion System',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: (Doctor()),
    )
  );
}

