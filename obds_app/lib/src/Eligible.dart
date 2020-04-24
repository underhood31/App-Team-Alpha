import 'package:flutter/material.dart';

class eligible_donors extends StatefulWidget {
  @override
  _eligible_donorsState createState() => _eligible_donorsState();
}

class _eligible_donorsState extends State<eligible_donors> {
  List<eligible_bld_donors> l=[eligible_bld_donors(name: "Aman", contact: "48484489", e_bld_grp: "A+"),   //backend dummy
  ];

  Widget eligible_template(eligible){
    return EligibleCard(donors: eligible);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eligible Donors"),
      ),
      body: Column(
        children: l.map((eligible_bld_donors) => EligibleCard(donors: eligible_bld_donors)).toList(),
      ),
    );
  }
}

class EligibleCard extends StatelessWidget {

final eligible_bld_donors donors;
EligibleCard({this.donors});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          donors.name +"       "+ donors.contact +"       "+ donors.e_bld_grp,
        ),
      ),
    );
  }
}

class eligible_bld_donors{
  String name;
  String contact;
  String e_bld_grp;
  eligible_bld_donors({String name,String contact,String e_bld_grp}){
    this.name=name;
    this.contact=contact;
    this.e_bld_grp=e_bld_grp;
  }
}