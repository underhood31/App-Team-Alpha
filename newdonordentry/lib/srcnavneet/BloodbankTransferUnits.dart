import 'package:flutter/material.dart';
import 'mysql1.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class TransferBB extends StatefulWidget
{
  String bloodbankid;
  TransferBB(this.bloodbankid);
   @override
  TransferBBState createState() => TransferBBState(bloodbankid);
 
}
class TransferBBState extends State<TransferBB>
{
  String bloodbankid;
  TransferBBState(this.bloodbankid);
  TextEditingController   BankController=new TextEditingController(); 
  TextEditingController UnitsController=new TextEditingController(); 
  TextEditingController BloodgroupController=new TextEditingController();
  static int Bpositive=0,Bnegative=0,Apositive=0,Anegative=0,Opositive=0,Onegative=0,ABpositive=0,ABnegative=0;
  static String selectedBloodGroupText,Decrementvalue,Otherbankidtext,alertTitle,alertContent;
  List<String> OtherBankid=[];
  static Widget initialPage=SpinKitChasingDots(
    color: Colors.green,
    size: 50.0,
  );
  List<String> suggestions = [
   "B+","B-","A+","A-","AB+","AB-","O+","O-"
  ];
  // SimpleAutoCompleteTextField textField;
  // bool showWhichErrorText = false;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key2 = new GlobalKey();

  static Widget currentPage,afterloadPage;
    bool isNumeric(String s) {
          if(s == null) {
              return false;
            }
            
          return double.parse(s, (e) => null) != null;
    }
  void updatepage() async {
    await UpdateValues();

    afterloadPage=Column(children: <Widget>[
              SizedBox(height:100 ,),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Receiver\'s Blood Bank id:',
                  style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold,fontSize: 20),
                ),
                SizedBox(width: 5.0),              
                  Container(
                  width:100,
                  child: SimpleAutoCompleteTextField (
                    suggestions: OtherBankid,
                    controller: BankController,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))), key: key2,
                  ) 
                  )                
                ]
              ),
              SizedBox(height:30),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Blood Group',
                  style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold,fontSize: 20),
                ),
                SizedBox(width: 5.0),              
                  Container(
                  width:100,
                  child: SimpleAutoCompleteTextField (
                    suggestions: suggestions,
                    controller: BloodgroupController,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))), key: key,
                  ) 
                  )                
                ]
              ),
              SizedBox(height:30),
                Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Text(
                  'Number of units to be transferred',
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
                                      // print(BloodgroupController.text);
                                      // print(UnitsController.text);

                                      if(!OtherBankid.contains(BankController.text) )
                                      {
                                        print("here");
                                        alertTitle="Error";
                                        alertContent="Not a valid Blood bank id";
                                        createAlertDialog(context);
                                      }
                                      else if(BloodgroupController.text.length==0)
                                      {
                                        alertTitle="Error";
                                        alertContent="Please Enter a Blood Group";
                                        createAlertDialog(context);
                                      }
                                      else if(BloodgroupController.text!='B+'  && BloodgroupController.text!='B-' &&BloodgroupController.text!='A+'  && BloodgroupController.text!='A-'&&BloodgroupController.text!='AB+'  && BloodgroupController.text!='AB-'&&BloodgroupController.text!='O+'  && BloodgroupController.text!='O-')
                                      {
                                        alertTitle="Error";
                                        alertContent="Please Enter Blood Group in correct form. Eg:- \"B+\"";
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
                                        int units=int.parse(UnitsController.text);
                                        bool flag=true; 
                                        if(BloodgroupController.text=='B+')
                                        {
                                          selectedBloodGroupText="Bpositive";
                                          if(units>Bpositive)
                                          {
                                            alertTitle="Error";
                                            alertContent="You have only $Bpositive Units of B+ Blood";
                                            flag=false;
                                            createAlertDialog(context);
                                          }
                                        }
                                        else if(BloodgroupController.text=='B-')
                                        {
                                          selectedBloodGroupText="Bnegative";
                                          if(units>Bnegative)
                                          {
                                          alertTitle="Error";
                                          alertContent="You have only $Bnegative Units of B+ Blood";
                                          flag=false;
                                          createAlertDialog(context);
                                          }

                                        }
                                        else if(BloodgroupController.text=='A+')
                                        {
                                          selectedBloodGroupText="Apositive";
                                          if(units>Apositive)
                                          {
                                          alertTitle="Error";
                                          alertContent="You have only $Apositive Units of B+ Blood";
                                          flag=false;
                                          createAlertDialog(context);
                                          }

                                        }
                                        else if(BloodgroupController.text=='A-')
                                        {
                                          selectedBloodGroupText="Anegative";
                                          if(units>Anegative)
                                          {
                                          alertTitle="Error";
                                          alertContent="You have only $Anegative Units of B+ Blood";
                                          flag=false;
                                          createAlertDialog(context);
                                          }

                                        }
                                        else if(BloodgroupController.text=='AB+')
                                        {
                                          selectedBloodGroupText="ABpositive";
                                          if(units>ABpositive)
                                          {
                                          alertTitle="Error";
                                          alertContent="You have only $ABpositive Units of B+ Blood";
                                          flag=false;
                                          createAlertDialog(context);
                                          }

                                        }
                                        else if(BloodgroupController.text=='AB-')
                                        {
                                          selectedBloodGroupText="ABnegative";
                                          if(units>ABnegative)
                                          {
                                          alertTitle="Error";
                                          alertContent="You have only $ABnegative Units of B+ Blood";
                                          flag=false;
                                          createAlertDialog(context);
                                          }

                                        }
                                        else if(BloodgroupController.text=='O+')
                                        {
                                          selectedBloodGroupText="Opositive";
                                          if(units>Opositive)
                                          {
                                          alertTitle="Error";
                                          alertContent="You have only $Opositive Units of B+ Blood";
                                          flag=false;
                                          createAlertDialog(context);
                                          }

                                        }
                                        else 
                                        {
                                          selectedBloodGroupText="Onegative";
                                          if(units>Onegative)
                                          {
                                          alertTitle="Error";
                                          alertContent="You have only $Onegative Units of B+ Blood";
                                          flag=false;
                                          createAlertDialog(context);
                                          }
                                        }
                                        if(flag)
                                        {
                                          Decrementvalue=UnitsController.text;
                                          Otherbankidtext=BankController.text;
                                          Transferunits();
                                          setState(() {
                                            BloodgroupController.text="";
                                            UnitsController.text="";
                                            BankController.text="";
                                          });
                                          
                                        }
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
  );
  setState(() {
    currentPage=afterloadPage;
  });
   }
 Future<void> UpdateValues() async
  {
    var row;
     var db = new Mysql();
      await db.getConnection().then((conn)  async{
        String sql = "select Bpositive,Bnegative,Apositive,Anegative,ABpositive,ABnegative,Opositive,Onegative from Blood_Bank where BANK_id=\"$bloodbankid\";"; 
        await conn.query(sql).then((results)
        {
          row= results.elementAt(0);        
          Bpositive=row[0];
          Bnegative=row[1];
          Apositive=row[2];
          Anegative=row[3];
          ABpositive=row[4];
          ABnegative=row[5];
          Opositive=row[6];
          Onegative=row[7];
        });
        sql="select BANK_id from Blood_Bank where BANK_id<>\"$bloodbankid\";";
            print("here2");
        await conn.query(sql).then((results)
        {
          for(var row2 in results)
          {
            print("here1");
            // String temp=row2[0];
            OtherBankid.add(row2[0]);
          }
        });
            print("here3");

        print(OtherBankid);
      conn.close();
  });   
  }
    void Transferunits() async
  {
    var db = new Mysql();
      db.getConnection().then((conn)  async{
        String sql = "update Blood_Bank set $selectedBloodGroupText =$selectedBloodGroupText  - $Decrementvalue where BANK_id=\"$bloodbankid\";"; 
        conn.query(sql);
        sql = "update Blood_Bank set $selectedBloodGroupText =$selectedBloodGroupText  + $Decrementvalue where BANK_id=\"$Otherbankidtext\";"; 
        conn.query(sql);
        conn.close();
        if(selectedBloodGroupText=='Bpositive')
        {
          Bpositive-=int.parse(Decrementvalue);
        }
        else if(selectedBloodGroupText=='Bnegative')
        {
          Bnegative-=int.parse(Decrementvalue);
        }
        else if(selectedBloodGroupText=='Apositive')
        {
          Apositive-=int.parse(Decrementvalue);
        }
        else if(selectedBloodGroupText=='Anegative')
        {
          Anegative-=int.parse(Decrementvalue);

        }
        else if(selectedBloodGroupText=='ABpositive')
        {
          ABpositive-=int.parse(Decrementvalue);

        }
        else if(selectedBloodGroupText=='ABnegative')
        {
          ABnegative-=int.parse(Decrementvalue);

        }
        else if(selectedBloodGroupText=='Opositive')
        {
          Opositive-=int.parse(Decrementvalue);

        }
        else 
        {
          Onegative-=int.parse(Decrementvalue);
        }
        alertTitle="Success !!";
        alertContent="Transferred $Decrementvalue Units blood from $selectedBloodGroupText to Bank with Id:$Otherbankidtext ";
        createAlertDialog(context);
  }); 
  }

  createAlertDialog(BuildContext context)
  {
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
  void initState() {
    super.initState();
    currentPage=initialPage;
    updatepage();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(backgroundColor: Colors.green,),
      body: currentPage,
    
    );


  }

}