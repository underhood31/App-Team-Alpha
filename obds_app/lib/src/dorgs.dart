import 'package:flutter/material.dart';
import 'mysql1.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class ContactOG extends StatefulWidget
{
  String organisationid;
  ContactOG(this.organisationid);
  @override
  ContactOGState createState() => ContactOGState(organisationid);

}
class ContactOGState extends State<ContactOG>
{
  String organisationid;
  ContactOGState(this.organisationid);
  static Widget currentPage,afterloadPage;
  static Widget initialPage=SpinKitChasingDots(
    color: Colors.green,
    size: 50.0,
  );
  void updatepage() async{
    await getdata();
  }
  void getdata() async {
    var row;
    var db = new Mysql();
    await db.getConnection().then((conn)  async{
      print(organisationid);
      String sql = "select A.Name, A.Contact, A.Address from Organisation as A Where A.ORG_id in (Select C.ORG_id from Donors_Organ as B, Organisation_Org_Accepted as C Where B.DON_id = \'"+organisationid+"\' and B.Organ = C.Organ);";
      await conn.query(sql).then((results)
      {
        var allFields = new List();
        var relevantFields = new List();
        var relevantData = new List();
        for(var i in results){
          var k = i.fields;
          for (var j in k.keys)
            allFields.add(j);
          break;
        }
        print("Del3");
        print(allFields);
        print("\n");

        for(int k=0; k<allFields.length ;  ++k ){
          relevantFields.add(allFields[k]);
        }
        print("Del2");
        print(relevantFields);
        print("\n");

        for (var i in results) {
          var lst = new List();
          for(int k=0; k<allFields.length ;  ++k ){
            lst.add(i[k]);
          }
          relevantData.add(lst);
        }

        print("Del1");
        print(relevantData);
        print("\n");

        List<Widget> OrganCards = new List<Widget>();
        int num=0;
        for (var i in relevantData){
          num+=1;
          String dd="";
          int k=1;
          for(; k<relevantFields.length; ++k){
            dd+="${relevantFields[k]}: ${i[k]}";
          }

          Widget temp = Card(
              child: ListTile(
                leading: Text(
                  "$num",
                  style: TextStyle(fontSize: 20),
                ),
                title: Text(
                    "${relevantFields[0]}: ${i[0]}"
                ),
                subtitle: Text(
                    dd
                ),
              )
          );
          OrganCards.add(temp);
        }

        afterloadPage = ListView(
          children: OrganCards,
        );
        setState(() {
          currentPage = afterloadPage;

        });

      });
      conn.close();
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPage=initialPage;
    updatepage();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.green, title: Text("Find Organisations")
        ),
        body: currentPage

    );
  }

}