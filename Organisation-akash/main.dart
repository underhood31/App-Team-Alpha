//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:organisationapp/Cornea.dart';
import 'package:organisationapp/Eligible.dart';
import 'package:organisationapp/Pending.dart';
import 'package:organisationapp/Shortage.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(context) => MyApp(),
      '/shortage':(context) => shortage(),
      '/eligible':(context) => eligible_donors(),
      '/pending':(context) => pending_checkup(),
      '/cornea':(context) => cornea(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab( icon: Icon(Icons.local_hospital),),
                Tab( icon: Icon(Icons.remove_red_eye),),
                Tab(icon: Icon(Icons.healing),)
          ],
            ),
            title: Text(
              "Organisation" , style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22.0,
            ),
            ),
            ),
          body: TabBarView(
            children: [
              ListView(
                children: [
                  Card(
                    child: ListTile(
                      leading: FlutterLogo(),
                      title: Text("Blood Group Shortage"),
                      onTap: (){
                        Navigator.pushNamed(context, '/shortage');
                      },
                    ),
                  ),
                  SizedBox(height: 3.0,),
                  Card(
                    child: ListTile(
                      leading: FlutterLogo(),
                      title: Text("Eligible Blood Donors"),
                      onTap: (){
                        Navigator.pushNamed(context, '/eligible');
                      },
                    ),
                  )
                ],
              ),
              ListView(
                children: [
                  Card(
                    child: ListTile(
                      leading: FlutterLogo(),
                      title: Text("Collection of Cornea"),
                      onTap: (){
                        Navigator.pushNamed(context,'/cornea' );
                      },
                    ),
                  )
                ],
              ),
              ListView(
                children: [
                  Card(
                    child: ListTile(
                      leading: FlutterLogo(),
                      title: Text("Checkup Pending Donor Applicants"),
                      onTap: (){
                        Navigator.pushNamed(context, '/pending');
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
    ),
      ),
    );
  }
}
