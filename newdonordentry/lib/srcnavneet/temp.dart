import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mysql1/mysql1.dart';

import '../main.dart';

class AllOrgan extends StatefulWidget{
  
  static String query;
  AllOrgan(var organ, bool isQuery){
    if(isQuery){
      AllOrgan.query=organ;
    }
    else{
      AllOrgan.query="SELECT * FROM " + organ + " WHERE DON_id IS NOT NULL";  
    }
  }

  
  @override
  AllOrganState createState() => AllOrganState();
}

class AllOrganState extends State<AllOrgan>{
  
  //--------------Variables-----------------------------
  
  Results data;
  static Widget initial=SpinKitChasingDots(
    color: Colors.green,
    size: 50.0,
  );
  static Widget pageContent=initial;
  static Widget afterLoad;
  
  //--------------Functions-----------------------------
  
  void getData() async {
   
    try{
      var conn = await MySqlConnection.connect(sql_cred);
      data = await conn.query(AllOrgan.query);
      await conn.close();
      print(data);
    } catch(e){
      print("Exception thrown $e");
    }

    var allFields = new List();
    var relevantFields = new List();
    var relevantData = new List();
    for(var i in data){
      var k = i.fields;
      for (var j in k.keys)
        allFields.add(j);
      break;
    }
    if(allFields.length!=0){
      relevantFields.add(allFields[0]);
      for(int k=4; k<allFields.length ;  ++k ){
        relevantFields.add(allFields[k]);
      }
      for (var i in data) {
          var lst = new List();
          lst.add(i[0]);
          for(int k=4; k<allFields.length ;  ++k ){
            lst.add(i[k]);
          }
          relevantData.add(lst);
      }
      // print(relevantData);
      // print(relevantFields);

      List<Widget> OrganCards = new List<Widget>();
      int num=0;
      for (var i in relevantData){
        num+=1;
        String dd="";
        for(int k=1; k<relevantFields.length; ++k){
          dd+="${relevantFields[k]}: ${i[k]}\n";
        }
        Widget temp = Card(
          child: ListTile(
            leading: Text(
              "$num",
              style: TextStyle(fontSize: 20),
            ),
            title: Text(
              "${relevantFields[0]}: ${i[0]}"
            ),
            subtitle: Text(
              dd
            ),
          )       
        );
        OrganCards.add(temp);
      }

      afterLoad = ListView(
        children: OrganCards,
      );
      setState(() {
        pageContent = afterLoad;

      });
    }else{
      afterLoad=ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(
                "No data found!!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
            ),
          )
        ],
      );
      setState(() {
        pageContent = afterLoad;

      });
    }
}

  @override
  void initState() {
    pageContent=initial;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // backgroundColor: Colors.,
      appBar: AppBar(
        title: Text("All Organs"),
      ),
      body: Center(
        child: pageContent,
      ),
    );
  }
}