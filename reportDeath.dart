import 'package:flutter/material.dart';
import 'package:flutterapp/Donor.dart';
import 'Donor.dart';
import 'sql1.dart';

class reportDeath extends StatefulWidget {

  var id;
  reportDeath(this.id);
  @override
  _reportDeathState createState() => _reportDeathState(id);
}

class _reportDeathState extends State<reportDeath> with SingleTickerProviderStateMixin {
  @override
  Mysql sql = new Mysql();
  var id;

  _reportDeathState(this.id);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: new Stack(fit: StackFit.expand,
          children: <Widget>[
            // Creating the background
            new Column(
              mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              new Form(child: new Theme(data: new ThemeData(
                  brightness: Brightness.light,
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
                                labelText: "Cause Of Death"),
                            keyboardType: TextInputType.text,),
                          new TextFormField(controller: passwordController,
                            decoration: new InputDecoration(
                                labelText: "Time Of Death"),
                            keyboardType: TextInputType.datetime,),
                          new Padding(padding: EdgeInsets.only(top: 30)),
                          // ignore: missing_return
                        ])),)),
              new RaisedButton.icon(onPressed: ()  {

    if (emailController.text == "" && passwordController.text == "")
    {
      return showDialog(
      context: context, builder: (context) {
      return AlertDialog(
      content: Text("Fields Empty\nPlease Fill in the Details"));
      });

    }
    else if (emailController.text == "")
    {
      return showDialog(
      context: context, builder: (context) {
      return AlertDialog(
      content: Text("Empty Field : Enter Cause of Death"));
      });
    }

    else if (passwordController.text == "")
    {
      return showDialog(
      context: context, builder: (context) {
      return AlertDialog(
      content: Text("Field Emtpy : Enter Time Of Death"));
      });
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => new DonorPage(id)),);},
    icon: Icon(Icons.add_alert),label: Text("Report"),color: Colors.teal,splashColor: Colors.blue,),
            ],)
          ],
        )
    );
  }
}
