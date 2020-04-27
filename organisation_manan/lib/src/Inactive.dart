import 'dart:math';

import 'package:flutter/material.dart';
import '../main.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Inactive extends StatefulWidget
{
  var id;
  Inactive(this.id);
  @override
  InactiveState createState() => InactiveState(id);
}
class InactiveState extends State<Inactive>
{
  var id;
  static Widget initial=SpinKitChasingDots(
    color: Colors.green,
    size: 70.0,
  );
  static Widget pageContent=initial;
  static Widget afterLoad;
  void getData() async{
    print("Try");
    var conn=await MySqlConnection.connect(sql_cred);
    print("Got it");
    //try
    {
      await conn.query('Update Organ_Donor set Active=false where ORG_id="$id" and (Last_check_up_date is NULL OR datediff(curdate(),Last_check_up_date)>60)');
      var data=await conn.query('Select * from Organ_Donor where ORG_id="$id" and active=false');
      var allFeilds=new List();
    var relevantData=new List();
    for(var i in data)
    {
      var k=i.fields;
      for(var j in k.keys)
        allFeilds.add(j);
      break;
    }
    print(allFeilds);
    for(var i in data)
    {
      var lst=new List();
      for(int k=0;k<allFeilds.length;++k)
      {
        lst.add(i[k]);
      }
      relevantData.add(lst);
    }
    print(relevantData);
    List<Widget> OrganCards=new List<Widget>();
    int f=0;
    if(data.length==0)
    {
      f=1;
      afterLoad=Text("No Inactive Donor",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),);
    }
    int num=0;
    for (var i in relevantData){
      num+=1;
      String dd="";
      for(int k=1; k<allFeilds.length; ++k){
        dd+="${allFeilds[k]}: ${i[k]}\n";
      }
      Widget temp = Card(
        child: ListTile(
          leading: Text(
            "$num",
            style: TextStyle(fontSize: 20),
          ),
          title: Text(
            "${allFeilds[0]}: ${i[0]}"
          ),
          subtitle: Text(
            dd
          ),
        )       
      );
      OrganCards.add(temp);
    }
    if(f==0)
    {
    afterLoad = ListView(
      children: OrganCards,
    );}
    }
    /*catch(e)
    {
     print("Exception");
     afterLoad=Text("Connection Interuppted",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),);
    }*/
    await conn.close();
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
  InactiveState(this.id);
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Donor"),
      ),
      body: Center(child: pageContent,),
    );
  }
}