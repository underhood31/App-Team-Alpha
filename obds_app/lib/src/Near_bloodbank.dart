import 'package:flutter/material.dart';
import './Show_blood.dart';
class  Near_bloodbank extends StatefulWidget
{
  @override
  Near_bloodbankState createState() => Near_bloodbankState();
}
class Near_bloodbankState extends State<Near_bloodbank>
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
    final PinController=new TextEditingController();
    String Pincode;
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
                                    if(Pincode.length==7 && Pincode[Pincode.length-1]==" ")
                                    {
                                      Pincode=Pincode.substring(0,6);
                                    }
                                    PinController.text="";
                                  } 
                              }
                            });
                            if(f==0)
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Show_blood(Pincode,"")),);
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