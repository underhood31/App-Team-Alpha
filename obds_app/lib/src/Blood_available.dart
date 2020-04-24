import 'package:flutter/material.dart';
import './Show_blood.dart';
class  Blood_avialable extends StatefulWidget
{
  @override
  Blood_avialableState createState() => Blood_avialableState();
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
class Blood_avialableState extends State<Blood_avialable>
{
  String alertTitle="Error",alertContent="";
  int f=0;
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
          [MaterialButton
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
        title: Text("Organisation List"),
      ),
      body: Column
      (
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: <Widget>
        [
          Container
          (
            padding: EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
            child:Text("Search For the Nearby bloodbank",style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
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
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration( contentPadding: EdgeInsets.all(10),
                                  hintText: 'XXXXXX',
                                  labelText: 'Pin Code',
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

                                alertContent="Pincode Field cannot be Empty";
                                createAlertDialog(context);
                              }
                              else if(!isNumeric(Pincode))
                              {
                                                                print("hello8");

                                alertContent="Pincode should be Numeric of the form XXXXXX \n e.g: 243122";
                                createAlertDialog(context);
                              }
                              else if(_selectedBloodGroup==null)
                              {
                                print("hello3");

                                alertContent="Please Select a Blood Group \n Choose \"Not Sure\" if you are not sure";
                                createAlertDialog(context);
                              }
                              else{
                                  var pin=int.parse(Pincode);
                                  print(pin);
                                  if(Pincode.length!=6 && !(Pincode.length==7 && Pincode[Pincode.length-1]==" "))
                                  {
                                    print("hello7");
                                    print(Pincode.length);
                                    print(Pincode);
                                      alertContent="Not a valid Pincode ";
                                      createAlertDialog(context);
                                  }
                                  else if(pin>929999 ||pin <110000)
                                  {
                                    print("hello6");
                                    alertContent="NOt a valid Pincode";
                                    createAlertDialog(context);
                                  }
                                  else
                                  {
                                    print("hello2");
                                    print(Pincode); 
                                    Blood_group=_selectedBloodGroup.group;
                                    if(Pincode.length==7 && Pincode[Pincode.length-1]==" ")
                                    {
                                      Pincode=Pincode.substring(0,6);
                                    }
                                    PinController.text="";
                                    _selectedBloodGroup=null;
                                  } 
                              }
                            });
                            if(f==0)
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Show_blood(Pincode,Blood_group)),);
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