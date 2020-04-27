import 'package:flutter/material.dart';
import 'mysql1.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'bloodbank.dart'as bloodbankpage;


class IncrementBB extends StatefulWidget{
  String bloodbankid;
  IncrementBB(this.bloodbankid);
  @override
  IncrementBBState createState() => IncrementBBState(bloodbankid);
}
class BloodGroup {
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

class IncrementBBState extends State<IncrementBB>{
  String bloodbankid;
  IncrementBBState(this.bloodbankid);
  TextEditingController UnitsController=new TextEditingController(); 
  // static String bloodbankid="BBANK_999";
  static String _selectedBloodGroupText,Incrementvalue,alertTitle,alertContent;
  List<BloodGroup> _groups = BloodGroup.getgroups();
  BloodGroup _selectedBloodGroup;
  List<DropdownMenuItem<BloodGroup>> buildDropdownMenuItems(List groups) {
    List<DropdownMenuItem<BloodGroup>> items = List();
    for (BloodGroup BloodGroup1 in groups) {
      items.add(
          DropdownMenuItem(
            value: BloodGroup1,
            child: Text(BloodGroup1.group,style:  TextStyle(fontSize: 20)),
          ),
        );
    }
    return items;
    }
  onChangeDropdownItem(BloodGroup selectedBloodGroup) {
      setState(() {
        _selectedBloodGroup = selectedBloodGroup;
        // print(_selectedBloodGroup.group);
      });
    }
    bool isNumeric(String s) {
          if(s == null) {
              return false;
            }
          return double.parse(s, (e) => null) != null;
    }

  void UpdateValues() async
  {
    var db = new Mysql();
      db.getConnection().then((conn)  async{
        String sql = "update Blood_Bank set $_selectedBloodGroupText =$_selectedBloodGroupText  + $Incrementvalue where BANK_id=\"$bloodbankid\";"; 
        conn.query(sql);
        conn.close();
        alertTitle="Success !!";
        alertContent="Added $Incrementvalue Units of blood to $_selectedBloodGroupText";
        createAlertDialog(context);

  }); 
  }
    createAlertDialog(BuildContext context)
  {
    // print(alertTitle);
    return showDialog(context: context ,builder:(context){
    return AlertDialog(
      title: Text(alertTitle,     style: TextStyle(fontFamily: 'Montserrat'),),
      content: Text(alertContent,     style: TextStyle(fontFamily: 'Montserrat'),),
      actions: <Widget>[MaterialButton (
                                        color: Colors.green,
                                        elevation:15,
                                        child :Text("Go Back",style: TextStyle(fontFamily: 'Montserrat')),  
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                          })],
    );

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,

      appBar:  AppBar(backgroundColor: Colors.green,),
      body:

            Column(children: <Widget>[
              SizedBox(height:100 ,),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Blood Group',
                  style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold,fontSize: 20),
                ),
                SizedBox(width: 5.0),              
                DropdownButton(
                  iconSize: 20,
                  value: _selectedBloodGroup,
                items: buildDropdownMenuItems(_groups),                
                onChanged: onChangeDropdownItem,
                 underline: Container(
                      height: 2,
                       color: Colors.greenAccent,
                      ))]
              ),
              SizedBox(height:30),
                Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Text(
                  'Number of units added',
                  style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold,fontSize: 20),
                ),
                SizedBox(width: 5.0),              
                  Container(
                  width:100,
                  child: TextField(
                    controller: UnitsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ) 
                  )                
                ],),
                SizedBox(height:125),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                                  MaterialButton (
                                    color: Colors.green,
                                    elevation:5,
                                    child :Text("Go",style: TextStyle(fontFamily: 'Montserrat')),  
                                    onPressed: () async{
                                      // print(_selectedBloodGroup);
                                      // print(UnitsController.text);
                                      if(_selectedBloodGroup==null)
                                      {
                                        alertTitle="Error";
                                        alertContent="Please Select a Blood Group";
                                        createAlertDialog(context);
                                      }
                                      else if(!isNumeric(UnitsController.text))
                                      {
                                        alertTitle="Error";
                                        alertContent="Please enter the number of units";
                                        createAlertDialog(context);

                                      }
                                      else if(UnitsController.text.contains("."))
                                      {
                                        alertTitle="Error";
                                        alertContent="Units can be Integers Only";
                                        createAlertDialog(context);

                                      }
                                      else if(UnitsController.text.contains("-"))
                                      {
                                        alertTitle="Error";
                                        alertContent="Units cannot be a negative value";
                                        createAlertDialog(context);

                                      }

                                      else
                                      {
                                        if(_selectedBloodGroup.group=='B+')
                                        {
                                          _selectedBloodGroupText="Bpositive";
                                        }
                                        else if(_selectedBloodGroup.group=='B-')
                                        {
                                          _selectedBloodGroupText="Bnegative";
                                        }
                                        else if(_selectedBloodGroup.group=='A+')
                                        {
                                          _selectedBloodGroupText="Apositive";
                                        }
                                        else if(_selectedBloodGroup.group=='A-')
                                        {
                                          _selectedBloodGroupText="Anegative";
                                        }
                                        else if(_selectedBloodGroup.group=='AB+')
                                        {
                                          _selectedBloodGroupText="ABpositive";
                                        }
                                        else if(_selectedBloodGroup.group=='AB-')
                                        {
                                          _selectedBloodGroupText="ABnegative";
                                        }
                                        else if(_selectedBloodGroup.group=='O+')
                                        {
                                          _selectedBloodGroupText="Opositive";
                                        }
                                        else 
                                        {
                                          _selectedBloodGroupText="Onegative";
                                        }
                                        Incrementvalue=UnitsController.text;

                                        UpdateValues();
                                        setState(() {
                                        _selectedBloodGroup=null;
                                        UnitsController.text="";
                                          
                                        });

                                      }

                                      }),
                                  MaterialButton (
                                    color: Colors.green,
                                    elevation:5,
                                    child :Text("Back",style: TextStyle(fontFamily: 'Montserrat')),  
                                    onPressed: (){
                                                  Navigator.of(context).pop();
                                      })

                ],

            )


  ]
              )

    );
    }


}
