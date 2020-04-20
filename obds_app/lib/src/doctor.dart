import 'package:flutter/material.dart';

class Doctor extends StatefulWidget{
  @override
  DoctorState createState() => DoctorState();
}

class DoctorState extends State<Doctor>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
           IconButton(
             icon: Icon(Icons.exit_to_app),
             onPressed: (){
               print("pressed");
             },
           )

          ],
          bottom: TabBar(
            
            tabs: <Widget>[
              Tab( icon:  Icon(Icons.favorite), text: "Organs",),
              Tab(icon: Icon(Icons.opacity), text: "Blood",),
            ],
          ),
          title: Text("Logged In as a Doctor"),
        ),
        body: TabBarView(
          children: <Widget>[
            //Children for Tab1 ie, Organs
            ListView(
              children: <Widget>[
                Card(
                  child: ListTile(
                    leading: FlutterLogo(size: 72.0),
                    title: Text('Three-line ListTile'),
                    subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'
                    ),
                    trailing: Icon(Icons.more_vert),
                    isThreeLine: true,
                  ),
                )
              ],
            ),
            //Children for Tab2 ie, Blood
            ListView(
              children: <Widget>[
                Card(
                  child: ListTile(
                    leading: FlutterLogo(size: 72.0),
                    title: Text('Three-line ListTile'),
                    subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'
                    ),
                    trailing: Icon(Icons.more_vert),
                    isThreeLine: true,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}