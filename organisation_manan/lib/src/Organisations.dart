import 'package:flutter/material.dart';
import './Details.dart';
import './Inactive.dart';
class Organisation extends StatefulWidget
{
  var id;
  Organisation(this.id);
  @override
  OrganisationState createState() => OrganisationState(id);
}
class OrganisationState extends State<Organisation>
{
  var id;
  OrganisationState(this.id);
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
           IconButton(
             icon: Icon(Icons.exit_to_app),
             onPressed: (){
               print("pressed");
             },
           )

          ],
          title: Text("Logged In as a Patient"),
        ),
        body:  ListView(
              children: <Widget>[
                 Card(
                  child: ListTile(
                    leading: Icon(Icons.add,size: 48,),
                    title: Text('Add Donor to Verified Donor'),
                    subtitle: Text(
                      'Add an Donor to the verified donor list'
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Details(id)),);
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Inactive(id)),);
                    },
                    isThreeLine: true,
                  ),
                ),
              ],
            ),
            //Children for Tab2 ie, Blood
    );
  }
}