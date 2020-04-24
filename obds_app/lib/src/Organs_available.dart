import 'package:flutter/material.dart';
import './Patient.dart';
import '../main.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Organ_available extends StatefulWidget
{
  var id;
  Organ_available(this.id);
  @override
  Organ_availableState createState() => Organ_availableState(id);
}
class Organ_availableState extends State<Organ_available>
{
  var id;
  var data;
  static Widget initial=SpinKitChasingDots(
    color: Colors.green,
    size: 70.0,
  );
  static Widget pageContent=initial;
  static Widget afterLoad;
  void getData() async{
    var conn=await MySqlConnection.connect(sql_cred); 
    try
    {
      var result=await conn.query('select blood_group from Patient where pat_id= ?',[id]);
      var blood;
      for(var row in result)
      {
       blood=row[0];
      }
      result=await conn.query('select Organ from Patients_Organ where pat_id= ?',[id]);
     var table;
      for(var row in result)
      {
        table=row[0];
      }
      String q='select count(organ_id) from '+table+' join Organ_Donor using(Don_id) where Matched_id is Null and blood_group=?';
    
      result=await conn.query(q,[blood]);
      for(var row in result)
      {
        print("Number of Potential Match:${row[0]}");
        data=row;
      }
    }
    catch(e)
    {
     print("Exception");
    }
    await conn.close();
    List<Widget> OrganCards=new List<Widget>();
    Widget temp=Card(
      child: ListTile(
        title: Text("Number of potential Matches ${data[0]}"),
      )
    );
    OrganCards.add(temp);
    afterLoad=ListView(children: OrganCards,);
    setState(() {
      pageContent=afterLoad;
    });
  }
  @override
  void initState()
  {
    pageContent=initial;
    getData();
  }
  Organ_availableState(this.id);
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Matching Organs"),
      ),
      body: Center(child: pageContent,),
    );
  }
}