import 'dart:math';
import 'package:flutter/material.dart';
import 'mysql1.dart';
import 'reportDeath.dart';
import 'dorgs.dart';


class DonorPage extends StatefulWidget {

  String id;
  DonorPage(this.id);
  @override
  _DonorPageState createState() => _DonorPageState(id);

}

class _DonorPageState extends State<DonorPage>  {

  String id ;
  _DonorPageState(this.id);

  Mysql sql = Mysql();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: false,
      appBar: AppBar(centerTitle: true,leading: Text(""),backgroundColor: Colors.green, title: Text("Logged in as Organ Donor"),
      actions: <Widget>[IconButton(icon: Icon(Icons.exit_to_app),
        onPressed: (){
          Navigator.pushReplacementNamed(context, "/logout");
        }
       ,),],),

      body: new Stack(fit: StackFit.expand, children: <Widget>[
        // new Image(image: AssetImage('Assets/jc-gellidon-9Eb-bpTXglM-unsplash.jpg'),fit: BoxFit.fitWidth, color: Colors.black87,
        // colorBlendMode: BlendMode.luminosity),
        ListView(children: <Widget>[new Padding(padding: EdgeInsets.all(5)),Card(color: Colors.white ,child : ListTile(leading: Icon(Icons.add_alert, size : 48),title: Text("Report Pick Up"),subtitle: Text("Reporting death of donor and pick up of organ"), onTap: () => {Navigator.push(
            context, MaterialPageRoute(builder: (context) => new reportDeath(id)),)}, isThreeLine: true,)),
                                    Card(color: Colors.white, child: ListTile(leading: Icon(Icons.apps, size : 48),title: Text("Find Organisations"),subtitle: Text("List of organisations that accept your organ"), onTap: () =>
                                    {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => new ContactOG(id)),)
                                    }, isThreeLine: true,),),],)
        ],
      ),
        floatingActionButton: FloatingActionButton(
            child : Icon(Icons.access_time, color: Colors.black,size: 30,),backgroundColor: Colors.green,splashColor: Colors.green[900],
            onPressed: () async {

              var res;
              var db = Mysql();
              db.getConnection().then((conn) async
                  {
                    String str = "Select Last_check_up_date from Organ_Donor where DON_id<>\'$id\';";
                    await Future.delayed(Duration(seconds: 1), ()
                    {
                        conn.query(str).then((results)
                        {
                          res = results.elementAt(0).elementAt(0);
                          String str = checkUp(res);
                          return showDialog(context: context, builder: (context)
                          {
                            return AlertDialog(content: Text("Last Check Up Date : \n$res\n\nNext Check Up :\n"+str));
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

String checkUp(var res)
{
  String resp = res.toString();
  String res1 = resp.substring(0,5);
  String res4 = resp.substring(10);

  String ress2 = resp.substring(5,7);
  var m = int.parse(ress2);

  String ress3 = resp.substring(8,10);
  var n = int.parse(ress3);

  var rng = new Random();
  var i = 1+ rng.nextInt(12);
  var j = 1+ rng.nextInt(30);

  if (m>i)
    {
      res1 = res1.substring(0,3)+"1"+"-";
    }

  String res2 = i.toString();
  if (res2.length == 1)
    {
      res2 = '0'+res2;
    }

  String res3 = j.toString();
  if (res3.length == 1)
    {
      res3 = '0'+res3;
    }

  String resv = res1+res2+"-"+res3+res4;
  print(resv);

  return resv;
}
