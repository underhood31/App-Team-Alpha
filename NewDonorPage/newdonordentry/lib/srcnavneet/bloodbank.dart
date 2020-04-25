import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'mysql1.dart';
import 'incrementBloodBank.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BloodBankPage extends StatefulWidget {
  static String Bloodbankid;
  static String getBBid()
  {
    return Bloodbankid;
  }
  static void setBBid(String id)
  {
    Bloodbankid=id;
  }
  @override
  _BloodBankPageState createState() => _BloodBankPageState();
  
  // MyTabsState createState() => new MyTabsState();
}

class _BloodBankPageState extends State<BloodBankPage> with SingleTickerProviderStateMixin {
  static List bloodgroups;
  static int Bpositive=0,Bnegative=0,Apositive=0,Anegative=0,Opositive=0,Onegative=0,ABpositive=0,ABnegative=0;
  static String BloodBankid="BBANK_999";
  static Widget initial=SpinKitChasingDots(
    color: Colors.green,
    size: 50.0,
  );
  static Widget pageContent=initial;
  static String alertTitle,alertContent;
  void UpdateValues() async
  {
    var row;
    var db = new Mysql();
      db.getConnection().then((conn)  async{
        String sql = "select Bpositive,Bnegative,Apositive,Anegative,ABpositive,ABnegative,Opositive,Onegative from Blood_Bank where BANK_id=\"$BloodBankid\";"; 
        conn.query(sql).then((results)
        {
          row= results.elementAt(0);        
          Bpositive=row[0];
          Bnegative=row[1];
          Apositive=row[2];
          Anegative=row[3];
          ABpositive=row[4];
          ABnegative=row[5];
          Opositive=row[6];
          Onegative=row[7];
        });
      conn.close();
  }); 
  bloodgroups=["    B+ \n $Bpositive units","    B- \n $Bnegative units","    A+ \n $Apositive units","    A- \n $Anegative units","    AB+ \n $ABpositive units","    AB- \n $ABnegative units","    O+ \n $Opositive units","    O- \n $Onegative units"];
  print(bloodgroups);
  }


   TabController controller;
  @override
  void initState()   {
    //  Future.delayed(Duration(seconds: 3));
    super.initState();
    controller = new TabController(vsync:this,length: 2);
    this.UpdateValues();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      UpdateValues();
    });

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
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
          bottom: TabBar(
            controller: controller,
            indicatorWeight: 5.0,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab( icon:  Icon(Icons.opacity), text: "Units Available",),
              Tab(icon: Icon(Icons.favorite), text: "Other Utilities",),
            ],
          )),
          body:          
           TabBarView(
            controller: controller,
          children: <Widget>[
            // Tab1 ie, Units Available
          SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(idleIcon: const Icon(Icons.autorenew,color: Colors.green,),),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: GridView.builder(        
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: bloodgroups==null?0:bloodgroups.length,
        itemBuilder:(context ,int index )=> Card (
            shape:new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)
            ),
            elevation: 30,
            child: new Container(
              child: Align(alignment: Alignment.center,
              child: new Text(bloodgroups[index],style : TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize:30)),
              
              )
            )
          ),
      )
 
              
      ),
      // Tab2 ie, Other Utilities
      ListView(

        children: <Widget>[
          Card (
            
            shape:new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)
            ),
            
            elevation: 30,
            child: new ListTile(
              title: new Text("\n\tIncrement Units of blood\n",style : TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize:21)),             
              onTap: (){
                 Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => new IncrementBB()),
                      );
                  // Navigator.of(context).pushNamed('/Incrementpage');

              },
            )
          ),
          Card (
            
            shape:new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)
            ),
            
            elevation: 30,
            child: new ListTile(
              title: new Text("\n\tDecrement Units of blood\n",style : TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize:21)),             
              onTap: (){},
            )
          ),
          Card (
            
            
            shape:new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)
            ),
            
            elevation: 30,
            child: new ListTile(
              title: new Text("\n\tTransfer blood units\n",style : TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize:21)),             
              onTap: (){ },
            )
          ),
          Card (
            shape:new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)
            ),            
            elevation: 30,
            child: new ListTile(
              title: new Text("\n\tContact other Banks\n",style : TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize:21)),             
              onTap: (){},
            )
          )

        ]
      )
              ],
            ),
        );
        
    }
}






















  // var id;
  // PatientState(this.id);
  // @override
  // Widget build(BuildContext context)
  // {
  //   return DefaultTabController(
  //     length: 2,
  //     child: Scaffold(
  //       appBar: AppBar(
  //         actions: <Widget>[
  //          IconButton(
  //            icon: Icon(Icons.exit_to_app),
  //            onPressed: (){
  //              print("pressed");
  //            },
  //          )

  //         ],
  //         bottom: TabBar(
            
  //           tabs: <Widget>[
  //             Tab( icon:  Icon(Icons.favorite), text: "Organs",),
  //             Tab(icon: Icon(Icons.opacity), text: "Blood",),
  //           ],
  //         ),
  //         title: Text("Logged In as a Patient"),
  //       ),
  //       body: TabBarView(
  //         children: <Widget>[
  //           //Children for Tab1 ie, Organs
  //           ListView(
  //             children: <Widget>[
  //                Card(
  //                 child: ListTile(
  //                   leading: Icon(Icons.local_hospital,size: 48,),
  //                   title: Text('Check Available Organs'),
  //                   subtitle: Text(
  //                     'Check availability of your Matching organ'
  //                   ),
  //                   onTap: (){
  //                     Navigator.push(context, MaterialPageRoute(builder: (context) => Organ_available(id)),);
  //                   },
  //                   isThreeLine: true,
  //                 ),
  //               ),
  //               Card(
  //                 child: ListTile(
  //                   leading: Icon(Icons.search,size: 48,),
  //                   title: Text('Search for all organisation'),
  //                   subtitle: Text(
  //                     'Search for all the organisation having matching organ'
  //                   ),
  //                   onTap: (){
  //                     Navigator.push(context, MaterialPageRoute(builder: (context) => All_organisation(id)),);
  //                   },
  //                   isThreeLine: true,
  //                 ),
  //               ), `
  //               Card(
  //                 child: ListTile(
  //                   leading: Icon(Icons.view_list,size: 48,),
  //                   title: Text('View Your Details'),
  //                   subtitle: Text(
  //                     'View Personal and Organ Details'
  //                   ),
  //                   onTap: (){
  //                     Navigator.push(context, MaterialPageRoute(builder: (context) => Personal(id)),);
  //                   },
  //                   isThreeLine: true,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           //Children for Tab2 ie, Blood
  //           ListView(
  //             children: <Widget>[
  //               Card(
  //                 child: ListTile(
  //                   leading: Icon(Icons.help,size: 48,),
  //                   title: Text('Available blood groups'),
  //                   subtitle: Text(
  //                     'Check availability of the blood groups and know the location where they are present.'
  //                   ),
  //                   isThreeLine: true,
  //                   onTap: (){
  //                     Navigator.push(context, MaterialPageRoute(builder: (context) => Blood_avialable()),);
  //                   }
  //                 ),
  //               ),
  //               Card(
  //                 child: ListTile(
  //                   leading: Icon(Icons.map,size: 48,),
  //                   title: Text('Blood Banks'),
  //                   subtitle: Text(
  //                     'Find the nearest Blood Bank for donating and recieving blood based upon the PIN code of your area.'
  //                   ),
  //                   isThreeLine: true,
  //                   onTap: (){
  //                     Navigator.push(context, MaterialPageRoute(builder: (context) => Near_bloodbank()),);
  //                   }
  //                 ),
  //               )
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }s