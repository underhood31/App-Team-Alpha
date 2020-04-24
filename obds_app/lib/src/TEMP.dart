import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:obdsapp/src/Organisation.dart';
import 'package:obdsapp/src/Patient.dart';
import 'package:obdsapp/src/doctor.dart';

class Selection extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete me"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Doctor"),
              onPressed: (){

                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Doctor()),
                      );
              },
            ),
            RaisedButton(
              child: Text("Organisation"),
              onPressed: (){

                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Organisation()),
                      );
              },
              
            ),
            
            RaisedButton(
              child: Text("Patient"),
              onPressed: (){

                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Patient("PAT_498  ")),
                      );
              },
              
            ),
            
          ],
        ),
      ),
    );
  }

}