import 'package:flutter/material.dart';
import 'mysql1.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class TransferBB extends StatefulWidget
{
   @override
  TransferBBState createState() => TransferBBState();
 
}
class TransferBBState extends State<TransferBB>
{
  static Widget initialPage=SpinKitChasingDots(
    color: Colors.green,
    size: 50.0,
  );
  static Widget currentPage,afterloadPage;
  void updatepage() async{

  }


  @override
  void initState() {
    super.initState();
    currentPage=initialPage;
    updatepage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.green,),
    body: currentPage,
    
    );


  }

}