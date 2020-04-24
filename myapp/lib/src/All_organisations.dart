import 'package:flutter/material.dart';
import './Patient.dart';
import '../main.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class All_organisation extends StatefulWidget
{
  var id;
  All_organisation(this.id);
  @override
  All_organisationState createState() => All_organisationState(id);
}
class All_organisationState extends State<All_organisation>
{
  var id;
  Results data;
  static Widget initial=SpinKitChasingDots(
    color: Colors.green,
    size: 50.0,
  );
  static Widget pageContent=initial;
  static Widget afterLoad;
  void getData() async{
    var conn=await MySqlConnection.connect(sql_cred); 
    //try
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
      print(id);
      print(table);
      print(blood);
      String q='select o.Name, o.Address, o.Contact from  Organisation o where org_id in(select distinct o.Org_id from  Organisation o join Organ_Donor using(ORG_id) where don_id in(select Don_id from '+table+' join Organ_Donor using(Don_id) where Matched_id is Null and blood_group=?))';
    
      result=await conn.query(q,[blood]);

      for(var row in result)
      {
        print(row.fields);
        print(row);
      }
      data=result;
    }
    //catch(e)
    //{
      //print("Exception");
    //}
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
    int f=0;
    if(data.length==0)
    {
      f=1;
      afterLoad=Text("No Nearby Blood Banks Avialable",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),);
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
    setState(() {
      pageContent = afterLoad;

    });
}

  @override
  void initState() {
    pageContent=initial;
    getData();
  }
  All_organisationState(this.id);
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organisation List"),
      ),
      body:Center(child: pageContent,)
    );
  }
}