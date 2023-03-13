import 'dart:convert';
import 'package:demoproject/bottomnav.dart';
import 'package:demoproject/drawer.dart';
import 'package:demoproject/homeelements.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
   List<dynamic>? myList;
     final storage = FlutterSecureStorage();

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
     myList = [];
    
    getnews();
  }

  
getnews() async{
   final token = await storage.read(key: 'token');
   var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/getnews/'));
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
       print(data);
      setState(() {
         myList = data;
      });

    }
    else{
      //  myList=null;
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Homeelements(),
      drawer:  Mydrawer(),
//     
body:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 4, bottom: 4),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                side: BorderSide(color: Color.fromARGB(255, 35, 117, 224), width: 4),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'News',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: myList?.length,
            itemBuilder: (context, index) {
              final item = myList?[index];
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey, width: 1),
                  ),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.network(
                          'http://192.168.43.210:8000/media/${item['image']}',
                          width: double.infinity,
                          // height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              item['content'],
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
       bottomNavigationBar: Screen1(),
    );
  }
}