import 'package:flutter/material.dart';
import 'package:obdsapp/src/Organizations.dart';
import 'package:obdsapp/src/Patient.dart';
import 'package:obdsapp/src/bloodbank.dart';
import 'package:obdsapp/src/doctor.dart';
import 'package:obdsapp/src/newDonor.dart';
import 'mysql1.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  AnimationController iconController;
  Animation<double> iconAnimation;
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
                color: Colors.black87,
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
                                      return showDialog(
                                          context: context, builder: (context) {
                                        return AlertDialog(
                                            content: Text("Unregister Credentials"));
                                      });
                                    }
                                    else if (result1 == 1) {
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
            ],)
          ],
        )
    );
  }
}