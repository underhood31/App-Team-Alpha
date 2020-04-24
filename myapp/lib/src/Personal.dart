import 'package:flutter/material.dart';
import './Patient.dart';
import '../main.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Personal extends StatefulWidget
{
  var id;
  Personal(this.id);
  @override
  PersonalState createState() => PersonalState(id);
}
class PersonalState extends State<Personal>
{
  var id;
  Results data;
  Results data2;
  static Widget initial=SpinKitChasingDots(
    color: Colors.green,
    size: 50.0,
  );
  static Widget pageContent=initial;
  static Widget afterLoad;
  void getData() async{
    var conn=await MySqlConnection.connect(sql_cred); 
    var m;
    try
    {
      var result=await conn.query('select Organ from Patients_Organ where pat_id= ?',[id]);
      var table;
      for(var row in result)
      {
        table=row[0];
      }
      String q='Select Name,Contact,Address,Doc_id,Last_check_up_date, Blood_group, Age from Patient where Pat_id=?';
    
      result=await conn.query(q,[id]);
      data=result;
      String q2='Select * from '+table+' where pat_id=? ';
      data2=await conn.query(q2,[id]);
      String q3='Select Matched_id from '+table+' where pat_id=? ';
      result=await conn.query(q3,[id]);
      for(var row in result)
      {
        m=row[0];
      }
    }
    catch(e)
    {
      print("Exception");
    }
    await conn.close();
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
    for (var i in relevantData){
      String dd="";
      for(int k=1; k<allFeilds.length; ++k){
        dd+="${allFeilds[k]}: ${i[k]}\n";
      }
      Widget temp = Card(
        child: ListTile(
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
    allFeilds=new List();
    relevantData=new List();
    for(var i in data2)
    {
      var k=i.fields;
      for(var j in k.keys)
        allFeilds.add(j);
      break;
    }
    print(data2);
    print(allFeilds);
    for(var i in data2)
    {
      print("Hello $i");
      var lst=new List();
      for(var k in i )
      {
        print(k);
        if(k==null)
        {
          continue;
        }
        print(k);
        lst.add(k);
      }
      relevantData.add(lst);
    }
    print(relevantData);
    for (var i in relevantData){
      String dd="";
      for(int k=1; k<allFeilds.length; ++k){
        dd+="${allFeilds[k]}: ${i[k]}\n";
      }
      if(m==null)
      {
        dd+='No Match Yet\n';
      }
      Widget temp = Card(
        child: ListTile(
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
    afterLoad = ListView(
      children: OrganCards,
    );
    setState(() {
      pageContent = afterLoad;

    });
}

  @override
  void initState() {
    pageContent=initial;
    getData();
  }
  PersonalState(this.id);
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Details"),
      ),
      body:Center(child: pageContent,)
    );
  }
}