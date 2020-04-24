import 'package:flutter/material.dart';

class shortage extends StatefulWidget {
  @override
  _shortageState createState() => _shortageState();
}

class _shortageState extends State<shortage> {
  List<shortage_blood> l=[shortage_blood(bld_grp: "A+"),     // backend dummy
                          shortage_blood(bld_grp: "B+"),
  ];    //dummy for backend


  Widget shortage_temp(shortage_blood){
    return BloodCard(bld: shortage_blood);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Required Blood Group"),
      ),
      body: Column(
        children: l.map((shortage_blood) => BloodCard(bld: shortage_blood,)).toList(),
      ),
    );
  }
}

class BloodCard extends StatelessWidget {
  final shortage_blood bld;
  BloodCard({this.bld});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(bld.bld_grp),
      ),
    );
  }
}
class shortage_blood{
  String bld_grp;
  shortage_blood({String bld_grp}){
    this.bld_grp=bld_grp;
  }
}
