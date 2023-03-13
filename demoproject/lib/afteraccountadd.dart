import 'dart:convert';

import 'package:demoproject/accountrequest.dart';
import 'package:demoproject/bottomnav.dart';
import 'package:demoproject/drawer.dart';
import 'package:demoproject/home_screen.dart';
import 'package:demoproject/homeelements.dart';
import 'package:demoproject/userdash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;



class Afteraccountadd extends StatefulWidget {
  @override
  State<Afteraccountadd> createState() => _AfteraccountaddState();
}

class _AfteraccountaddState extends State<Afteraccountadd> {
 final storage = new FlutterSecureStorage();
 String? accno;
  String? accholder;

 String? acctype;
 bool isLoading=true;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getaccountdetails();
    
    
   
  }
 getaccountdetails() async{
  String? accholder1 =await  storage.read(key: 'accholdername');
  String? accno1 = await storage.read(key: 'accno');
  
  String? acctype1 =await  storage.read(key: 'acctype');
  for(int i=0;i<100;i++){

  }
  setState(() {
    accno=accno1;
    
    
  });
   setState(() {
       accholder=accholder1;
   });
    setState(() {
       acctype=acctype1;
   });
 }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
         appBar: Homeelements(),
      drawer:  Mydrawer(),
       bottomNavigationBar: Screen1(),
        backgroundColor: Colors.teal,
        body:  SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CircleAvatar(
              //   radius: 50.0,
              //   backgroundImage: AssetImage('images/Profile_Pic.png'),
              // ),
              Text(
                'Cooperative Bank',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              Text(
                'Thamarassery',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 20.0,
                  letterSpacing: 2.5,
                  color: Colors.teal[100],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 250.0,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  // leading: Icon(
                  //   Icons.account_circle_rounded,
                  //   color: Colors.teal,
                  // ),
                  title: Text(
                    'Account Number: $accno \nAccount holder: $accholder \nAccount type: $acctype',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              // Card(
              //   color: Colors.white,
              //   margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              //   child: ListTile(
              //     leading: Icon(
              //       Icons.email,
              //       color: Colors.teal,
              //     ),
              //     title: Text(
              //       'puranjaypotnis1@gmail.com',
              //       style: TextStyle(
              //         color: Colors.teal.shade900,
              //         fontFamily: 'Source Sans Pro',
              //         fontSize: 20.0,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          )
          ),
        ),
      );
  }
}