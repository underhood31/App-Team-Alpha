import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BloodBankUnits.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class BloodBankPage extends StatefulWidget {

  @override
  _BloodBankPageState createState() => _BloodBankPageState();
  // MyTabsState createState() => new MyTabsState();
}

class _BloodBankPageState extends State<BloodBankPage> with SingleTickerProviderStateMixin {
 static int bpositive=20;
 TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync:this,length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch

    await Future.delayed(Duration(milliseconds: 1000),(){
      items.shuffle();
      new First();
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
            if(mode==LoadStatus.idle){
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        // onLoading: _onLoading,
        // child: ListView.builder(
        //   itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
        //   itemExtent: 100.0,
        //   itemCount: items.length,
        // ),
        
      ),

            new First(),
            // new First()
            // Tab2 ie, Other Utilities
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
  // }