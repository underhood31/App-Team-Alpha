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
                    leading: Icon(Icons.local_hospital,size: 48,),
                    title: Text('Check Available Organs'),
                    subtitle: Text(
                      'Check availability of organs, search organs and mark them for use.'
                    ),
                    trailing: Icon(Icons.more_vert),
                    isThreeLine: true,
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.border_all,size: 48,),
                    title: Text('All Organs'),
                    subtitle: Text(
                      'See the list of all the organs available in the organ bank.'
                    ),
                    trailing: Icon(Icons.more_vert),
                    isThreeLine: true,
                  ),
                ),
                 Card(
                  child: ListTile(
                    leading: Icon(Icons.search,size: 48,),
                    title: Text('Search Compatibility of the Organs'),
                    subtitle: Text(
                      'Search for compatible organs and mark for use.'
                    ),
                    trailing: Icon(Icons.more_vert),
                    isThreeLine: true,
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.history,size: 48,),
                    title: Text('Organ History'),
                    subtitle: Text(
                      'Get to know the anonymous Organ history of the Organ donor.'
                    ),
                    trailing: Icon(Icons.more_vert),
                    isThreeLine: true,
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.map,size: 48,),
                    title: Text('Organ Donation Organisations'),
                    subtitle: Text(
                      'Find the nearest Organisation for donating and recieving oragans based upon the PIN code of your area.'
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
                    leading: Icon(Icons.help,size: 48,),
                    title: Text('Available blood groups'),
                    subtitle: Text(
                      'Check availability of the blood groups and know the location where they are present.'
                    ),
                    trailing: Icon(Icons.more_vert),
                    isThreeLine: true,
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.map,size: 48,),
                    title: Text('Blood Banks'),
                    subtitle: Text(
                      'Find the nearest Blood Bank for donating and recieving blood based upon the PIN code of your area.'
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