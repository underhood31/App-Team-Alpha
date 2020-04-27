// import 'package:flutter/material.dart';
// import 'mysql1.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';

// class FindDonor extends StatefulWidget
// {
//   String organizationid;
//   FindDonor(this.organizationid);
//    @override
//   FindDonorState createState() => FindDonorState(organizationid);
 
// }
// class FindDonorState extends State<FindDonor>
// {
//   String organizationid;
//   static final NameController=new TextEditingController() ;
//   static final AgeController=new TextEditingController() ;
//   static final PincodeController=new TextEditingController() ;
//   static final ContactController=new TextEditingController() ;
//   static final OrganController=new TextEditingController() ;
//   static final BloodGroupController=new TextEditingController() ;

//   // static bool NameCheckBox=false,  AgeCheckBox=false,  PincodeCheckBox=false,  ContactCheckBox=false,  OrganCheckBox=false,  BloodGroupCheckBox=false,DONidcheckbox=false;
//   FindDonorState(this.organizationid);
//   static Widget currentPage,afterloadPage;
//   static Widget initialPage=SpinKitChasingDots(
//     color: Colors.green,
//     size: 50.0,
//   );

//   void getdata() async {
//     var row;
//      var db = new Mysql();
//       await db.getConnection().then((conn)  async{
//         String sql = "select Organ_Donor.Name,Organ_Donor.Age,Donors_Organ.Organ,Organ_Donor.Contact,Organ_Donor.Address,Organ_Donor.pincode from Organ_Donor Inner join Donors_Organ on Organ_Donor.DON_id=Donors_Organ.DON_id and Organ_Donor.ORG_id=\"$organizationid\";"; 
//         await conn.query(sql).then((results)
//         {
//           var allFields = new List();
//           var relevantFields = new List();
//           var relevantData = new List();
//           if(results.length==0)
//           {
//               afterloadPage=ListView(
//               children: <Widget>[
//                 Card(
//                   child: ListTile(
//                     title: Text(
//                       "No data found!!",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 25),
//                     ),
//                   ),
//                 )
//               ],
//             );

//           setState(() {
//             currentPage = afterloadPage;

//           });


//           }
//           else
//           {

//           }
//           setState(() {
//             currentPage = afterloadPage;

//           });


//           }
//         });
//       conn.close();
//   });   

//   }

  
//   void updatepage() async
//   {
//     // await getdata();
//     afterloadPage=      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
//             Widget>[
//               Container(
//                 child: Stack(
//                   children: <Widget>[
//                     Container(
//                     padding: EdgeInsets.only(top: 4.0, left: 20.0, right: 20.0),
//                     child: Text(
//                       'Enter only those values by which you want to search a Donor',
//                     style:
//                         TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height:10),
//             Row(              
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                         Text(
//                             'Name',
//                             style: TextStyle(fontSize: 20.0,fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(width: 5.0), 
//                           Container(
//                             width:100,
//                             child:TextField(
//                               controller: NameController,
//                               decoration: InputDecoration(
//                                   labelText: 'Name',
//                                   labelStyle: TextStyle(
//                                       fontFamily: 'Montserrat',
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.grey),
//                                       focusedBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.green))),
//                   )
//                           )
//                            ]
//                         )



//             ]
//             );
//     setState(() {
//       currentPage=afterloadPage;
//       updatepage();
//     }); 
 
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     currentPage=initialPage;
//     updatepage();

//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//       appBar: AppBar(backgroundColor: Colors.green),
//       body:currentPage
     
      
//       );
//   }

// }