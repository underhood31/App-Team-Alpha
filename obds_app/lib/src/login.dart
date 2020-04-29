import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysql1/mysql1.dart';
import 'package:obdsapp/main.dart';
import 'package:obdsapp/src/Donor.dart';
import 'package:obdsapp/src/Organizations.dart';
import 'package:obdsapp/src/Patient.dart';
import 'package:obdsapp/src/bloodbank.dart';
import 'package:obdsapp/src/doctor.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'mysql1.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  AnimationController iconController;
  Animation<double> iconAnimation;
  ProgressDialog pr;  
  final logo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 48.0,
      child: Image.asset('assets/logo.png'),
    ),
  );

  @override
  void initState() {
    super.initState();
    iconController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    iconAnimation =
    new CurvedAnimation(parent: iconController, curve: Curves.easeOut);
    iconAnimation.addListener(() => this.setState(() {}));
    iconController.forward();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Mysql sql = new Mysql();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.black,
        body: new Stack(fit: StackFit.expand,
          children: <Widget>[

            // Creating the background
            new Image(image: new AssetImage("assets/hands.jpg"),
                fit: BoxFit.cover,
                color: Colors.black54,
                colorBlendMode: BlendMode.luminosity),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[

              // Creating the logo
              logo,
              new Form(child: new Theme(data: new ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.teal,
                  inputDecorationTheme: new InputDecorationTheme(
                      labelStyle: new TextStyle(
                          color: Colors.teal, fontSize: 20))),
                child: new Container(padding: const EdgeInsets.all(40),
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          // Setting up the email address and password fields
                          new TextFormField(controller: emailController,
                            decoration: new InputDecoration(
                                labelText: "Username"),
                            keyboardType: TextInputType.text,),
                          new TextFormField(controller: passwordController,
                              decoration: new InputDecoration(
                                  labelText: "Password"),
                              keyboardType: TextInputType.text, obscureText: true,),
                          new Padding(padding: EdgeInsets.only(top: 30)),
                          // ignore: missing_return
                          new RaisedButton.icon(
                            onPressed: () async
                            {
                              if (emailController.text == "" && passwordController.text == "")
                                {
                                  return showDialog(
                                    context: context, builder: (context) {
                                  return AlertDialog(
                                      content: Text("Fields Empty\nEnter Credentials"));
                                });

                                }
                              else if (emailController.text == "")
                                {
                                  return showDialog(
                                      context: context, builder: (context) {
                                    return AlertDialog(
                                        content: Text("Username Field Cannot Be Empty"));
                                  });
                                }

                              else if (passwordController.text == "")
                                {
                                  return showDialog(
                                      context: context, builder: (context) {
                                    return AlertDialog(
                                        content: Text("Password Cannot Be Empty"));
                                  });
                                }
                              int result1;
                              pr = new ProgressDialog(context);
                                pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
                                pr.style(
                                  message: 'Please Wait...',
                                  borderRadius: 7.0,
                                  backgroundColor: Colors.white,
                                  progressWidget: CircularProgressIndicator(),
                                  elevation: 10.0,
                                  insetAnimCurve: Curves.decelerate,
                                  progress: 0.0,
                                  maxProgress: 100.0,
                                  progressTextStyle: TextStyle(
                                    color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
                                  messageTextStyle: TextStyle(
                                    color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
                                  );
                                pr.show();
                              var db = new Mysql();
                              db.getConnection().then((conn) async
                              {
                                
                                String sql = "Select * from Account where id = \'" +
                                    emailController.text +
                                    "\' and password = \'" +
                                    passwordController.text + "\';";
                                await Future.delayed(Duration(seconds: 1), () {
                                  conn.query(sql).then((results) {
                                    //print('@');
                                    print(results);
                                    result1 = results.length;
                                    print(result1);
                                    conn.close();
                                    if (result1 == 0) {
                                      pr.hide();
                                      return showDialog(
                                          context: context, builder: (context) {
                                        return AlertDialog(
                                            content: Text("Unregistered Credentials"));
                                      });
                                    }
                                    else if (result1 == 1) {
                                      pr.hide();
                                      String category = results.elementAt(0).values[2];
                                      if(category.toLowerCase()=="doctor"){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Doctor()));
                                      }
                                      else if(category.toLowerCase()=="patient"){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Patient(results.elementAt(0).values[0])));
                                      }
                                      else if(category.toLowerCase()=="blood_bank"){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => BloodBankPage(results.elementAt(0).values[0])));
                                      }
                                      else if(category.toLowerCase()=="organisation" || category.toLowerCase()=="organization"){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Organization(results.elementAt(0).values[0])));
                                      }
                                      else if(category.toLowerCase()=="donor"){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DonorPage(results.elementAt(0).values[0],true)));
                                      }
                                    }
                                  });
                                });
                              });
                            },
                            icon: Icon(Icons.person),
                            label: Text("Sign In"),
                            color: Colors.teal,
                            splashColor: Colors.blue,),
                        ])),)),
              new RaisedButton.icon(onPressed: () => {
                  Navigator.of(context).pushNamed('/signup')
              },
                icon: Icon(Icons.mail),
                label: Text("Register"),
                color: Colors.teal,
                splashColor: Colors.blue,),
                RaisedButton.icon(
                  icon: Icon(Icons.swap_horizontal_circle,color: Colors.white,),
                  color: Colors.black12,
                  label: Text("Change DB (for debuging purpose only)", style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    print("tapped");
                    ConnectionSettings temp;
                    //Swapping credentials
                    temp = sql_cred;
                    sql_cred=backup_cred;
                    backup_cred=temp;

                    Fluttertoast.showToast(
                      msg: "Connection changed to ${sql_cred.host}",
                      textColor: Colors.black,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.white,
                    );
                  },
                  
                )
            ],)
          ],
        )
    );
  }
}