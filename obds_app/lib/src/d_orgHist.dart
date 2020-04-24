import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mysql1/mysql1.dart';
import 'package:obdsapp/src/d_printDetails.dart';

import '../main.dart';

class OrganHistory extends StatefulWidget{
  @override
  OrganHistoryState createState() => OrganHistoryState();
}

class OrganHistoryState extends State<OrganHistory>{
  Widget onscreen;
  String OrganID="";
  List<String> suggestions = new List<String>();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

void getData() async {
  Results data;
  try{
    var conn = await MySqlConnection.connect(sql_cred);
    data = await conn.query("select ORGAN_id from Cornea union select ORGAN_id from Heart union select ORGAN_id from Pancreas union select ORGAN_id from Kidney union select ORGAN_id from Lung union select ORGAN_id from Liver;");
    await conn.close();
    print(data);
  } catch(e){
    print("Exception thrown $e");
  }
  List<String> tempSug = new List<String>();
  for(var i in data){
    for(var j in i)
      tempSug.add(j);
  }
  print("done");
  setState(() {
    suggestions.addAll(tempSug);
    onscreen=Container(
              padding: EdgeInsets.fromLTRB(50.0,10.0,50.0,10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Check History of any organ",
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
              
                SimpleAutoCompleteTextField(
                  key: key,
                  clearOnSubmit: true,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    hintText: "Eg, H000021",
                    labelStyle: TextStyle(fontStyle: FontStyle.italic),
                    labelText: "Enter Organ ID"
                  ),
                  textChanged: (String text){
                    OrganID=text;
                  },
                  suggestions: suggestions,
                  textSubmitted: (text) => setState(() {
                    this.OrganID=text;
                    if (text != "") {
                      this.OrganID=this.OrganID.toUpperCase();
                      print(this.OrganID);
                      if(this.OrganID[0]=='C'){
                        print("Cornea");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PrintDetails("Cornea",OrganID)),
                        );
                      }
                      else if(this.OrganID[0]=='H'){
                        print("Heart");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PrintDetails("Heart",OrganID)),
                        );
                      }
                      else if(this.OrganID[0]=='K'){
                        print("Kidney");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PrintDetails("Kidney",OrganID)),
                        );
                      }
                      else if(this.OrganID[0]=='L' && this.OrganID[1]=='I'){
                        print("Liver");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PrintDetails("Liver",OrganID)),
                        );
                      }
                      else if(this.OrganID[0]=='L' && this.OrganID[1]=='U'){
                        print("Lung");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PrintDetails("Lung",OrganID)),
                        );
                      }
                      else if(this.OrganID[0]=='P' ){
                        print("Pancreas");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PrintDetails("Pancreas",OrganID)),
                        );
                      }
                    }
                  })
                ),
                SizedBox(height: 24.0),
                // RaisedButton(
                //   child: Text("Search"),
                //   onPressed: (){
                    
                //   },
                // )
                ],
              )
            );
  });
}

@override
  void initState() {
    onscreen=SpinKitChasingDots(
    color: Colors.green,
    size: 50.0,
  );
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organ History"),
      ),
      body: onscreen
      
    );
  }
  
}