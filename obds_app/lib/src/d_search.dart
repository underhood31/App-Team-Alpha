import 'package:flutter/material.dart';
import 'package:obdsapp/main.dart';
import 'package:string_validator/string_validator.dart';

import 'd_allOrgans.dart';

class TimeStamp{
  int year,month,date,hr,mint,sec;
  static List<String> years = new List<String>();
  static List<String> months = new List<String>();
  static List<String> days = new List<String>();
  static List<String> hrs = new List<String>();
  static List<String> mins = new List<String>();
  TimeStamp(){
    if(years.isEmpty){
      for (var i = 2020; i >= 2000; i--) {
        years.add(i.toString());
      }
      for (var i = 1; i < 12; i++) {
        months.add(i.toString());
      }
      for (var i = 1; i < 31; i++) {
        days.add(i.toString());
      }
      for (var i = 0; i < 23; i++) {
        hrs.add(i.toString());
      }
      for (var i = 0; i < 59; i++) {
        mins.add(i.toString());
      }
    }
  }
  @override
  String toString() {
    return year.toString() + "-" + month.toString().padLeft(2,'0') + "-" + date.toString().padLeft(2,'0') + " " + hr.toString().padLeft(2,'0') + ":" + mint.toString().padLeft(2,'0') + sec.toString().padLeft(2,'0');
  }
}

class SearchOrgans extends StatefulWidget{
  @override
  SearchOrganState createState() => SearchOrganState();
}

class SearchOrganState extends State<SearchOrgans>{

  String organ;
  List<Widget> organForm=new List();
  final _formKey = GlobalKey<FormState>();
   
  @override
  void initState() {
    organForm.add(Text("Select any organ", textAlign: TextAlign.center, style: TextStyle(color: Colors.red),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Search Compatible Organs") ,
        
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(50.0,10.0,50.0,10.0),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Text(
                "Fill the form to search for organs",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),  
              ),
              Row(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Select Organ to search in: "),
                   DropdownButton(
                      value: organ,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                        color: Colors.deepPurple
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) async {
                       
                        setState(() {
                          if(newValue=="Cornea"){
                            print("TRUE");
                            organForm=new List();
                            String vale;
                            Widget tm2 = Form(
                              key: _formKey,
                            
                              child: Column(
                                children: <Widget>[
                                // Divider(
                                //   color: Colors.grey,
                                //   thickness: 2,
                                // ),
                                 SizedBox(height: 50.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "How old data do you want to see?(In days)",
                                  ),
                                   textAlign: TextAlign.center,
                                   onChanged: (String value){
                                    vale=value;
                                   },
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty || !isNumeric(value) ){
                                      return 'Invalid entry, only numbers allowed';
                                    }
                                    return null;
                                  },
                                  
                                ),
                                 SizedBox(height: 24.0),
                                RaisedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, otherwise false.
                                    if (_formKey.currentState.validate()) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => AllOrgan("select * from Cornea where  TIMESTAMPDIFF(DAY,`Procurement_Timestamp`,CURRENT_TIMESTAMP())< $vale and DON_id is not null;",true)),
                                      );
                                    }
                                  },
                                  child: Text('Submit'),
                                ),
                                
                              ]
                            )
                          );  
                            organForm.add(tm2);
                          }
                          else if(newValue=="Heart"){
                             organForm=new List();
                             String minWt, maxWt;
                             Widget tm2 = Form(
                              key: _formKey,
                            
                              child: Column(
                                children: <Widget>[
                                 SizedBox(height: 50.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Enter minimum  weight of heart(grams)"
                                  ),
                                   textAlign: TextAlign.center,
                                   onChanged: (String value){
                                    minWt=value;
                                   },
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty || !isFloat(value) ){
                                      return 'Invalid entry, only numbers allowed';
                                    }
                                    return null;
                                  },
                                  
                                ),
                                 SizedBox(height: 24.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Enter maximum weight of heart(grams)"
                                  ),
                                   textAlign: TextAlign.center,
                                   onChanged: (String value){
                                    maxWt=value;
                                   },
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty || !isFloat(value) ){
                                      return 'Invalid entry, only numbers allowed';
                                    }
                                    return null;
                                  },
                                ),
                                 SizedBox(height: 24.0),
                                RaisedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, otherwise false.
                                    if (_formKey.currentState.validate()) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => AllOrgan("select * from Heart where  Weight between $minWt and $maxWt and DON_id is not null;",true)),
                                      );
                                    }
                                  },
                                  child: Text('Submit'),
                                ),
                                 
                              ]
                            )
                          );  
                          organForm.add(tm2);
                            
                             
                          }
                          else if(newValue=="Kidney"){
                              organForm=new List();
                              String minPRA, maxPRA;
                              Widget tm2 = Form(
                                key: _formKey,
                              
                                child: Column(
                                  children: <Widget>[
                                   SizedBox(height: 50.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Enter minimum PRA",
                                    ),
                                    textAlign: TextAlign.center,
                                    onChanged: (String value){
                                      minPRA=value;
                                    },
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value.isEmpty || !isInt(value) ){
                                        return 'Invalid entry, only numbers allowed';
                                      }
                                      return null;
                                    },
                                    
                                  ),
                                   SizedBox(height: 24.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Enter maximum PRA"
                                    ),
                                    textAlign: TextAlign.center,
                                    onChanged: (String value){
                                      maxPRA=value;
                                    },
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value.isEmpty || !isInt(value) ){
                                        return 'Invalid entry, only numbers allowed';
                                      }
                                      return null;
                                    },
                                  ),
                                   SizedBox(height: 24.0),
                                  RaisedButton(
                                    onPressed: () {
                                      // Validate returns true if the form is valid, otherwise false.
                                      if (_formKey.currentState.validate()) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => AllOrgan("select * from Kidney where  PRA between $minPRA and $maxPRA and DON_id is not null;",true)),
                                        );
                                      }
                                    },
                                    child: Text('Submit'),
                                  ),
                                  
                                ]
                              )
                            );  
                            organForm.add(tm2);
                
                          }
                          else if(newValue=="Liver"){
                              organForm=new List();
                              String minWt, maxWt;
                              Widget tm2 = Form(
                                key: _formKey,
                              
                                child: Column(
                                  children: <Widget>[
                                  SizedBox(height: 50.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Enter minimum  weight of Liver(grams)"
                                    ),
                                    textAlign: TextAlign.center,
                                    onChanged: (String value){
                                      minWt=value;
                                    },
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value.isEmpty || !isFloat(value) ){
                                        return 'Invalid entry, only numbers allowed';
                                      }
                                      return null;
                                    },
                                    
                                  ),
                                   SizedBox(height: 24.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Enter maximum weight of Liver(grams)"
                                    ),
                                    textAlign: TextAlign.center,
                                    onChanged: (String value){
                                      maxWt=value;
                                    },
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value.isEmpty || !isFloat(value) ){
                                        return 'Invalid entry, only numbers allowed';
                                      }
                                      return null;
                                    },
                                  ),
                                   SizedBox(height: 24.0),
                                  RaisedButton(
                                    onPressed: () {
                                      // Validate returns true if the form is valid, otherwise false.
                                      if (_formKey.currentState.validate()) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => AllOrgan("select * from Liver where  Weight between $minWt and $maxWt and DON_id is not null;",true)),
                                        );
                                      }
                                    },
                                    child: Text('Submit'),
                                  ),
                                 
                                ]
                              )
                            );  
                            organForm.add(tm2);
                          }
                          else if(newValue=="Lung"){
                            organForm=new List();
                             String minAge, maxAge, minSize, maxSize, minSmoke, maxSmoke;
                             Widget tm2 = Form(
                              key: _formKey,
                            
                              child: Column(
                                children: <Widget>[
                                SizedBox(height: 50.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Enter minimum Age of Donor in Years"
                                  ),
                                   textAlign: TextAlign.center,
                                   onChanged: (String value){
                                    minAge=value;
                                   },
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty || !isInt(value) ){
                                      return 'Invalid entry, only numbers allowed';
                                    }
                                    return null;
                                  },
                                  
                                ),
                                 SizedBox(height: 24.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Enter maximum Age of Donor in Years"
                                  ),
                                   textAlign: TextAlign.center,
                                   onChanged: (String value){
                                    maxAge=value;
                                   },
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty || !isFloat(value) ){
                                      return 'Invalid entry, only numbers allowed';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 24.0),
                                
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Enter minimum Size of Lungs"
                                  ),
                                   textAlign: TextAlign.center,
                                   onChanged: (String value){
                                    minSize=value;
                                   },
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty || !isInt(value) ){
                                      return 'Invalid entry, only numbers allowed';
                                    }
                                    return null;
                                  },
                                  
                                ),
                                 SizedBox(height: 24.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                     labelText: "Enter maximum Size of Lungs"
                                  ),
                                   textAlign: TextAlign.center,
                                   onChanged: (String value){
                                    maxSize=value;
                                   },
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty || !isFloat(value) ){
                                      return 'Invalid entry, only numbers allowed';
                                    }
                                    return null;
                                  },
                                ),
                                 SizedBox(height: 24.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Enter maximum smoking years"
                                  ),
                                   textAlign: TextAlign.center,
                                   onChanged: (String value){
                                    maxSmoke=value;
                                   },
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty || !isFloat(value) ){
                                      return 'Invalid entry, only numbers allowed';
                                    }
                                    return null;
                                  },
                                ),
                                 SizedBox(height: 24.0),
                                RaisedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, otherwise false.
                                    if (_formKey.currentState.validate()) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => AllOrgan("select * from Lung where Age between $minAge and $maxAge and Size between $minSize and $maxSize and Smoking_History < $maxSmoke and DON_id is not null;",true)),
                                      );
                                    }
                                  },
                                  child: Text('Submit'),
                                ),
                                
                              ]
                            )
                             );
                             organForm.add(tm2);
                          }
                          else if(newValue=="Pancreas"){
                            organForm=new List();
                              String minOPTN, maxOPTN;
                              Widget tm2 = Form(
                                key: _formKey,
                              
                                child: Column(
                                  children: <Widget>[
                                   SizedBox(height: 50.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Enter minimum OPTN",
                                    ),
                                    textAlign: TextAlign.center,
                                    onChanged: (String value){
                                      minOPTN=value;
                                    },
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value.isEmpty || !isFloat(value) ){
                                        return 'Invalid entry, only numbers allowed';
                                      }
                                      return null;
                                    },
                                    
                                  ),
                                   SizedBox(height: 24.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Enter maximum OPTN"
                                    ),
                                    textAlign: TextAlign.center,
                                    onChanged: (String value){
                                      maxOPTN=value;
                                    },
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value.isEmpty || !isFloat(value) ){
                                        return 'Invalid entry, only numbers allowed';
                                      }
                                      return null;
                                    },
                                  ),
                                   SizedBox(height: 24.0),
                                  RaisedButton(
                                    onPressed: () {
                                      // Validate returns true if the form is valid, otherwise false.
                                      if (_formKey.currentState.validate()) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => AllOrgan("select * from Pancreas where  OPTN between $minOPTN and $maxOPTN and DON_id is not null;",true)),
                                        );
                                      }
                                    },
                                    child: Text('Submit'),
                                  ),
                                 
                                ]
                              )
                            );  
                            organForm.add(tm2);
                          }
                          organ = newValue;
                        });
                      },
                      items: organList.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                        
                    )
                      
                ],
              ),
            ]+organForm,
          ),
        ),
      )
        
      //   child: (
          
      //     children: <Widget>[
      //       Text(
              
      //         "Fill the form to search for organs",
      //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //         textAlign: TextAlign.center,
              
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: <Widget>[
      //           Column(
      //             children: <Widget>[
      //                 Text(
      //                   "Select Organ to search in: "
      //                 ),
              
      //             ],
      //           ),
      //           Column(
      //             children: <Widget>[
      //               DropdownButton(
      //                 value: organ,
      //                 icon: Icon(Icons.arrow_downward),
      //                 iconSize: 24,
      //                 elevation: 16,
      //                 style: TextStyle(
      //                   color: Colors.deepPurple
      //                 ),
      //                 underline: Container(
      //                   height: 2,
      //                   color: Colors.deepPurpleAccent,
      //                 ),
      //                 onChanged: (String newValue) async {
                       
      //                   setState(() {
      //                     if(newValue=="Cornea"){
      //                       print("TRUE");
      //                       organForm = Row(
      //                         children: <Widget>[
      //                               new Flexible(
      //                             child: new TextField(
      //                               decoration: const InputDecoration(
      //                                 helperText: "Enter App ID",
      //                                 contentPadding:  EdgeInsets.fromLTRB(50.0,10.0,50.0,10.0),
      //                               ),
      //                               style: Theme.of(context).textTheme.body1,
      //                             ),
      //                           ),
      //                           new Flexible(
      //                             child: new TextField(
      //                               decoration: const InputDecoration(
      //                                 helperText: "Enter App ID",
      //                                 contentPadding:  EdgeInsets.fromLTRB(50.0,10.0,50.0,10.0),
      //                               ),
      //                               style: Theme.of(context).textTheme.body1,
      //                             ),
      //                           ),
      //                           Column(
      //                             children: <Widget>[
      //                               Text()
      //                             ],
      //                           )
      //                         ],
      //                       );
      //                     }
      //                     else if(newValue=="Heart"){
                            
      //                     }
      //                     else if(newValue=="Kidney"){
                            
      //                     }
      //                     else if(newValue=="Liver"){
                            
      //                     }
      //                     else if(newValue=="Lung"){
                            
      //                     }
      //                     else if(newValue=="Pancreas"){
                            
      //                     }
      //                     organ = newValue;
      //                   });
      //                 },
      //                 items: organList.map((String value) {
      //                   return new DropdownMenuItem<String>(
      //                     value: value,
      //                     child: new Text(value),
      //                   );
      //                 }).toList(),
                        
      //               )
      //             ],
      //           )
      //         ],
      //       ),
      //       // Row(
      //       //   crossAxisAlignment: CrossAxisAlignment.center,
      //       //   mainAxisAlignment: MainAxisAlignment.center,
      //       //   children: <Widget>[
      //       //      this.organForm,
                 
      //       //   ],
      //       // ),
      //      this.organForm

      //     ]
      //   ),
      // ),
    );
  }
  
}
