import 'package:flutter/material.dart';
import 'package:obdsapp/main.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'd_allOrgans.dart';
class CheckOrgans extends StatefulWidget{
  @override
  CheckOrganState createState() => CheckOrganState();
}

class CheckOrganState extends State<CheckOrgans>{
  static int cornea;        
  static int liver;        
  static int lung;        
  static int heart;        
  static int pancreas;        
  static int kidney;        
  static Widget initial=SpinKitChasingDots(
    color: Colors.green,
    size: 50.0,
  );
  static Widget pageContent=initial;
  Widget afterLoad;
  void getKidney() async{
     //Getting Kidney data
    var query="select count(*) from Kidney where DON_id is not NULL;";
    try{
      var conn = await MySqlConnection.connect(sql_cred);
      var results = await conn.query(query);
      await conn.close();
      for (var i in results){
        kidney=i[0];
      }
      // print(kidney.fields[0]);
    } catch(e){
      print("Exception thrown $e");
    }
  }
  void getCornea() async{
     //Getting Cornea data
    var query="select count(*) from Cornea where DON_id is not NULL;";
    try{
      var conn = await MySqlConnection.connect(sql_cred);
      var results = await conn.query(query);
      await conn.close();
      for (var i in results){
        cornea=i[0];
      }
      // print(kidney.fields[0]);
    } catch(e){
      print("Exception thrown $e");
    }
  }
  void getPancreas() async{
    //Getting Pancreas data
    var query="select count(*) from Pancreas where DON_id is not NULL;";
    try{
      var conn = await MySqlConnection.connect(sql_cred);
      var results = await conn.query(query);
      await conn.close();
      for (var i in results){
        pancreas=i[0];
      }
      // print(kidney.fields[0]);
    } catch(e){
      print("Exception thrown $e");
    }
  }
  void getLiver() async{
    //Getting Liver data
    var query="select count(*) from Liver where DON_id is not NULL;";
    try{
      var conn = await MySqlConnection.connect(sql_cred);
      var results = await conn.query(query);
      await conn.close();
      for (var i in results){
        liver=i[0];
      }
      // print(kidney.fields[0]);
    } catch(e){
      print("Exception thrown $e");
    }
  
  }
  void getLungs() async{
    //Getting lungs data
    var query="select count(*) from Lung where DON_id is not NULL;";
    try{
      var conn = await MySqlConnection.connect(sql_cred);
      var results = await conn.query(query);
      await conn.close();
      for (var i in results){
        lung=i[0];
      }
      // print(kidney.fields[0]);
    } catch(e){
      print("Exception thrown $e");
    }
  
  }
  void getHeart() async{
    //Getting heart data
    var query="select count(*) from Heart where DON_id is not NULL;";
    try{
      var conn = await MySqlConnection.connect(sql_cred);
      var results = await conn.query(query);
      await conn.close();
      for (var i in results){
        heart=i[0];
      }
      // print(kidney.fields[0]);
    } catch(e){
      print("Exception thrown $e");
    }
  }
  void callAll() async{
    await getCornea();
    await getKidney();
    await getHeart();
    await getLiver();
    await getLungs();
    await getPancreas();
  }

  

  void getData() async {
   
    await callAll();
       afterLoad=GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          Card(
              child: Center(
                child: ListTile(
                  onTap: (){
                      navigate("Cornea");
                  } ,
                  title: Text(
                    "$cornea",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    "Corneas available",
                    style: TextStyle(fontSize: 20, ),
                    textAlign: TextAlign.center,
                    ),
                ),
              )
              
            ),
            Card(
              child: Center(
                child: ListTile(
                  onTap: (){
                      navigate("Heart");
                  } ,
                  title: Text(
                    "$heart",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    "Hearts available",
                    style: TextStyle(fontSize: 20, ),
                    textAlign: TextAlign.center,
                    ),
                ),
              )
            ),
            Card(
              child: Center(
                child: ListTile(
                  onTap: (){
                      navigate("Kidney");
                  } ,
                  title: Text(
                    "$kidney",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    "Kidneys available",
                    style: TextStyle(fontSize: 20, ),
                    textAlign: TextAlign.center,
                    ),
                ),
              )
            ),
            Card(
              child: Center(
                child: ListTile(
                  onTap: (){
                      navigate("Liver");
                  } ,
                  title: Text(
                    "$liver",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    "Livers available",
                    style: TextStyle(fontSize: 20, ),
                    textAlign: TextAlign.center,
                    ),
                ),
              )
            ),
            Card(
              child: Center(
                child: ListTile(
                  onTap: (){
                      navigate("Lung");
                  } ,
                  title: Text(
                    "$lung",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    "Lungs available",
                    style: TextStyle(fontSize: 20, ),
                    textAlign: TextAlign.center,
                    ),
                ),
              )
            ),
            
            Card(
              child: Center(
                child: ListTile(
                  onTap: (){
                      navigate("Pancreas");
                  } ,
                  title: Text(
                    "$pancreas",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    "Pancreas available",
                    style: TextStyle(fontSize: 20, ),
                    textAlign: TextAlign.center,
                    ),
                ),
              )
            ),
            
        ],
      );
      setState(() {
        pageContent = afterLoad;

      });
}


  @override
  Future<void> initState() {
      pageContent=initial;
      getData();
   
  }

  void navigate(String organ){
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AllOrgan(organ,false)),
    );
  }

  @override
  Widget build(BuildContext context) {
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