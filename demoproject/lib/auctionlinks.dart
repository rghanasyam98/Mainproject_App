import 'package:demoproject/auction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:demoproject/Login_Screen.dart';
import 'package:demoproject/auctionlinks.dart';
import 'package:demoproject/bottomnav.dart';
import 'package:demoproject/drawer.dart';
import 'package:demoproject/ip.dart';
import 'package:demoproject/viewloans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:async';


class viewauctionlinks extends StatefulWidget {
  final int custchitid;
  final String auction_name;
  final String auction_amount;
  const viewauctionlinks(this.custchitid,this.auction_name,this.auction_amount);

  @override
  State<viewauctionlinks> createState() => _viewauctionlinksState();
}

class _viewauctionlinksState extends State<viewauctionlinks> {
  List<dynamic>? myList;
  DateTime? today ;
  String? formattedDate;
  Timer? _timer;
  @override
  void initState() {
    today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    print(today);
    
print(formattedDate); // prints something like "2023-03-27"
    // TODO: implement initState
    super.initState();
    myList=[];
    print(widget.custchitid);
        print(widget.auction_name);
            print(widget.auction_amount);


    getjoinedchitauctioninfo();
     _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      // setState() to trigger a rebuild of the widget tree
      setState(() {});
    });

  }

  // gotoauctionroom() async{
    
  // }
  
final storage = FlutterSecureStorage();
  void user_logout() async {
  final token = await storage.read(key: 'token');
  // print(token);
  print('logot clicked');
  var response = await http.post(
    // Uri.parse('http://10.0.2.2:8000/api/userlogout/'), 
    // Uri.parse('http://192.168.43.210:8000/api/userlogout/'),  
        Uri.parse(ip+'api/userlogout/'),  

    headers: {
      'Authorization': '$token',
    },
  );
  print('response');
  print(response.body);
  if (response.statusCode == 201) {
    clearSecureStorage();
    print('logout success');
    // await storage.delete(key: 'token');
    
    print(storage);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    LoginScreen()), (Route<dynamic> route) => false);
  } else {
     print('logout failed');
    // handle error
  }
}

 getjoinedchitauctioninfo() async{
       final accNum= await storage.read(key: 'accno');
 for(int i=0;i<100;i=i+1)
 {

 }

if(accNum != null){
  // print(accountno);
  
      final token = await storage.read(key: 'token');

  print("#######");
  //  var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/getappliedloan/'));
     var request = http.MultipartRequest('POST', Uri.parse(ip+'api/getjoinedchitauctioninfo/${widget.custchitid}/'));

   final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': '$token',
    };
    request.headers.addAll(headers);
     request.fields['accno'] =accNum;
    
   
    
      var response = await request.send();
     
    if (response.statusCode == 200) {
       final body = await response.stream.bytesToString();
       final data = json.decode(body);
       print("******");
       print(data);
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => Loantab()));
      setState(() {
         print("+++++");
         myList = data;
         print(myList);
      // // });
      //   ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Request for loan successfully send')),
    });

    }
    else if(response.statusCode == 204) {
      //      ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Your request is already in pending...')),
      // );
    }
    else{
       myList=[];
    }
   

}

      else{

    //      ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Please link your account with app before applying for loan....')),
    // );
    //      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    // Loantab()), (Route<dynamic> route) => false);
      }

}

  @override
  void dispose() {
    // cancel the timer when the widget is disposed to avoid memory leaks
    _timer?.cancel();
    super.dispose();
  }

void clearSecureStorage() async {
  await storage.deleteAll();
}

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Screen1(),
      drawer: Mydrawer(),
      appBar: AppBar(
        title: Text('Smart Bank'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: (() {
              user_logout();
            }),
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
//           final item = myList?[index];
// final dateTime = DateFormat('yyyy-MM-dd hh:mm').parse('${item['auction_date']} ${item['auction_time']}');
// final timeonly = DateFormat('HH:mm:ss.SSS').format(dateTime);
// final parsedTime = DateTime.parse('1970-01-01 $timeonly');
// final time = TimeOfDay.fromDateTime(parsedTime);
// print(time);
// final formattedTime = DateFormat('h:mm a').format(dateTime);
// final auctionTime = DateFormat('HH:mm:ss').parse(item['auction_time']);
// // final difference = DateTime.now().difference(parsedTime);
// // print(difference.inMinutes);
// print(DateTime.now());
// final currentTime = DateTime.now();
// final currentDateTime = DateTime(parsedTime.year, parsedTime.month, parsedTime.day, currentTime.hour, currentTime.minute, currentTime.second);
// final difference = currentDateTime.difference(parsedTime);
// print(difference.inMinutes);

final item = myList?[index];
final dateTime = DateFormat('yyyy-MM-dd HH:mm').parse('${item['auction_date']} ${item['auction_time']}');
final timeonly = DateFormat('HH:mm:ss.SSS').format(dateTime);
final parsedTime = DateTime.parse('1970-01-01 $timeonly');
final formattedTime = DateFormat('h:mm a').format(dateTime);
final auctionTime = DateFormat('HH:mm:ss').parse(item['auction_time']);
final currentTime = DateTime.now();
final currentDateTime = DateTime(
  parsedTime.year,
  parsedTime.month,
  parsedTime.day,
  currentTime.hour,
  currentTime.minute,
  currentTime.second,
);
final difference = currentDateTime.difference(parsedTime);
print(difference.inMinutes);
String formattedDate = today!.toLocal().toString().split(' ')[0];


          return Card(
            elevation: 4,
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SlNo",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Text(
                    (myList!.length - index).toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today_rounded),
                      SizedBox(width: 4),
                      Text(
                        "Date: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.blueGrey,
                        ),
                      ),
                      Text(
                        item['auction_date'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.watch_rounded),
                      SizedBox(width: 4),
                      Text(
                        "Time: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.blueGrey,
                        ),
                      ),
                      Text(
                        // item['auction_time'],
                        formattedTime,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // final auctionTime = DateFormat('hh:mm a').parse(item['auction_time']); // convert auction_time to DateTime object

         // calculate difference between current time and auction time
         
              trailing: formattedDate !=  item['auction_date'] || (difference.isNegative || difference.inMinutes > 30) ? SizedBox() :ElevatedButton(
                onPressed: () {
                  // gotoauctionroom();
                   Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuctionScreen(widget.custchitid,widget.auction_name,widget.auction_amount,item['id'])),
            );
                },
                child: Text(
                  'Join',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              )
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
        itemCount: myList!.length,
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
    );
  }
}