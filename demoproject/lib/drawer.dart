import 'package:demoproject/accountlink.dart';
import 'package:demoproject/afteraccountadd.dart';
import 'package:demoproject/chit.dart';
import 'package:demoproject/ip.dart';
import 'package:demoproject/kyc.dart';
import 'package:demoproject/loan.dart';
import 'package:demoproject/news.dart';
import 'package:demoproject/progress.dart';
import 'package:demoproject/userdash.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Mydrawer extends StatefulWidget implements PreferredSizeWidget {
  
   Mydrawer({super.key});

  @override
  State<Mydrawer> createState() => _MydrawerState();
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _MydrawerState extends State<Mydrawer> {
//  final storage = const FlutterSecureStorage();
  String? status;
   String? mail;
    String? name;
  final storage = new FlutterSecureStorage();
    // String? name;

    //   String? type;
  @override
  void initState() {
    userdetails();
    super.initState();
    // getaccountstatus();
   

    // You can add any initialization code here
  }

  userdetails() async{
    final email = await storage.read(key: 'mail');
  
    final phone = await storage.read(key: 'phone');
    setState(() {
      mail = email!=null ? email :"";
    });
     setState(() {
      name = phone!=null ? phone : "";
    });
  }

getaccountstatus() async{
  print("entered get account status");
  final token = await storage.read(key: 'token');
    // final token = await storage.read(key: 'accno');
    // if( await storage.containsKey(key: 'accno')){
    //   status="true";

    // }
    // else{
    //   status="false";
    // }
    // return;
  //  var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/accountaddcheck/'));
   var request = http.MultipartRequest('POST', Uri.parse(ip+'api/accountaddcheck/'));
   final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': '$token',
    };
    request.headers.addAll(headers);
    //  request.fields['body'] = "nothing";
     var response = await request.send();
    if (response.statusCode == 200) {
        Navigator.push(context,
      MaterialPageRoute(builder: (context) => Afteraccountadd()));
        
    }
   
   
      
    
    else if(response.statusCode ==400){
         Navigator.push(context,
      MaterialPageRoute(builder: (context) => Accountlink()));
      
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Network error occured....')),
    );
    }

}

getloaninfo() async{
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => Loantab()));
}

getchitinfo() async{
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => Chit()));
}

  // accountdirection(BuildContext ctx) async{
  //        Navigator.push(ctx,
  //     MaterialPageRoute(builder: (context) => Accountlink()));

  // }
  gotokyc() async{
    final accNum= await storage.read(key: 'accno');
 for(int i=0;i<100;i=i+1)
 {

 }
if(accNum != null){
  // print(accountno);
  print("hai");
   Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Kyc()),
              );

}

      else{

         ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please link your account with app before completing kyc....')),
    );
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    UserHome()), (Route<dynamic> route) => false);
      
 }
      //    Navigator.push(context,
      // MaterialPageRoute(builder: (context) => Kyc()));

  }

gotobalance() async{
   final accNum= await storage.read(key: 'accno');
 for(int i=0;i<100;i=i+1)
 {

 }
if(accNum != null){
       Navigator.push(context,
      MaterialPageRoute(builder: (context) => SplashScreen()));
}
 else{

         ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please link your account with app before checking account balance....')),
    );
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    UserHome()), (Route<dynamic> route) => false);
      
 }

}
  // @override
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("$name"), 
              accountEmail: Text("$mail"),
              // currentAccountPicture: CircleAvatar(
              //   // backgroundImage: NetworkImage(
              //   //     "https://www.pexels.com/photo/india-rupee-banknote-904735/"),
              //   // backgroundImage: AssetImage('assets/images/drawer.jpg'),
              // ),
              decoration: BoxDecoration(
                image: DecorationImage(

                  image:  AssetImage('assets/images/drawer.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
             
            ),
            ListTile(
              
              leading: Icon(Icons.person,color: Colors.blue),
              title: Text("Account",style: TextStyle(fontStyle: FontStyle.italic)),
              onTap: () {
                 getaccountstatus();
      //           Navigator.push(context,
      // MaterialPageRoute(builder: (context) => Accountlink()));
              },
            ),
            ListTile(
              leading: Icon(Icons.money,color: Colors.green),
              title: Text("Loans",style: TextStyle(fontStyle: FontStyle.italic)),
              onTap: () {
                getloaninfo();
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money_outlined,color: Colors.yellowAccent),
              title: Text("Chits",style: TextStyle(fontStyle: FontStyle.italic)),
              onTap: () {
                 getchitinfo();
              },
            ),
            ListTile(
              leading: Icon(Icons.gamepad_outlined,color: Colors.pinkAccent),
              title: Text("Auction",style: TextStyle(fontStyle: FontStyle.italic)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.document_scanner_rounded,color: Colors.deepPurple),
              title: Text("KYC management",style: TextStyle(fontStyle: FontStyle.italic)),
              onTap: () { gotokyc(); },
            ),
            ListTile(
              leading: Icon(Icons.new_releases,color: Colors.cyanAccent),
              title: Text("News",style: TextStyle(fontStyle: FontStyle.italic)),
              onTap: () {
                  Navigator.push(context,
      MaterialPageRoute(builder: (context) => News()));
              },
              
            ),
            ListTile(
              leading: Icon(Icons.balance_outlined,color: Colors.blueGrey),
              title: Text("Balance enquiry",style: TextStyle(fontStyle: FontStyle.italic)),
              onTap: () {
                gotobalance();
              },
            )
          ],
        ),
      ) ;
  }

 @override
  Size get preferredSize => Size.fromHeight(56.0);
}