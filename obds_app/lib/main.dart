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

ConnectionSettings sql_cred=new ConnectionSettings(
      host: 'remotemysql.com',
      port: 3306,
      user: 'ED3QOAIOQK',
      password: 'yz51KaPFRg',
      db: 'ED3QOAIOQK'
    );
List<String> organList= new List<String>(6);
void main(){
  organList[0]="Cornea";
  organList[1]="Heart";
  organList[2]="Kidney";
  organList[3]="Liver";
  organList[4]="Lung";
  organList[5]="Pancreas";
  print(organList);
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

