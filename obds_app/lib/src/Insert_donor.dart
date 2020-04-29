import 'dart:math';

import 'package:flutter/material.dart';
import '../main.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Insert_donor extends StatefulWidget
{
  var id;
  var donor;
  var blood;
  var date;
  var v1,v2;
  Insert_donor(this.donor,this.blood,this.date,this.id,this.v1,this.v2);
  @override
  Insert_donorState createState() => Insert_donorState(donor,blood,date,id,v1,v2);
}
class Insert_donorState extends State<Insert_donor>
{
  var id;
  var data;
  var donor;
  var blood;
  var date;
  var v1,v2;
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
    var table; 
    var Age,Name,Address,Contact,Pincode,Organ,Don_id;
    try
    {
      String q="Select Age,Name,Address,Contact,Pincode,Organ from New_Donor where don_id=?";
      var result =await conn.query(q,[donor]); 
      for(var i in result)
      {
        Age=i[0];
        Name=i[1];
        Address=i[2];
        Contact=i[3];
        Pincode=i[4];
        Organ=i[5];
      }
      result=await conn.query("Select Don_id from Organ_Donor order by don_id");
      int x=0;
      for(var i in result)
      {
        String d=i[0];
        d=d.substring(4);
        x=max(x, int.parse(d));
      }
      print(x);
      x+=1;
      Don_id="Don_"+x.toString();
      String s="Alive";
      int ac=1;
      await conn.query('Insert into Organ_Donor(Age,Name,Address,Contact,Pincode,Don_id,Blood_Group,Last_check_up_date,Status,ORG_id,Active) Values("$Age","$Name","$Address","$Contact","$Pincode","$Don_id","$blood","$date","$s","$id","$ac")');
      await conn.query("Delete from New_Donor where don_id=?",[donor]);
      await conn.query('Insert into Donors_Organ(DON_id,Organ) Values("$Don_id","$Organ")');
      Organ=Organ.toLowerCase();
      if(Organ=='cornea')
      {
        result=await conn.query("Select Organ_id from Cornea");
        int y=0;
        for(var i in result)
        {
          String d=i[0];
          d=d.substring(1);
          y=max(y, int.parse(d));
        }
        print(y);
        y+=1;
        String Organ_id="C"+y.toString();
        await conn.query('Insert into Cornea(Organ_id,Don_id) Values("$Organ_id","$Don_id")');
      }
      else if(Organ=='kidney')
      {
        result=await conn.query("Select Organ_id from Kidney");
        int y=0;
        for(var i in result)
        {
          String d=i[0];
          d=d.substring(2);
          y=max(y, int.parse(d));
        }
        print(y);
        y+=1;
        String Organ_id="KD"+y.toString();
        await conn.query('Insert into Kidney(Organ_id,Don_id,PRA) Values("$Organ_id","$Don_id","$v1")');
      }
      else if(Organ=='pancreas')
      {
        result=await conn.query("Select Organ_id from Pancreas");
        int y=0;
        for(var i in result)
        {
          String d=i[0];
          d=d.substring(2);
          y=max(y, int.parse(d));
        }
        print(y);
        y+=1;
        String Organ_id="PN"+y.toString();
        await conn.query('Insert into Pancreas(Organ_id,Don_id,OPTN) Values("$Organ_id","$Don_id","$v1")');
      }
      else if(Organ=='heart')
      {
        result=await conn.query("Select Organ_id from Heart");
        int y=0;
        for(var i in result)
        {
          String d=i[0];
          d=d.substring(1);
          y=max(y, int.parse(d));
        }
        print(y);
        y+=1;
        String Organ_id="H"+y.toString();
        await conn.query('Insert into Heart(Organ_id,Don_id,Weight) Values("$Organ_id","$Don_id","$v1")');
      }
      else if(Organ=='liver')
      {
        result=await conn.query("Select Organ_id from Liver");
        int y=0;
        for(var i in result)
        {
          String d=i[0];
          d=d.substring(2);
          y=max(y, int.parse(d));
        }
        print(y);
        y+=1;
        String Organ_id="LI"+y.toString();
        await conn.query('Insert into Liver(Organ_id,Don_id,Weight) Values("$Organ_id","$Don_id","$v1")');
      }
      else
      {
        result=await conn.query("Select Organ_id from Lung");
        int y=0;
        for(var i in result)
        {
          String d=i[0];
          d=d.substring(2);
          y=max(y, int.parse(d));
        }
        print(y);
        y+=1;
        String Organ_id="LU"+y.toString();
        await conn.query('Insert into Lung(Organ_id,Don_id,Size,Smoking_History) Values("$Organ_id","$Don_id","$v1","$v2")');
      }
      afterLoad=Text("Inserted With Donor ID:$Don_id",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),);
    }
    catch(e)
    {
     print("Exception");
     afterLoad=Text("Connection Interuppted",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),);
    }
    await conn.close();
    setState(() {
      pageContent=afterLoad;
    });
  }
  void getData2() async{
    print("Try");
    var conn=await MySqlConnection.connect(sql_cred);
    print("Got it");
    var table; 
    var Age,Name,Address,Contact,Pincode,Organ,Don_id;
    //try
    {
      String q="Select Age,Name,Address,Contact,Pincode from New_Blood_Donor where BLD_id=?";
      var result =await conn.query(q,[donor]); 
      for(var i in result)
      {
        Age=i[0];
        Name=i[1];
        Address=i[2];
        Contact=i[3];
        Pincode=i[4];
      }
      result=await conn.query("Select BLD_id from Blood_Donor");
      int x=0;
      for(var i in result)
      {
        String d=i[0];
        d=d.substring(4);
        x=max(x, int.parse(d));
      }
      print(x);
      x+=1;
      Don_id="BLD_"+x.toString();
      await conn.query('Insert into Blood_Donor(Age,Name,Address,Contact,Pincode,BLD_id,Blood_Group,Last_Checkup,Last_Donated,ORG_id) Values("$Age","$Name","$Address","$Contact","$Pincode","$Don_id","$blood","$date","$date","$id")');
      await conn.query("Delete from New_Blood_Donor where BLD_id=?",[donor]);
      afterLoad=Text("Inserted With Donor ID:$Don_id",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),);
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
    print(donor[1]);
    if(donor[1]=="D")
    {
      getData();
    }
    else
    {
      getData2();
    }
  }
  Insert_donorState(this.donor,this.blood,this.date,this.id,this.v1,this.v2);
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