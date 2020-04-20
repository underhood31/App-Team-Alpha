import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}
class BloodGroup {
  int id;
  String group;
 
  BloodGroup(this.id, this.group);
 
  static List<BloodGroup> getgroups() {
    return <BloodGroup>[
      BloodGroup(1, 'A+'),
      BloodGroup(2, 'A-'),
      BloodGroup(3, 'B+'),
      BloodGroup(4, 'B-'),
      BloodGroup(5, 'O+'),
      BloodGroup(6, 'O-'),
      BloodGroup(7, 'AB+'),
      BloodGroup(8, 'AB-'),
      BloodGroup(9,'Not sure')

    ];
  }
}

class Organ {
  int id;
  String group;
 
  Organ(this.id, this.group);
 
  static List<Organ> getorgans() {
    return <Organ>[
      Organ(1, 'Cornea'),
      Organ(2, 'Heart'),
      Organ(3, 'Heart'),
      Organ(4, 'Kidney'),
      Organ(5, 'Lung'),
      Organ(6, 'Pancreas'),
      Organ(7,'None')
    ];
  }
}
class _SignupPageState extends State<SignupPage> {


    List<BloodGroup> _groups = BloodGroup.getgroups();
    List<DropdownMenuItem<BloodGroup>> _dropdownMenuItems;
    List<Organ> _organs = Organ.getorgans();
    List<DropdownMenuItem<Organ>> _dropdownMenuorgans;

    Organ _selectedOrgan;
    BloodGroup _selectedBloodGroup;
    bool BloodDonorCheckBox=false;
    bool OrganDonorCheckBox=false;
    final NameController=new TextEditingController();
    final AgeController=new TextEditingController();
    final AddressController=new TextEditingController();
    final PinController=new TextEditingController();
    final PhoneController=new TextEditingController();
    String Name,Age,Address,Pincode,Phone;

  List<DropdownMenuItem<BloodGroup>> buildDropdownMenuItems(List groups) {
    List<DropdownMenuItem<BloodGroup>> items = List();
    for (BloodGroup BloodGroup1 in groups) {
      items.add(
        DropdownMenuItem(
          value: BloodGroup1,
          child: Text(BloodGroup1.group),
        ),
      );
    }
    return items;
  }
  onChangeDropdownItem(BloodGroup selectedBloodGroup) {
  setState(() {
    _selectedBloodGroup = selectedBloodGroup;
    print(_selectedBloodGroup.group);
  });
  }

  List<DropdownMenuItem<Organ>> buildOrganDropdownMenuItems(List groups) {
    List<DropdownMenuItem<Organ>> items = List();
    for (Organ Organ1 in groups) {
      items.add(
        DropdownMenuItem(
          value: Organ1,
          child: Text(Organ1.group),
        ),
      );
    }
    return items;
  }
  onChangeOrganDropdownItem(Organ selectedOrgan) {
  setState(() {
    _selectedOrgan = selectedOrgan;
    print(_selectedOrgan.group);
  });
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
              padding: EdgeInsets.only(top: 4.0, left: 20.0, right: 20.0),
                  child: Text(
                    'Signup',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: NameController,
                    decoration: InputDecoration(
                      hintText: 'Please Enter both First and Last Name',
                        labelText: 'Name',
                      
                        labelStyle: TextStyle(
                          
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: AgeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'You must be atleast 18 years old',
                        labelText: 'Age ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: AddressController,
                    decoration: InputDecoration(
                        hintText: 'House number,Street Name, City,State',

                        labelText: 'Address',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),     
                         Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Flexible(
                                child:TextField(
                                  controller: PinController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration( contentPadding: EdgeInsets.all(10),
                                  hintText: 'XXXXXX',
                                  labelText: 'Pin Code',
                                  labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                                )
                              ),
                              SizedBox(width: 5.0),              
                              new Flexible(
                              child: TextField(
                                controller: PhoneController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration( 
                                  contentPadding: EdgeInsets.all(10),
                                  labelText: 'Phone Number',
                                  hintText: 'XXX-XXX-XXXX',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green)
                                    )
                                  ),
                              )  )          ]
                                        ),
                                  
                  SizedBox(height: 10.0),
                  // TextField(
                  //   decoration: InputDecoration(
                  //       labelText: 'Blood Group',
                  //       labelStyle: TextStyle(
                  //           fontFamily: 'Montserrat',
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.grey),
                  //       focusedBorder: UnderlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.green))),
                  // ),
                              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Blood Group',
                  style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5.0),              
                DropdownButton(
                  value: _selectedBloodGroup,
                items: buildDropdownMenuItems(_groups),
                
                onChanged: onChangeDropdownItem,
                 underline: Container(
                      height: 2,
                       color: Colors.greenAccent,
                      ))]
              ),
                              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                        Text(
                            'Do you want to be a Blood Donor?',
                            style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5.0),              
                                          Checkbox(value:BloodDonorCheckBox,
                            onChanged: (bool value )
                            {setState(() {
                              BloodDonorCheckBox=value;
                            });})
                           ,]
                        ),
                            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                        Text(
                            'Do you want to be a Organ Donor?',
                            style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5.0),              
                                          Checkbox(value:OrganDonorCheckBox,
                            onChanged: (bool value )
                            {setState(() {
                              OrganDonorCheckBox=value;
                            });})
                           ,]
                        ),
                                         Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Organ To Donate',
                  style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5.0),              
                DropdownButton(
                  value: _selectedOrgan,
                items: buildOrganDropdownMenuItems(_organs),
                
                onChanged: onChangeOrganDropdownItem,
                 underline: Container(
                      height: 2,
                       color: Colors.greenAccent,
                      ))]
              ),

                 SizedBox(height: 50.0),
                  Container(
                      height: 40.0,
                      child: new RaisedButton(
                        // borderRadius: BorderRadius.circular(20.0),
                        // shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        // child: GestureDetector(
                          onPressed: () {
                            print("hello");
                            setState(() {
                              Name=NameController.text;
                              Age=AgeController.text;
                              Address=AddressController.text;
                              Pincode=PinController.text;
                              Phone=PhoneController.text;
                              print(Name); 
                              print(Age); 
                              print(Address); 
                              print(Pincode); 
                              print(Phone); 
                              print(OrganDonorCheckBox);
                              print(BloodDonorCheckBox);
                              print(_selectedBloodGroup.group);
                              print(_selectedOrgan.group);
                              NameController.text="";
                              AgeController.text="";
                              AddressController.text="";
                              PinController.text="";
                              PhoneController.text="";
                              OrganDonorCheckBox=false;
                              BloodDonorCheckBox=false;
                              _selectedBloodGroup=null;
                              _selectedOrgan=null;
                            });
                          },
                          child: Center(
                            
                            child: Text(
                              'SIGNUP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        // ),
                      )),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: 
                            Center(
                              child: Text('Go Back',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                        
                        
                      ),
                    ),
                  ),
                ],
              )),
        ]));
  }
}