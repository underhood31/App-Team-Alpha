import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'contactdonorOrganisation.dart';
import 'contactblooddonorOrganisation.dart';
import 'mysql1.dart';
import './Details.dart';
import './Inactive.dart';

class Organization extends StatefulWidget
{
  String Org_id;
  Organization(this.Org_id);
  @override
  OrganizationState createState() => OrganizationState(Org_id);
}
class OrganizationState extends State<Organization> {
  String Org_id;
  OrganizationState(this.Org_id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(          
      leading: Text(""),
      backgroundColor:Colors.green,
      title: Text("Logged In as a Organisation"),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: (){
            Navigator.pushReplacementNamed(context, "/logout");
          },
        )
      ],
      ),
      body:
      Container(
        child:      ListView(

        children: <Widget>[
                           Card(
                  child: ListTile(
                    leading: Icon(Icons.add,size: 48,),
                    title: Text('Add Donor to Verified Donor'),
                    subtitle: Text(
                      'Add an Donor to the verified donor list'
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Details(Org_id)),);
                    },
                    isThreeLine: true,
                  ),
                ),
                Card(

                  child: ListTile(
                    leading: Icon(Icons.check,size: 48,),
                    title: Text('Mark Donors as inactive'),
                    subtitle: Text(
                      'Mark Donors inactive related to your Organisation'
                    ),
                    onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Inactive(Org_id)),);
                    },
                    isThreeLine: true,
                  ),
                ),

          Card (            
            
            child: new ListTile(
                                  leading: Icon(Icons.opacity,size: 48,),

              title: new Text("\n Blood Donor List \n",style : TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize:21)),             
              onTap: (){ 
                 Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => new ContactBloodDonorOrg(Org_id))  ,
                      );
              },
            )
          ),
          Card (

            child: new ListTile(

                                  leading: Icon(Icons.assistant,size: 48,),

              title: new Text("\n Organ Donor List \n",style : TextStyle(

                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize:21)),             
              onTap: (){
                 Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => new ContactDonorOrg(Org_id))  ,
                      );

              },
            )
          ),
          //           Card (            
          //   shape:new RoundedRectangleBorder(
          //     borderRadius: new BorderRadius.circular(20.0)
          //   ),
            
          //   elevation: 30,
          //   child: new ListTile(
          //     title: new Text("\n Find a particular Organ Donor \n",style : TextStyle(
          //                   fontFamily: 'Montserrat',
          //                   color: Colors.black,
          //                   fontSize:21)),             
          //     onTap: (){ 
          //        Navigator.push(
          //               context,
          //               MaterialPageRoute(builder: (context) => new FindDonor(Org_id))  ,
          //             );
          //     },
          //   )
          // ),

        ]
      )
,
      )
      
      );
  }
}
