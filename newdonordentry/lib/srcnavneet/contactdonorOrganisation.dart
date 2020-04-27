import 'package:flutter/material.dart';
import 'mysql1.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class ContactDonorOrg extends StatefulWidget
{
  String organizationid;
  ContactDonorOrg(this.organizationid);
   @override
  ContactDonorOrgState createState() => ContactDonorOrgState(organizationid);
 
}
class ContactDonorOrgState extends State<ContactDonorOrg>
{
  String organizationid;
  ContactDonorOrgState(this.organizationid);
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
        String sql = "select Organ_Donor.Name,Organ_Donor.Age,Donors_Organ.Organ,Organ_Donor.Contact,Organ_Donor.Address,Organ_Donor.pincode from Organ_Donor Inner join Donors_Organ on Organ_Donor.DON_id=Donors_Organ.DON_id and Organ_Donor.ORG_id=\"$organizationid\";"; 
        await conn.query(sql).then((results)
        {
          var allFields = new List();
          var relevantFields = new List();
          var relevantData = new List();
          if(results.length==0)
          {
              afterloadPage=ListView(
              children: <Widget>[
                Card(
                  child: ListTile(
                    title: Text(
                      "No data found!!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                )
              ],
            );

          setState(() {
            currentPage = afterloadPage;

          });


          }
          else
          {
              for(var i in results){
                var k = i.fields;
                for (var j in k.keys)
                  allFields.add(j);
                break;
              }
                for(int k=0; k<allFields.length ;  ++k ){
                  relevantFields.add(allFields[k]);
                }
                for (var i in results) {
                    var lst = new List();
                    for(int k=0; k<allFields.length ;  ++k ){
                      lst.add(i[k]);
                    }
                    relevantData.add(lst);
                }
              
          print(relevantData);
          print(relevantFields);
          List<Widget> OrganCards = new List<Widget>();
          int num=0;
          for (var i in relevantData){
            num+=1;
            String dd="";
            int k=1;
            for(; k<relevantFields.length-1; ++k){
              dd+="${relevantFields[k]}: ${i[k]}";
              if(k!=relevantFields.length-2)
              dd+="\n";
              }
            dd+=", ${i[k]}";
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


          }
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
      appBar: AppBar(backgroundColor: Colors.green,
      ),
      body: currentPage

    );
  }
  
}
