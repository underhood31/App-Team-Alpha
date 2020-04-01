import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:obdsapp/main.dart';

class LoginPage extends StatefulWidget {
  
  static String tag = "Login-Page";
  static var setting = new ConnectionSettings(
      host: '208.91.198.24',
      port: 3306,
      user: '',
      password: '',
      db: 'protsuls_AppData'
    );

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  static String errorMessage = '';
  static var icon = Icons.visibility; 
  static bool _obscureText = true;
  //Defining logo
  final logo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 96.0,
      child: Image.asset('assets/logo.png'),
    ),
  );
  
  //Defining error message


  //Defining e-mail field
  final uname = TextField(
    keyboardType: TextInputType.text,
    autofocus: false,
    onChanged: (String s){
      LoginPage.setting.user = "protsuls_" + s;
    },
    decoration: InputDecoration(
      hintText: 'Enter your Username',
      contentPadding: EdgeInsets.fromLTRB(20.0,10.0,20.0,10.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32.0)
      ),
    ),    
    
  );

  //defining password field
  // final pass = 


  @override
  build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(right: 24.0, left: 24.0),
          children: <Widget>[
            logo,
            
            SizedBox(height: 48.0),
            //Error text field
            Text(
              "$errorMessage",
              style: TextStyle(fontSize: 12, color: Colors.red),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 8.0),
            
            uname,
            
            SizedBox(height: 8.0),
            
            Container(
              child: Column(
                children: <Widget>[
                      TextField(      
                    autofocus: false,
                    obscureText: _obscureText,
                    onChanged: (String s){
                      LoginPage.setting.password = s;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your Password',
                      contentPadding: EdgeInsets.fromLTRB(20.0,10.0,20.0,10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)
                      ),
                    ),
                        
                  ),

                  FlatButton(
                    onPressed: ((){
                      setState(() {
                        _obscureText = !_obscureText;
                        if(_obscureText){
                          LoginPageState.icon = Icons.visibility;
                        }
                        else{
                          LoginPageState.icon = Icons.visibility_off;
                          
                        }
                      });
                    }),
                    child: Icon(LoginPageState.icon),
                  )    
                ],
              ),
            ),
            
            SizedBox(height: 24.0),
            
            //Login Button
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Material(
                borderRadius: BorderRadius.circular(30),
                shadowColor: Colors.orange,
                elevation: 5.0,
                color: Colors.orange,
                child: MaterialButton(
                  minWidth: 200,
                  height: 42,
                  onPressed: () {
                    setState(() {
                      if(LoginPage.setting.password!='' && LoginPage.setting.user!=''){
                        logIn();
                      }
                      else if(LoginPage.setting.password=='' ||  LoginPage.setting.user!=''){
                          errorMessage="Username or password is not provided";
                          
                           print('$errorMessage');
                      }  
                     });
                    
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  logIn() async{
    sql_cred = new ConnectionSettings();
    sql_cred=LoginPage.setting;
    bool credCorrectness = await checkConnection();
    print("The variable is $credCorrectness");
    
      // Navigator.push(
      //         context,                                    
      //           MaterialPageRoute(builder: (context) => FunctionsPage(credCorrectness),
      //     )
      // );
  }
    
   Future<bool> checkConnection() async {
    
   
    
    var query="SELECT Roll_no, name FROM ProtData;";
      
      try{
        var conn = await MySqlConnection.connect(sql_cred);
        var results = await conn.query(query);
        await conn.close();
        return Future.value(true);

      } catch(e){
        print("Exception thrown $e");
        return Future.value(false);
      }
      
  
  }
   
} 