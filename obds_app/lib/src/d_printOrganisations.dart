import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mysql1/mysql1.dart';

import '../main.dart';

class PrintOrganisation extends StatefulWidget{
  String query;
  PrintOrganisation(String query){
        this.query=query;
  }
  @override
  PrintOrganisationState createState() => PrintOrganisationState(query);
}

class PrintOrganisationState extends State<PrintOrganisation>{
  String query;
  static Widget onsreen;
  PrintOrganisationState(String query){
    this.query=query;
  }

  Future<void> getdata() async {
    Results data;
    try{
      var conn = await MySqlConnection.connect(sql_cred);
      data = await conn.query(query);
      await conn.close();
    } catch(e){
      print("Exception thrown $e");
    }
    
    List<String> allFields = new List<String>();
     for(var i in data){
      var k = i.fields;
      for (var j in k.keys)
        allFields.add(j);
      break;
    }
    // print(allFields);

    if(allFields.length!=0){
     
      // print(relevantData);
      // print(relevantFields);

      List<Widget> OrganCards = new List<Widget>();
      int num=0;
      for (var i in data){
        num+=1;
        String dd="";
        for(int k=1; k<allFields.length; ++k){
          dd+="${allFields[k]}: ${i[k]}\n";
        }
        Widget temp = Card(
          child: ListTile(
            
            title: Text(
              "${allFields[0]}: ${i[0]}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            subtitle: Text(
              dd,
              style: TextStyle(fontSize: 18),
            ),
          )       
        );
        OrganCards.add(temp);
      }

      Widget afterLoad = ListView(
        children: OrganCards,
      );
      setState(() {
        onsreen = afterLoad;

      });
    }else{
      Widget afterLoad=ListView(
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
        onsreen = afterLoad;

      });
    }
  }

  @override
  void initState() {
      onsreen=SpinKitChasingDots(
      color: Colors.green,
      size: 50.0,
    );

    getdata();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Organistaion Details"),
      ),
      body: Center(
        child: onsreen,
      ),
    );
  }
}