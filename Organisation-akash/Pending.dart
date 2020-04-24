import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class pending_checkup extends StatefulWidget {
  @override
  _pending_checkupState createState() => _pending_checkupState();
}

class _pending_checkupState extends State<pending_checkup> {
  List<Applicants> l=[Applicants(name: "Aman", bld_grp:"O+" ,checkup_date:"12/5/2016" ),   //backend dummy
    Applicants(name: "Naman", bld_grp:"B+" ,checkup_date:"12/5/2018" )
  ];

  Widget ApplicantTemplate(pending){
    return ApplicantCard(apps: pending,);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Applicants"),
      ),
      body:  Column(
        children: l.map((Applicants) => ApplicantCard(apps: Applicants)).toList(),
      ),
    );
  }
}

class ApplicantCard extends StatelessWidget {
 final Applicants apps;
 ApplicantCard({this.apps});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          apps.name+"    "+apps.bld_grp+"     "+apps.checkup_date,
        ),
      ),
    );
  }
}
class Applicants{
  String name;
  String bld_grp;
  String checkup_date;
  Applicants({String name, String bld_grp, String checkup_date}){
    this.name=name;
    this.bld_grp=bld_grp;
    this.checkup_date=checkup_date;
  }
}