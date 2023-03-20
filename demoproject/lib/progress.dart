import 'package:demoproject/bottomnav.dart';
import 'package:demoproject/ip.dart';
import 'package:demoproject/userdash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay to simulate loading data from the server
    Future.delayed(Duration(seconds: 3), () {
      // Pass in the balance amount as an argument when navigating to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AccountBalanceScreen(balance: 1000.0),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            Center(
              child: SizedBox(
                width: 120.0,
                height: 120.0,
                child: Stack(
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 10.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.grey.shade100,
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.account_balance,
                          color: Colors.white,
                          size: 60.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Fetching Account Balance...',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class AccountBalanceScreen extends StatefulWidget {
  final double balance;

  const AccountBalanceScreen({Key? key, required this.balance}) : super(key: key);

  @override
  State<AccountBalanceScreen> createState() => _AccountBalanceScreenState();
}
class _AccountBalanceScreenState extends State<AccountBalanceScreen> {
  String accbal = "";
  String accholder = "";
  String accNo = "";
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getbalance();
  }

  Future<void> getbalance() async {
    final accno = await storage.read(key: 'accno');
     String? accholder1 =await  storage.read(key: 'accholdername');
  String? accno1 = await storage.read(key: 'accno');
    // print("CCNO"+accno.toString());
    var request = http.MultipartRequest('POST', Uri.parse(ip + 'api/getbalance/'));
    final Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'accno': '$accno'
    };
    request.headers.addAll(headers);
    request.fields['accno'] = accno.toString();
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseJson = await response.stream.bytesToString();
      final data = jsonDecode(responseJson);
      setState(() {
        accbal = data['balance'].toString();
        accholder=accholder1!;
        accNo=accno!;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong please try again later....')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: Screen1(),
      appBar: AppBar(
        
        backgroundColor: Colors.greenAccent,
        title: Text('Account Balance'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Current Balance',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    ' Rs $accbal',
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 2.0,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Account Number:',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '$accNo',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Account Holder:',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '$accholder',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
