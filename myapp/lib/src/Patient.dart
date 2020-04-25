import 'package:flutter/material.dart';
import './Organs_available.dart';
import './Personal.dart';
import './Near_bloodbank.dart';
import './Blood_available.dart';
import './All_organisations.dart';
import './Chances.dart';
class Patient extends StatefulWidget
{
  var id;
  Patient(this.id);
  @override
  PatientState createState() => PatientState(id);
}
class PatientState extends State<Patient>
{
  var id;
  PatientState(this.id);
  @override
  Widget build(BuildContext context)
  {
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
          title: Text("Logged In as a Patient"),
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
                      'Check availability of your Matching organ'
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Organ_available(id)),);
                    },
                    isThreeLine: true,
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.search,size: 48,),
                    title: Text('Search for all organisation'),
                    subtitle: Text(
                      'Search for all the organisation having matching organ'
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => All_organisation(id)),);
                    },
                    isThreeLine: true,
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.view_list,size: 48,),
                    title: Text('View Your Details'),
                    subtitle: Text(
                      'View Personal and Organ Details'
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Personal(id)),);
                    },
                    isThreeLine: true,
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.star,size: 48,),
                    title: Text('Viewing Probablity of Matching'),
                    subtitle: Text(
                      'View the Chances of getting a match'
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Chances(id)),);
                    },
                    isThreeLine: true,
                  ),
                ),
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
                    isThreeLine: true,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Blood_avialable()),);
                    }
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.map,size: 48,),
                    title: Text('Blood Banks'),
                    subtitle: Text(
                      'Find the nearest Blood Bank for donating and recieving blood based upon the PIN code of your area.'
                    ),
                    isThreeLine: true,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Near_bloodbank()),);
                    }
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