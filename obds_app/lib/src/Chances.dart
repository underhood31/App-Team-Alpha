import 'package:flutter/material.dart';
import '../main.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/percent_indicator.dart';
class Chances extends StatefulWidget
{
  var id;
  Chances(this.id);
  @override
  ChancesState createState() => ChancesState(id);
}
class ChancesState extends State<Chances>
{
  var id;
  Results data;
  static Widget initial=SpinKitChasingDots(
    color: Colors.green,
    size: 50.0,
  );
  double binomial(int n,int k)
  {
    if(k==0 || n==0)
    {
      return 1;
    }
    if(k>n)
    {
      return binomial(k, n);
    }
    double ans=1;
    for (int i = 1; i <= k; ++i)
    {
      ans = ans * (n - k + i) / i; 
    }
    return ans;
  }
  static Widget pageContent=initial;
  static Widget afterLoad;
  void getData() async{
    print("Hello");
    var conn=await MySqlConnection.connect(sql_cred); 
    print("ok got it");
    var blood;
    var data;
    var data2;
    try
    {
      var result=await conn.query("Select blood_group from Patient where pat_id= ?",[id]);
      for(var row in result)
      {
        blood=row[0];
      }
      print(blood);
      var table;
      result=await conn.query('select Organ from Patients_Organ where pat_id= ?',[id]);
      for(var row in result)
      {
        table=row[0];
      }
      String q="select Blood_Group,count(organ_id) from "+table+" join Organ_Donor using (Don_id) group by(blood_group)";
      data=await conn.query(q);
      q="select Blood_Group,count(organ_id) from "+table+" join Patient using (Pat_id) group by(blood_group)";
      data2=await conn.query(q);
    }
    catch(e)
    {
      print("Exception");
    }
    await conn.close();
    var x=0,y=0,z=0,w=0,a=0,b=0,c=0,d=0;
    for(var i in data2)
    {
      if(i[0]=='A-' || i[0]=='A+')
      {
        x+=i[1];
      }
      else if(i[0]=='B+'||i[0]=='B-')
      {
        y+=i[1];    
      }
      else if(i[0]=="AB+"||i[0]=="AB-")
      {
        z+=i[1];
      }
      else
      {
        w+=i[1];
      }
    }
    print(x);
    print(y);
    print(z);
    print(w);
    for(var i in data)
    {
      if(i[0]=='A-' || i[0]=='A+')
      {
        a+=i[1];
      }
      else if(i[0]=='B+'||i[0]=='B-')
      {
        b+=i[1];    
      }
      else if(i[0]=="AB+"||i[0]=="AB-")
      {
        c+=i[1];
      }
      else
      {
        d+=i[1];
      }
    }
    a=a*4~/5;
    b=b*4~/5;
    c=c*4~/5;
    d=d*4~/5;// There are 80% chance of organ acceptance, taking that into account;
    print(a);
    print(b);
    print(c);
    print(d);
    double A=binomial(x, a+d);
    double B=binomial(y, b+d);
    double AB=binomial(z, a+b+c+d);
    double O=binomial(w, d);
    print(A);
    print(B);
    print(AB);
    print(O);
    double total=A*B*AB*O;
    if(blood=='A-' || blood=='A+')
    {
      A=binomial(x-1,a+d-1);
    }
    else if(blood=='B+'||blood=='B-')
    {
      B=binomial(y-1,b+d-1);  
    }
    else if(blood=="AB+"||blood=="AB-")
    {
      AB=binomial(z-1,a+b+c+d-1);
    }
    else
    {
      O=binomial(w-1,d-1);
    }
    double possible=A*B*AB*O;
    double p=(possible/(total))*100;
    afterLoad=Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
        children: <Widget>
        [
          Container(
            padding: EdgeInsets.only(top: 150.0, left: 20.0, right: 20.0),
            child:Text("The Probablity is", style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),)
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0, left: 100.0, right:100.0),
            child:CircularPercentIndicator(
                  radius: 140.0,
                  lineWidth: 10.0,
                  percent: p/100,
                  center: new Text("${p.toStringAsFixed(2)}%",style: TextStyle(fontSize: 30),),
                  progressColor: Colors.green,
                )
          ),
        ]
    );
    setState(() {
      pageContent=afterLoad;
    });
}

  @override
  void initState() {
    pageContent=initial;
    getData();
  }
  ChancesState(this.id);
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Probablity"),
      ),
      body:Center(child: pageContent,)
    );
  }
}