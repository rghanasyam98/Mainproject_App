import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:demoproject/bottomnav.dart';
import 'package:demoproject/drawer.dart';
import 'package:demoproject/homeelements.dart';
import 'package:demoproject/ip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';


class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final storage = FlutterSecureStorage();
  List<dynamic>? myList;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
     myList = [];
    getinfoforinitialize();
    // getnews();
  }
getinfoforinitialize() async{
   final token = await storage.read(key: 'token');
  //  var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/getinfoforinitialize/'));
   var request = http.MultipartRequest('POST', Uri.parse(ip+'api/getinfoforinitialize/'));
   final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': '$token',
    };
    request.headers.addAll(headers);
     request.fields['body'] ="body";
      var response = await request.send();
    if (response.statusCode == 200) {
       final body = await response.stream.bytesToString();
       final data = json.decode(body);
      //  print(data['accholdername'].toString());
      //   print(data['acctype'].toString());
      print(data);
         await storage.write(key: 'accno', value: data['accno'].toString());  
         await storage.write(key: 'accholdername', value: data['accholdername'].toString());
          await storage.write(key: 'acctype', value: data['acctype'].toString());
           await storage.write(key: 'mail', value: data['mail'].toString());
            await storage.write(key: 'phone', value: data['phone'].toString());
        //  String? accno = await storage.read(key: 'accno');
        //   String? accholdername = await storage.read(key: 'accholdername');
        //    String? acctype = await storage.read(key: 'acctype');
        // //  print(""+accno.toString()+accholdername.toString()+acctype.toString()); 
        //  print(""+accno.toString());
        //   print(""+accholdername.toString());
        //             print(""+acctype.toString());

    }
    else if(response.statusCode == 400){
       await storage.write(key: 'accno', value: null);  
       final body = await response.stream.bytesToString();
       final data = json.decode(body);
            await storage.write(key: 'mail', value: data['mail'].toString());
            await storage.write(key: 'phone', value: data['phone'].toString());
          //    String? mmail = await storage.read(key: 'mail');
          // String? pphone = await storage.read(key: 'phone');
          //   print(mmail);
          //    print(pphone);
    }
    else{
      await storage.write(key: 'accno', value: null);  
    //     ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Failed to load data....')),
    // );
    }
}

// getnews() async{
//    final token = await storage.read(key: 'token');
//    var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/getnews/'));
//    final Map<String, String> headers = {
//     'Content-Type': 'multipart/form-data',
//     'Authorization': '$token',
//     };
//     request.headers.addAll(headers);
//      request.fields['body'] ="body";
//       var response = await request.send();
//     if (response.statusCode == 200) {
//        final body = await response.stream.bytesToString();
//        final data = json.decode(body);
//        print(data);
//       setState(() {
//          myList = data;
//       });

//     }
//     else{
//       //  myList=null;
//     }
// }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Homeelements(),
      drawer: Mydrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 55, 114, 139),
              Colors.black,
              Color.fromARGB(255, 196, 236, 75),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 15),
            ),
            CarouselSlider(
              items: [
                Image.asset(
                  'assets/images/home1.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  // height: double.infinity,
                ),
                Image.asset(
                  'assets/images/home2.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  // height: double.infinity,
                ),
                Image.asset(
                  'assets/images/home3.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  // height: double.infinity,
                ),
              ],
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.6,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                scrollDirection: Axis.vertical, // add this line to make the carousel vertical
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Screen1(),
    );
  }
}