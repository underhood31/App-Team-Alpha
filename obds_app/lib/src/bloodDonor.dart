import 'package:flutter/material.dart';
import 'mysql1.dart';
import 'mybank.dart';
import 'bloodOrgs.dart';


class bloodDonorPage extends StatefulWidget {

  String id;
  bloodDonorPage(this.id);
  @override
  _bloodDonorPageState createState() => _bloodDonorPageState(id);

}

class _bloodDonorPageState extends State<bloodDonorPage>  {

  String id ;
  _bloodDonorPageState(this.id);

  Mysql sql = Mysql();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(leading: Text(""),backgroundColor: Colors.green, title: Text("Logged in as Blood Donor"),
          actions: <Widget>[IconButton(icon: Icon(Icons.exit_to_app), onPressed:(){Navigator.pushReplacementNamed(context, "/logout");} ,),],),

        body: new Stack(fit: StackFit.expand, children: <Widget>[
         
          ListView(children: <Widget>[new Padding(padding: EdgeInsets.all(5)),Card(color: Colors.white ,child : ListTile(leading: Icon(Icons.opacity, size : 48),title: Text("My Organisation"),subtitle: Text("My registered organisation"), onTap: ()
          {Navigator.push(
            context, MaterialPageRoute(builder: (context) => new ContactMBG(id)),);}, isThreeLine: true,)),
            Card(color: Colors.white, child: ListTile(leading: Icon(Icons.apps, size : 48),title: Text("Find Organisations"),subtitle: Text("List of other organisations where you can donate"), onTap: () =>
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => new ContactBG()),)
            }, isThreeLine: true,),),],)
        ],
        ),
        floatingActionButton: FloatingActionButton(
            child : Icon(Icons.access_time, color: Colors.black,size: 30,),backgroundColor: Colors.green,splashColor: Colors.green[900],
            onPressed: () async {
              var res;
              var res2;
              var db = Mysql();
              db.getConnection().then((conn) async
              {
                String str = "Select Last_Checkup, Last_Donated from Blood_Donor where BLD_id<>\'$id\';";
                await Future.delayed(Duration(seconds: 1), ()
                {
                  conn.query(str).then((results)
                  {
                    res = results.elementAt(0).elementAt(0);
                    res2 = results.elementAt(1).elementAt(0);
                    return showDialog(context: context, builder: (context)
                    {
                      return AlertDialog(content: Text("Last Check Up Date : \n$res\n\nLast Donated on : \n$res2\n"));
                    });
                  });
                });
              }
              );
            }
        )
    );
  }
}