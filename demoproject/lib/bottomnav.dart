import 'dart:convert';

import 'package:demoproject/editprofile.dart';
import 'package:demoproject/userdash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
 int _selectedIndex = 0;
   final storage = FlutterSecureStorage();

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home'),
    Text('Search'),
    Text('Profile'),
  ];
  //  void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
 bottomnavigationfunctions() async{
      if(_selectedIndex == 0){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    UserHome()), (Route<dynamic> route) => false);
      
      }
      else{

  //       final token = await storage.read(key: 'token');
  //   var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/editprofilecheck/'));
  //  final Map<String, String> headers = {
  //   'Content-Type': 'multipart/form-data',
  //   'Authorization': '$token',
  //   };
  //   request.headers.addAll(headers);
   
    
  //  var response = await request.send();
  //   if (response.statusCode == 200) {
  //      final body = await response.stream.bytesToString();
  //      final data = json.decode(body);
        
  //       Navigator.pushReplacement(
  //               context,
  //               MaterialPageRoute(builder: (context) => Editprofile()),
  //             );
  //     }
  // final accountno=await storage.containsKey(key: 'accno');
 final accNum= await storage.read(key: 'accno');
 for(int i=0;i<100;i=i+1)
 {

 }
if(accNum != null){
  // print(accountno);
  print("hai");
   Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Editprofile()),
              );

}

      else{

         ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please link your account with app before editing profile....')),
    );
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    UserHome()), (Route<dynamic> route) => false);
      }
 }
 }
  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.green,
        currentIndex: _selectedIndex,
        onTap: (value) {
         setState(() {
            _selectedIndex=value;
           
          print(value);
         });
          bottomnavigationfunctions();
        },
        items:const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),label: 'Profile'),
          
        // BottomNavigationBarItem(icon:  Icon(Icons.search),label: 'Search')
      ]);
  
}}