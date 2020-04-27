import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:obdsapp/src/Blood_available.dart';
import 'package:obdsapp/src/d_check_organ.dart';
import 'package:obdsapp/src/d_orgHist.dart';
import 'package:obdsapp/src/d_organ_organisations.dart';
import '../main.dart';
import 'Near_bloodbank.dart';
import 'd_search.dart';

class Doctor extends StatefulWidget{
  @override
  DoctorState createState() => DoctorState();
}

class DoctorState extends State<Doctor>{

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        
        appBar: AppBar(
          leading: Text(''),
          actions: <Widget>[
           IconButton(
             icon: Icon(Icons.exit_to_app),
             onPressed: (){
                Navigator.pushReplacementNamed(context, "/logout");
             },
           )

          ],
          bottom: TabBar(
            
            tabs: <Widget>[
              Tab( icon:  Icon(Icons.favorite), text: "Organs",),
              Tab(icon: Icon(Icons.opacity), text: "Blood",),
            ],
          ),
          title: Text("Logged In as a Doctor", textAlign: TextAlign.center,),
          centerTitle: true,
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
                      'Check availability of organs, search organs.'
                    ),
                    trailing: Icon(Icons.more_vert),
                    // isThreeLine: true,
                    onTap:() {
                    
                      // print(organList)
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckOrgans()),
                      );
                    } ,
                  ),
                ),
                
                 Card(
                  child: ListTile(
                    leading: Icon(Icons.search,size: 48,),
                    onTap: ()  {
                     
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchOrgans()),
                      );
                    },
                    title: Text('Search Compatibility of the Organs'),
                    subtitle: Text(
                      'Search for compatible organs.'
                    ),
                    trailing: Icon(Icons.more_vert),
                    isThreeLine: true,
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrganHistory()),
                      );
                    },
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
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrganOrganisations()),
                      );

                    },
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Blood_avialable()),);
                    },
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Near_bloodbank()),);
                    },
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