import 'package:flutter/material.dart';

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new Container(
      child: GridView(
        
        // padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        
        children: <Widget>[
          Card (
            shape:new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)
            ),
            elevation: 30,

            child: new Container(
              child: Align(alignment: Alignment.center,
              child: new Text("    B+ \n 20 units",style : TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize:30)),
              
              )
            )
          ),




        ],
        ),        
    );
  }
}