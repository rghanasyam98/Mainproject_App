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


class Auctiontab extends StatefulWidget {
  const Auctiontab({super.key});

  @override
  State<Auctiontab> createState() => _AuctionState();
}

class _AuctionState extends State<Auctiontab> {
  TabController? _tabController; 
 final _amountcontroller=TextEditingController();
    List<dynamic>? myList;
    List<dynamic>? myList2;
    final _formKey = GlobalKey<FormState>();
    String? loanid;
// Declare a TabController variable

  @override
  void initState() {
    loanid="";
    myList=[];
    myList2=[];
    super.initState();
    getjoinedchitinfo();
    // getauctioninfo();
    // getappliedloaninfo();
    // _tabController = TabController(length: 2, vsync: this);
    // Initialize the TabController
  }

//   getappliedloaninfo() async{
//        final accNum= await storage.read(key: 'accno');
//  for(int i=0;i<100;i=i+1)
//  {

//  }

// if(accNum != null){
//   // print(accountno);
  
//       final token = await storage.read(key: 'token');

//   print("hai");
//   //  var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/getappliedloan/'));
//      var request = http.MultipartRequest('POST', Uri.parse(ip+'api/getappliedloan/'));

//    final Map<String, String> headers = {
//     'Content-Type': 'multipart/form-data',
//     'Authorization': '$token',
//     };
//     request.headers.addAll(headers);
//      request.fields['accno'] =accNum;
    
   
    
//       var response = await request.send();
     
//     if (response.statusCode == 200) {
//        final body = await response.stream.bytesToString();
//        final data = json.decode(body);
//        print("******");
//        print(data);
//       //  Navigator.push(context, MaterialPageRoute(builder: (context) => Loantab()));
//       setState(() {
//          myList2 = data;
//       // // });
//       //   ScaffoldMessenger.of(context).showSnackBar(
//       //   const SnackBar(content: Text('Request for loan successfully send')),
//     });

//     }
//     else if(response.statusCode == 204) {
//       //      ScaffoldMessenger.of(context).showSnackBar(
//       //   const SnackBar(content: Text('Your request is already in pending...')),
//       // );
//     }
//     else{
//        myList2=null;
//     }
   

// }

//       else{

//     //      ScaffoldMessenger.of(context).showSnackBar(
//     //   SnackBar(content: Text('Please link your account with app before applying for loan....')),
//     // );
//     //      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
//     // Loantab()), (Route<dynamic> route) => false);
//       }

// }

  

//   getauctioninfo() async{
//     print("get auctions");
//     final token = await storage.read(key: 'token');
//     final accNum= await storage.read(key: 'accno');
//   //  var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/getloans/'));
//      var request = http.MultipartRequest('POST', Uri.parse(ip+'api/getauctions/'));

//    final Map<String, String> headers = {
//     'Content-Type': 'multipart/form-data',
//     'Authorization': '$token',
//     };
//     request.headers.addAll(headers);
//      request.fields['accno'] = accNum.toString();
//       var response = await request.send();
//     if (response.statusCode == 200) {
//        final body = await response.stream.bytesToString();
//        final data = json.decode(body);
//        print(data);
//       setState(() {
//          myList = data;
//       });
//          print(myList);
//     }
//     else{
//       //  myList=null;
//     }

// }


  @override
  void dispose() {

    // Dispose the TabController when the widget is removed from the tree
    super.dispose();
  }

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

 getjoinedchitinfo() async{
       final accNum= await storage.read(key: 'accno');
 for(int i=0;i<100;i=i+1)
 {

 }

if(accNum != null){
  // print(accountno);
  
      final token = await storage.read(key: 'token');

  print("#######");
  //  var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/getappliedloan/'));
     var request = http.MultipartRequest('POST', Uri.parse(ip+'api/getjoinedchits/'));

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

 

void clearSecureStorage() async {
  await storage.deleteAll();
}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: Screen1(),
            drawer:  Mydrawer(),
            appBar: AppBar(
               title: Text('Smart Bank'),
       actions: [IconButton(
            icon: Icon(Icons.logout),
            onPressed:(() {
              user_logout();
            }) ,
          ),],
             
              // title: Text('Flutter Tabs Example'),
              bottom: TabBar(
                labelColor: Colors.black,
  unselectedLabelColor: Colors.grey,
  indicatorColor: Colors.orange,
  indicatorWeight: 3.0,
                tabs: [
                  Tab(text: 'Joined Chits' , icon: Icon(Icons.attach_money_rounded),),
                  Tab(text: 'Your winnings', icon: Icon(Icons.wallet_giftcard_outlined),),
                ],
              ),
            ),
            body: TabBarView(
              
              children: [
                 Container(
                  decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
                  child: ListView.separated(itemBuilder: (BuildContext context, int index) {
                    final item = myList?[index];
          return Card(
            elevation: 4.0,
            child: ListTile(
        //       leading:   Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       "Interest",
        //       style: TextStyle(fontSize: 12),
        //     ),
        //     // Text(
        //     //   "${item['roi']}%",
        //     //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //     // ),
        //     // SizedBox(height: 5),
        //     // Text(
        //     //   "Minimum",
        //     //   style: TextStyle(fontSize: 12),
        //     // ),
        //     // Text(
        //     //   "${item['min']}",
        //     //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //     // ),
        //     // SizedBox(height: 5),
        //     // Text(
        //     //   "Maximum",
        //     //   style: TextStyle(fontSize: 12),
        //     // ),
        //     // Text(
        //     //   "${item['max']}",
        //     //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //     // ),
        //   ],
        // ),
//              trailing: item['status'].toString() == "pending" ?
//               IconButton(
//   icon: Icon(Icons.delete_sweep_rounded),
//   onPressed: () {
//     // // handle button press
//     // loanid=item['id'].toString();
//     // _showPopup(context);
//   },
  
  
             
//   color: Colors.blue,
//   highlightColor: Colors.yellow,
//   splashColor: Color.fromRGBO(76, 175, 80, 1),) :
// //   if(item['current_installment'] <= item['period']) {
// //   IconButton(
// //     icon: Icon(Icons.paypal_sharp),
// //     onPressed: () {
// //       openCheckout();
// //       // handle button press
// //       // loanid = item['id'].toString();
// //       // _showPopup(context);
// //     },
// //     color: Colors.blue,
// //     highlightColor: Colors.yellow,
// //     splashColor: Colors.green,
// //   );
// // } 
//       IconButton(
//   icon: Icon(Icons.paypal_sharp),
//   onPressed: () {
//     // openCheckout();
//     // // handle button press
//     // loanid=item['id'].toString();
//     // _showPopup(context);
//   },
  
  
             
//   color: Colors.blue,
//   highlightColor: Colors.yellow,
//   splashColor: Colors.green,
// ), 
onTap: () {
   Navigator.push(context,
      MaterialPageRoute(builder: (context) => viewauctionlinks(item['id'],item['chit_name'],item['amount'].toString())));
},

             leading:   Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Months",
              style: TextStyle(fontSize: 12),
            ),
            Text(
              "${item['period']}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // SizedBox(height: 5),
            // Text(
            //   "Minimum",
            //   style: TextStyle(fontSize: 12),
            // ),
            // Text(
            //   "${item['min']}",
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 5),
            // Text(
            //   "Maximum",
            //   style: TextStyle(fontSize: 12),
            // ),
            // Text(
            //   "${item['max']}",
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
          ],
        ),
            
              title: Text( item['chit_name'].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              subtitle: Column(
                children: [
                  Row(
                    children: [ Text(
              "chit amount: ",
              style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),
            ),
                      Text( item['amount'].toString(),style: TextStyle(
                          fontSize: 15,
                          color:  Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic
                        ),),
                    ],
                  ),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                      Text(
              "Start Date: ",
              style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),
            ),
                        Text( item['start'].toString(),style: TextStyle(
                          fontSize: 15,
                          color: Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
              "End date: ",
              style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),
            ),
                        Text( item['end'].toString(),style: TextStyle(
                          fontSize: 15,
                          color:  Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic
                        ),),
                      ],
                    ),
                     Row(
                      children: [
                        Text(
              "Chittal Number: ",
              style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),
            ),
                        Text( item['chittal_number'].toString(),style: TextStyle(
                          fontSize: 15,
                          color:  Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic
                        ),),
                      ],
                    ),
            //         Row(
            //           children: [
            //             Text(
            //   "status: ",
            //   style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),
            // ),
            //             Text( item['status'].toString(),style: TextStyle(
            //               fontSize: 15,
            //               color:  Colors.deepPurpleAccent,
            //               fontStyle: FontStyle.italic
            //             ),),
            //           ],
            //         ),
                    Row(
                      children: [
                        Text(
              "Current installment: ",
              style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),
            ),
                        Text( item['current_installment'].toString(),style: TextStyle(
                          fontSize: 15,
                          color:  Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic
                        ),),
                      ],
                    ),
                     Row(
                      children: [
                        Text(
              "Payment Due date: ",
              style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),
            ),
                        Text( item['paydue'].toString()+"th",style: TextStyle(
                          fontSize: 15,
                          color:  Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic
                        ),),
                      ],
                    ),
                ],
              ),
            ),
          );
        }, separatorBuilder: (context, index) {
        return const SizedBox(height: 3,);
      },
         itemCount: myList!.length
    ),
                ),
    Container(
                  decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
                  child: ListView.separated(itemBuilder: (BuildContext context, int index) {
                    final item = myList2?[index];
          return Card(
            elevation: 4.0,
            child: ListTile(
        //       leading:   Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       "Interest",
        //       style: TextStyle(fontSize: 12),
        //     ),
        //     // Text(
        //     //   "${item['roi']}%",
        //     //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //     // ),
        //     // SizedBox(height: 5),
        //     // Text(
        //     //   "Minimum",
        //     //   style: TextStyle(fontSize: 12),
        //     // ),
        //     // Text(
        //     //   "${item['min']}",
        //     //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //     // ),
        //     // SizedBox(height: 5),
        //     // Text(
        //     //   "Maximum",
        //     //   style: TextStyle(fontSize: 12),
        //     // ),
        //     // Text(
        //     //   "${item['max']}",
        //     //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //     // ),
        //   ],
        // ),
//              trailing: item['status'].toString() == "pending" ?
//               IconButton(
//   icon: Icon(Icons.delete_sweep_rounded),
//   onPressed: () {
//     // // handle button press
//     // loanid=item['id'].toString();
//     // _showPopup(context);
//   },
             
//   color: Colors.blue,
//   highlightColor: Colors.yellow,
//   splashColor: Colors.green,
// ): SizedBox(), 
             
            
              title: Text( item['loan_name'].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Column(
                children: [
                  Row(
                    children: [ Text(
              "Loan amount: ",
              style: TextStyle(fontSize: 13,fontStyle: FontStyle.italic),
            ),
                      Text( item['amount'].toString(),style: TextStyle(
                          fontSize: 14,
                          color:  Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic
                        ),),
                    ],
                  ),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                      Text(
              "Minimum date: ",
              style: TextStyle(fontSize: 13,fontStyle: FontStyle.italic),
            ),
                        Text( item['min'].toString(),style: TextStyle(
                          fontSize: 14,
                          color: Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
              "Maximam date: ",
              style: TextStyle(fontSize: 13,fontStyle: FontStyle.italic),
            ),
                        Text( item['max'].toString(),style: TextStyle(
                          fontSize: 14,
                          color:  Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic
                        ),),
                      ],
                    ),
                     Row(
                      children: [
                        Text(
              "EMI: ",
              style: TextStyle(fontSize: 13,fontStyle: FontStyle.italic),
            ),
                        Text( item['emi'].toString(),style: TextStyle(
                          fontSize: 14,
                          color:  Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
              "status: ",
              style: TextStyle(fontSize: 13,fontStyle: FontStyle.italic),
            ),
                        Text( item['status'].toString(),style: TextStyle(
                          fontSize: 14,
                          color:  Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic
                        ),),
                      ],
                    ),
                ],
              ),
            ),
          );
        }, separatorBuilder: (context, index) {
        return const SizedBox(height: 3,);
      },
         itemCount: myList2!.length
    ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     // Handle click in Tab 1
                //     // print('Clicked Tab 1');
                //     return  ;
                //   },
                //   child: Center(child: Text('Content of Tab 1')),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     // Handle click in Tab 2
                //     print('Clicked Tab 2');
                //   },
                //   child: Center(child: Text('Content of Tab 2')),
                // ),
              ],
            ),
          // ),
       
      ),
    );
  }
}