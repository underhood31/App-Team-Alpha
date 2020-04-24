import 'package:flutter/material.dart';
import './Patient.dart';
import '../main.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Show_blood extends StatefulWidget
{
  String pincode;
  String blood;
  Show_blood(this.pincode,this.blood);
  @override
  Show_bloodState createState() => Show_bloodState(pincode,blood);
}
class Show_bloodState extends State<Show_blood>
{
  String blood, pincode;
  Results data;
  static Widget initial=SpinKitChasingDots(
    color: Colors.green,
    size: 50.0,
  );
  static Widget pageContent=initial;
  static Widget afterLoad;
  void getData() async{
    if(blood.length>0&&[1]=='+')
    {
      blood=blood[0]+'positive';
    }
    else if(blood.length>0)
    {
      blood=blood[0]+'negative';
    }
    String lower =pincode[0]+pincode[1]+pincode[2];
    lower+='%';
    print(blood);
    print(lower);
    var conn=await MySqlConnection.connect(sql_cred); 
    try
    {
      String q;
      if(blood.length>0)
      {
        q='Select Name,Address,Contact from Blood_Bank where '+blood+' > 0 and pincode like ?';
      }
      else
      {
        q='Select Name,Address,Contact from Blood_Bank where pincode like ?';
      }
      data=await conn.query(q,[lower]);
      print(data);
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
    int f=0;
    print(relevantData);
    List<Widget> OrganCards=new List<Widget>();
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
  Show_bloodState(this.pincode,this.blood);
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Banks"),
      ),
      body:Center(child: pageContent,)
    );
  }
}