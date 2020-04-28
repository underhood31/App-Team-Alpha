import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart' as mysql;
import './Insert_donor.dart';
import '../main.dart';
class  Details extends StatefulWidget
{
  var id;
  Details(this.id);
  @override
  DetailsState createState() => DetailsState(id);
}
class BloodGroup
{
  int id;
  String group;
  BloodGroup(this.id, this.group);
  static List<BloodGroup> getgroups() {
    return <BloodGroup>[
      BloodGroup(1, 'A+'),
      BloodGroup(2, 'A-'),
      BloodGroup(3, 'B+'),
      BloodGroup(4, 'B-'),
      BloodGroup(5, 'O+'),
      BloodGroup(6, 'O-'),
      BloodGroup(7, 'AB+'),
      BloodGroup(8, 'AB-'),

    ];
  }
}
class DetailsState extends State<Details>
{
  var id;
  DetailsState(this.id);
  String alertTitle="Error",alertContent="";
  int f=0;
  DateTime selectedDate = DateTime.now();
  var date;
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        //print("Hello"),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        print(selectedDate);
        date=selectedDate.toString().split(' ')[0];
        print(date);
      });
  }
  createAlertDialog(BuildContext context)
  {
    f=1;
    print(alertTitle);
    return showDialog
    (
      context: context, builder:(context)
      {
        return AlertDialog
        (
          title: Text(alertTitle, style: TextStyle(fontFamily: 'Montserrat'),),
          content: Text(alertContent,     style: TextStyle(fontFamily: 'Montserrat'),),
          actions: <Widget>
          [
            MaterialButton
          (
            elevation: 5,
            child: Text("Go Back",style: TextStyle(fontFamily: 'Montserrat')),
            onPressed: ()
            {
              Navigator.of(context).pop();
            }
          )
          ],
        );
      }
    );
  }
  final Organ=new TextEditingController();
  var v1="",v2="";
  OrganDialog(BuildContext context,String t,String c)
  {
    return showDialog(
      context: context, builder:(context)
      {
    return AlertDialog
    (
      title: Text("Enter $t Details"),
      content: 
          TextField(
            controller: Organ,
            decoration: InputDecoration( contentPadding: EdgeInsets.all(10),
                                  hintText: 'XXX',
                                  labelText: c,
                                  labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),

          ),
      actions: <Widget>[
        MaterialButton
          (
            elevation: 5,
            child: Text("Go Back",style: TextStyle(fontFamily: 'Montserrat')),
            onPressed: ()
            {
              Navigator.of(context).pop();
            }
          ),
          MaterialButton
          (
            elevation: 5,
            child: Text("Submit",style: TextStyle(fontFamily: 'Montserrat')),
            onPressed: ()
            {
              setState(() {
                v1=Organ.text;
                if(v1.length==0)
                {
                  alertContent=" $c value is Required";
                  createAlertDialog(context);
                }
                else
                {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Insert_donor(Pincode,Blood_group,date,id,v1,"")),);
                 // Navigator.of(context).pop();
                }
              });
            }
          ),
      ],
    );
      }
    );
  }
  final Organ2=new TextEditingController();
  Lung(BuildContext context)
  {
    print("In LuNg");
    return showDialog(
      context: context, builder:(context)
      {
    return AlertDialog
    (
      title: Text("Enter Lung Details"),
      content: 
      Container(
        height:120,
        child:Column(
        children: <Widget>[
          TextField(
            controller: Organ,
            decoration: InputDecoration( contentPadding: EdgeInsets.all(10),
                                  hintText: 'XX',
                                  labelText: "Size",
                                  labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),

          ),
          TextField(
            controller: Organ2,
            decoration: InputDecoration( contentPadding: EdgeInsets.all(10),
                                  hintText: 'XX',
                                  labelText: " Smoking History",
                                  labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),

          ),
        ],
        ),
      ),
      actions: <Widget>[
        MaterialButton
          (
            elevation: 5,
            child: Text("Go Back",style: TextStyle(fontFamily: 'Montserrat')),
            onPressed: ()
            {
              Navigator.of(context).pop();
            }
          ),
          MaterialButton
          (
            elevation: 5,
            child: Text("Submit",style: TextStyle(fontFamily: 'Montserrat')),
            onPressed: ()
            {
              setState(() {
                v1=Organ.text;
                v2=Organ2.text;
                if(v1.length==0)
                {
                  alertContent=" Size value is Required";
                  createAlertDialog(context);
                }
                else if(v2.length==0)
                {
                  alertContent=" Smoking History is Required";
                  createAlertDialog(context);
                }
                else
                {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Insert_donor(Pincode,Blood_group,date,id,v1,v2)),);
                  //Navigator.of(context).pop();
                }
              });
            }
          ),
      ],
    );
    });
  }
  var data,data2;
  void getData () async
  {
    print("Hey");
    var conn=await mysql.MySqlConnection.connect(sql_cred);
    print("Got it");
    try{
      data= await conn.query("Select Don_id,Organ from New_Donor");
      data2=await conn.query("Select BLD_id from New_Blood_Donor");
    }
    catch(e)
    {
      print("Exception");
    }
    await conn.close();
    print("Okay");
  }
  bool check(String id)
  {
    for(var i in data2)
    {
      if(id==i[0])
      {
        return true;
      }
    }
    return false;
  }
  String getOrgan(String id)
  {
    for(var i in data)
    {
      if(id==i[0])
      {
        return i[1];
      }
    }
    return "";
  }
  @override
  void initState()
  {
    getData();
  }
  List<BloodGroup> _groups = BloodGroup.getgroups();
    List<DropdownMenuItem<BloodGroup>> _dropdownMenuItems;
    BloodGroup _selectedBloodGroup;
    final PinController=new TextEditingController();
    String Pincode,Blood_group;
    List<DropdownMenuItem<BloodGroup>> buildDropdownMenuItems(List groups) {
    List<DropdownMenuItem<BloodGroup>> items = List();
    for (BloodGroup BloodGroup1 in groups) {
      items.add(
        DropdownMenuItem(
          value: BloodGroup1,
          child: Text(BloodGroup1.group),
        ),
      );
    }
    return items;
  }
  onChangeDropdownItem(BloodGroup selectedBloodGroup) {
  setState(() {
    _selectedBloodGroup = selectedBloodGroup;
    print(_selectedBloodGroup.group);
  });
  }
  bool isNumeric(String s) {
          if(s == null) {
              return false;
            }
          return double.parse(s, (e) => null) != null;
        }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Donor Details"),
      ),
      body: Column
      (
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: <Widget>
        [
          Container
          (
            padding: EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
            child:Text("Add Donors to verified Donors",style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
          ),
          Container
          (
            padding: EdgeInsets.only(top: 10.0, left: 120.0, right: 120.0),
            child:Row
            (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>
              [
                Text(
                  'Blood Group',
                  style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5.0),              
                DropdownButton(
                  value: _selectedBloodGroup,
                items: buildDropdownMenuItems(_groups),
                
                onChanged: onChangeDropdownItem,
                 underline: Container(
                      height: 2,
                       color: Colors.greenAccent,
                      ))
              ],
            ),
          ),
          Container
          (
            padding: EdgeInsets.only(top: 10.0, left: 120.0, right: 120.0),
            child:Row(
                            children: <Widget>[
                              new Flexible(
                                child:TextField(
                                  controller: PinController,
                                  decoration: InputDecoration( contentPadding: EdgeInsets.all(10),
                                  hintText: 'XXXXXX',
                                  labelText: 'Donor ID',
                                  labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                                )
                              ),
                            ]
            )
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 120.0, right: 120.0),
                      height: 40.0,
                      child: new RaisedButton(
                        // borderRadius: BorderRadius.circular(20.0),
                        // shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                          onPressed: () => _selectDate(context),
                         child: Center(
                            child: Text(
                              'Date picker',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        // ),
                      )
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 120.0, right: 120.0),
                      height: 40.0,
                      child: new RaisedButton(
                        // borderRadius: BorderRadius.circular(20.0),
                        // shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        // child: GestureDetector(
                          onPressed: () {
                            // insertdonor();
                            f=0;
                            print("hello");
                            setState(() {
                              Pincode=PinController.text;
                              if(Pincode.length==0)
                              {
                                                                print("hello9");

                                alertContent="Donor ID Field cannot be Empty";
                                createAlertDialog(context);
                              }
                              else if(selectedDate==null||selectedDate.isAfter(DateTime.now())==true)
                              {
                                alertContent="Invalid Date";
                                createAlertDialog(context);
                              }
                              else if(_selectedBloodGroup==null)
                              {
                                print("hello3");

                                alertContent="Please Select a Blood Group \n Choose \"Not Sure\" if you are not sure";
                                createAlertDialog(context);
                              }
                              else{
                                    print("hello2");
                                    print(Pincode); 
                                    Blood_group=_selectedBloodGroup.group;
                                    PinController.text="";
                                    _selectedBloodGroup=null;
                                  
                              }
                            });
                            if(f==0)
                            {
                              if(Pincode[1]=='B'||Pincode[1]=='b')
                              {
                                if(check(Pincode))
                                {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => Insert_donor(Pincode,Blood_group,date,id,"","")),);
                                }
                                else
                                {
                                  alertContent="No Such ID Exist";
                                  createAlertDialog(context);
                                }
                              }
                              else
                              {
                                String o=getOrgan(Pincode);
                                o=o.toLowerCase();
                                print(o);
                                if(o=="")
                                {
                                  alertContent="No Such ID Exist";
                                  createAlertDialog(context);
                                }
                                else if(o=='cornea')
                                {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => Insert_donor(Pincode,Blood_group,date,id,"","")),);
                                }
                                else if(o=='kidney')
                                {
                                  OrganDialog(context, "Kidney", "PRA");
                                }
                                else if(o=="pancreas")
                                {
                                  OrganDialog(context, 'Pancreas', "OPTN");

                                }
                                else if(o=="liver")
                                {
                                  OrganDialog(context, "Liver", "weight");
                                }
                                else if(o=="heart")
                                {
                                  OrganDialog(context, "Heart", "weight");
                                }
                                else
                                {
                                  Lung(context);
                                }
                              }
                            }
                          },
                          child: Center(
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        // ),
                      )),
        ],
      ),
    );
  }
}