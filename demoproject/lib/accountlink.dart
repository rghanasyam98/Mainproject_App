
import 'dart:convert';
import 'package:demoproject/ip.dart';
import 'package:demoproject/accountrequest.dart';
import 'package:demoproject/afteraccountadd.dart';
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

class Accountlink extends StatefulWidget {
  const Accountlink({super.key});



  @override
  State<Accountlink> createState() => _AccountlinkState();
}


class _AccountlinkState extends State<Accountlink> {
  final storage = FlutterSecureStorage();
    final _accno = TextEditingController();
    final _otpController = TextEditingController();
     String? otp;
     String? acc_reqid;
      bool _isCorrect = false;

@override
  void initState() {
   
    super.initState();
     otp = "000";
     acc_reqid="";
    // Initialize the state of your widget here
    
  }


  addaccount() async{
     final token = await storage.read(key: 'token');
    // var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/accountadd/$acc_reqid/'));

     var request = http.MultipartRequest('POST', Uri.parse(ip+'api/accountadd/$acc_reqid/'));
   final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': '$token',
    };
    request.headers.addAll(headers);
    print(acc_reqid);
    request.fields['acc_reqid'] =acc_reqid.toString();
   var response = await request.send();
    if (response.statusCode == 200) {
       final body = await response.stream.bytesToString();
       final data = json.decode(body);
       deleteFromSecureStorage();
       for(int i=0;i<100;i=i+1){

       }
         await storage.write(key: 'accno', value: data['accno'].toString());
           ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Account added successfully....')),
    );
    Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => UserHome()),
);
    }
    else{
        ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Something went wrong please try again....')),
    );
    }
  }

  void deleteFromSecureStorage() async {
  await storage.delete(key: 'accno');
}
    
  accountlink() async{
    
        //  if(_accno.text.toString() == null || _accno.text.toString().isEmpty ){
           if(!RegExp(r'^[0-9]+$').hasMatch(_accno.text.trim()) || _accno.text.toString().isEmpty ){
      ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter valid account number...')),
                
                );
                return;
    }
    final token = await storage.read(key: 'token');
    print(token);
  // var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/accountlink/'));
  var request = http.MultipartRequest('POST', Uri.parse(ip+'api/accountlink/'));
   final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': '$token',
    };
    request.headers.addAll(headers);
    //  request.headers['Content-Type'] = 'multipart/form-data';
     request.fields['accno'] =_accno.text.toString();
   var response = await request.send();
    if (response.statusCode == 200) {
     
      // print('success');
      final body = await response.stream.bytesToString();
final data = json.decode(body);

// Access individual fields by name
 String otpfromserver = data['otp'].toString();
  acc_reqid = data['account_requestid'].toString();
  print(acc_reqid);
print(otpfromserver);
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('OTP is send to your registered mobile number...')),
    );
//      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
//     Accountlink()), (Route<dynamic> route) => false);
// //     Timer(Duration(seconds: 5), () {
// //   // code to execute after 5 seconds
// // });
// Future.delayed(Duration(seconds: 5), () {
//   // code to execute after 5 seconds
setState(() {
        otp = otpfromserver;
        print(otp);
      });

// });
      
    } 

     else if(response.statusCode==400){
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Invalid account number....')),
    );
    
    
    //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    // UserHome()), (Route<dynamic> route) => false);
    }
    else if(response.statusCode==403){
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Poor network connection....')),
    );
    //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    // UserHome()), (Route<dynamic> route) => false);
    }
    else if(response.statusCode==401){
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Requested account is already linked....')),
    );
    //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    // UserHome()), (Route<dynamic> route) => false);
    }
    
    
    else {
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Internal error occured....')),
    );

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: Homeelements(),
      drawer:  Mydrawer(),
       bottomNavigationBar: Screen1(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [ SizedBox(
                          width: 290,
                          child: ElevatedButton.icon(onPressed: (() {
                           Navigator.push(context,
      MaterialPageRoute(builder: (context) => Accountrequest()));
                                              
                                               }),icon: Icon(Icons.money_rounded), label: Text('Request New Account'),
                                               style: ElevatedButton.styleFrom(
                primary: Colors.amber,
            ),),
                        ),
                        SizedBox(height: 10,),
           SizedBox(
            width: 300,
             child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: TextFormField(
                        
                        controller: _accno,
                        decoration: InputDecoration(
                          
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        labelText: 'Account Number',
                        prefixIcon: Icon(Icons.pin),
                        
                      ),),
                    ),
           ),

           SizedBox(
            width: 290,
             child: ElevatedButton.icon(onPressed: (() { 

              accountlink();
      //                       Navigator.push(context,
      // MaterialPageRoute(builder: (context) =>  Home()));
                         }), icon: Icon(Icons.add), label: Text('Add Existing account'),),
           ),
                       SizedBox(height: 20,),
                       if (otp != "000")
              SizedBox(
            width: 300,
             child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
              // Check if the OTP is correct
              _isCorrect = value == otp; // Replace '1234' with the correct OTP
            });
                          
                        },
                        
                         controller: _otpController,
                        decoration: InputDecoration(
                          
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        labelText: 'OTP',
                        prefixIcon: Icon(Icons.numbers_rounded),
                        
                      ),),
                    ),
           ),
            if (_isCorrect)
               SizedBox(
            width: 290,
             child: ElevatedButton.icon(onPressed: (() { 
                addaccount();
             
                         }), icon: Icon(Icons.verified_user), label: Text('Submit OTP'),),
           ),
                       
          ],
        ),
      ),
    );
  }
}