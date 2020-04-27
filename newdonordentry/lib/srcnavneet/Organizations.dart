import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'contactdonorOrganisation.dart';
import 'contactblooddonorOrganisation.dart';
import 'mysql1.dart';

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
    // TODO: implement build
    return Scaffold(appBar: AppBar(          
      backgroundColor:Colors.green,
      title: Text("Logged In as a Blood-Bank "),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: (){
          print("link Go back to login screen");
          },
        )
      ],
      ),
      body:
      Container(
        child:      ListView(

        children: <Widget>[
          Card (
            
            shape:new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)
            ),
            
            elevation: 30,
            child: new ListTile(
              title: new Text("\nVerify New Donor\n",style : TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize:21)),             
              onTap: (){
                //  Navigator.push(
                        // context,
                        // MaterialPageRoute(builder: (context) => new IncrementBB(Bloodbankid)),
                      // );
              },
            )
          ),
          Card (
            
            shape:new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)
            ),
            
            elevation: 30,
            child: new ListTile(
              title: new Text("\nVerify checkup of an old Donor\n",style : TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize:21)),             
              onTap: (){
                      //            Navigator.push(
                      //   context,
                      //   // MaterialPageRoute(builder: (context) => new DecrementBB(Bloodbankid)),
                      // );

              },
            )
          ),
          Card (            
            shape:new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)
            ),
            
            elevation: 30,
            child: new ListTile(
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
            shape:new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)
            ),            
            elevation: 30,
            child: new ListTile(
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
