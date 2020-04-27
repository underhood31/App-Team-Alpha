import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mysql1/mysql1.dart';
import 'package:obdsapp/src/d_printOrganisations.dart';

import '../main.dart';

class OrganOrganisations extends StatefulWidget{
  @override
  OrganOrganisationState createState() => OrganOrganisationState();
}

class OrganOrganisationState extends State<OrganOrganisations>{
  Widget onScreen;
  Results data;

void getData() async{
     //Getting Kidney data
    var query="select * from Organisation";
    try{
      var conn = await MySqlConnection.connect(sql_cred);
      data = await conn.query(query);
      await conn.close();
      
      // print(kidney.fields[0]);
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
    print(allFields);

    if(allFields.length!=0){
     
      // print(relevantData);
      // print(relevantFields);

      List<Widget> OrganCards = new List<Widget>();
      for (var i in data){
        String dd="";
        for(int k=1; k<allFields.length; ++k){
          dd+="${allFields[k]}: ${i[k]}\n";
        }
        Widget temp = Card(
          child: ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PrintOrganisation("select DON_id, Age, Contact, Status, Last_check_up_date, Blood_Group, Pincode from Organ_Donor where ORG_id = '${i[0]}';")),);
            },
            title: Text(
              "Organisation ID: ${i[0]}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
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
        onScreen = afterLoad;

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
        onScreen = afterLoad;

      });
    }
  }

 @override
  void initState() {
    onScreen=SpinKitChasingDots(
      color: Colors.green,
      size: 50.0,
    );
    getData();
   
      
  }
 
 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Organ Donation Organisatons"),
      ),
      body: Container(
        child: Center(
          child: onScreen,
        ) ,
      ),
    );
  }
  
}