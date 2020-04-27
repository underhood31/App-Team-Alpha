import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mysql1/mysql1.dart';

import '../main.dart';

class PrintDetails extends StatefulWidget{
  String table, org_id;
  PrintDetails(String table, String org_id){
    this.table=table;
    this.org_id=org_id;
  }
  @override
  PrintDetailsState createState() => PrintDetailsState(table, org_id);
}

class PrintDetailsState extends State<PrintDetails>{
  String table, org_id;
  static Widget onsreen;
  PrintDetailsState(String table, String org_id){
    this.table=table;
    this.org_id=org_id;
  }

  Future<void> getdata() async {
    Results data;
    try{
      var conn = await MySqlConnection.connect(sql_cred);
      data = await conn.query("select P.PAT_id, Matched_id, Weight, Last_check_up_date, Doc_id, Age, Blood_Group from ${this.table} as C INNER JOIN Patient as P ON C.PAT_id=P.PAT_id where C.ORGAN_id='${this.org_id}';");
      await conn.close();
    } catch(e){
      print("Exception thrown $e");
    }
    if(data.isEmpty){
      try{
        var conn = await MySqlConnection.connect(sql_cred);
        data = await conn.query("select D.DON_id, Matched_id, Weight, Last_check_up_date,Age, Blood_Group from ${this.table} as C INNER JOIN Organ_Donor as D ON C.DON_id=D.DON_id where C.ORGAN_id='${this.org_id}';");
        await conn.close();
      } catch(e){
        print("Exception thrown $e");
      }
    }
    List<String> allFields = new List<String>();
     for(var i in data){
      var k = i.fields;
      for (var j in k.keys)
        allFields.add(j);
      break;
    }
    print(allFields);

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
        title: Text("Organ History"),
      ),
      body: Center(
        child: onsreen,
      ),
    );
  }
}