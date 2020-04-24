import 'package:flutter/material.dart';

class cornea extends StatefulWidget {
  @override
  _corneaState createState() => _corneaState();
}

class _corneaState extends State<cornea> {
  List<Cornea> l=[Cornea(name: "Aman", bld_grp:"O+" ,organ: "Cornea" , organid: 124),   //backend dummy
   Cornea(name: "Naman", bld_grp:"B+" ,organ:"Cornea", organid: 125)
  ];

  Widget corneaTemplate(dead){
    return CorneaCard(c: dead);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organs Donated After Death"),
      ),
      body:  Column(
        children: l.map((Cornea) => CorneaCard(c: Cornea)).toList(),
      ),
    );
  }
}
class CorneaCard extends StatelessWidget {
  final Cornea c;
  CorneaCard({this.c});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          c.name+"    "+c.bld_grp+"     "+c.organ+"      "+c.organid.toString(),
        ),
      ),
    );
  }
}
class Cornea{
  String name;
  String bld_grp;
  String organ;
  int organid;
  Cornea({String name, String bld_grp, String organ,int organid}){
    this.name=name;
    this.bld_grp=bld_grp;
    this.organ=organ;
    this.organid=organid;
  }
}