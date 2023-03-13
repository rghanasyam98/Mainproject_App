import 'package:demoproject/Login_Screen.dart';
import 'package:demoproject/bottomnav.dart';
import 'package:demoproject/drawer.dart';
import 'package:demoproject/viewloans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Loantab extends StatefulWidget {
  const Loantab({super.key});

  @override
  State<Loantab> createState() => _LoantabState();
}

class _LoantabState extends State<Loantab> {
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
    getloaninfo();
    getappliedloaninfo();
    // _tabController = TabController(length: 2, vsync: this);
    // Initialize the TabController
  }

  getappliedloaninfo() async{
       final accNum= await storage.read(key: 'accno');
 for(int i=0;i<100;i=i+1)
 {

 }

if(accNum != null){
  // print(accountno);
  
      final token = await storage.read(key: 'token');

  print("hai");
   var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/getappliedloan/'));
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
         myList2 = data;
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
       myList2=null;
    }
   

}

      else{

         ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please link your account with app before applying for loan....')),
    );
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    Loantab()), (Route<dynamic> route) => false);
      }

}

  

  getloaninfo() async{
    final token = await storage.read(key: 'token');
   var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/getloans/'));
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
         print(myList);
    }
    else{
      //  myList=null;
    }

}


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
    Uri.parse('http://192.168.43.210:8000/api/userlogout/'),  
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


sendloanrequest()async{
final accNum= await storage.read(key: 'accno');
 for(int i=0;i<100;i=i+1)
 {

 }
if(accNum != null){
  // print(accountno);
  final amount=_amountcontroller.text.toString();
  print("hai");
  final token = await storage.read(key: 'token');
   var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/loanrequest/'));
   final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': '$token',
    };
    request.headers.addAll(headers);
     request.fields['accno'] =accNum;
     request.fields['amount'] =amount;
     print(loanid);
     request.fields['loanid']= loanid.toString();
      var response = await request.send();
      _amountcontroller.text="";
    if (response.statusCode == 200) {
       final body = await response.stream.bytesToString();
       final data = json.decode(body);
       print(data);
       Navigator.push(context, MaterialPageRoute(builder: (context) => Loantab()));
      // setState(() {
      //    myList = data;
      // });
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request for loan successfully send')),
      );

    }
    else if(response.statusCode == 204) {
           ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your request is already in pending...')),
      );
    }
    else{
      //  myList=null;
    }
   

}

      else{

         ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please link your account with app before applying for loan....')),
    );
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    Loantab()), (Route<dynamic> route) => false);
      }

}

 void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter loan amount'),
          content:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: TextFormField(
               validator: (value) {
                          
                          if(value ==null || value.isEmpty ){
                            // EmailValidator.validate(value!);
                            return 'Please enter amount';
                            
                          }
                           
                        
                          
      //                       ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Processing Data')),
      // );
                         
                        },
             controller: _amountcontroller,
              decoration: InputDecoration(
                hintText: 'Amount',
                border: OutlineInputBorder()
                
              ),
            ),
          ),
        ),
          actions: <Widget>[
           ElevatedButton.icon(onPressed: (() {
             if (_formKey.currentState!.validate()){
                sendloanrequest();
             }
          
           }), icon: Icon(Icons.send_rounded), 
           label: Text("Send request"))
          ],
        );
      },
    );
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
                  Tab(text: 'Loans' , icon: Icon(Icons.monetization_on_outlined),),
                  Tab(text: 'Applied', icon: Icon(Icons.assignment_turned_in_outlined),),
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
              leading:   Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Interest",
              style: TextStyle(fontSize: 12),
            ),
            Text(
              "${item['roi']}%",
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
              trailing: IconButton(
  icon: Icon(Icons.telegram_outlined),
  onPressed: () {
    // handle button press
    loanid=item['id'].toString();
    _showPopup(context);
  },
  color: Colors.blue,
  highlightColor: Colors.yellow,
  splashColor: Colors.green,
),
              title: Text( item['lname'],style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Column(
                children: [
                  Text( item['des'],style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey,
                    ),),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                      Text(
              "Minimum Amount: ",
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
              "Maximam Amount: ",
              style: TextStyle(fontSize: 13,fontStyle: FontStyle.italic),
            ),
                        Text( item['max'].toString(),style: TextStyle(
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
             trailing: item['status'].toString() == "pending" ?
              IconButton(
  icon: Icon(Icons.delete_sweep_rounded),
  onPressed: () {
    // // handle button press
    // loanid=item['id'].toString();
    // _showPopup(context);
  },
             
  color: Colors.blue,
  highlightColor: Colors.yellow,
  splashColor: Colors.green,
): SizedBox(), 
             
            
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