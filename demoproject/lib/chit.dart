import 'package:demoproject/loan.dart';
import 'package:demoproject/userdash.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:demoproject/Login_Screen.dart';
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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class Chit extends StatefulWidget {
  const Chit({super.key});

  @override
  State<Chit> createState() => _ChitState();
}

class _ChitState extends State<Chit> {
  TabController? _tabController; 
 final _amountcontroller=TextEditingController();
    List<dynamic>? myList;
    List<dynamic>? myList2;
     List<dynamic>? chittal;
    final _formKey = GlobalKey<FormState>();
    String? chitid;
    final ValueNotifier<String> _selectedItem = ValueNotifier<String>('');
    Razorpay? _razorpay;
// Declare a TabController variable

// String _selectedItem = '';


getchittalnumbers() async{
    final token = await storage.read(key: 'token');
  //  var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/getloans/'));
     var request = http.MultipartRequest('POST', Uri.parse(ip+'api/getchitalnumbers/'));

   final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': '$token',
    };
    request.headers.addAll(headers);
     request.fields['chitid'] =chitid.toString();
      var response = await request.send();
    if (response.statusCode == 200) {
       final body = await response.stream.bytesToString();
       final data = json.decode(body);
       print(data);
      setState(() {
        chittal=[];
         chittal = data;
      });
         print(chittal);
         _showBottomSheet();
    }
    else if(response.statusCode ==400){
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Slots seems to be full....')),
    );
      //  myList=null;
    }
    else{
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Something went wrong please try again later....')),
    );
    }
}

sendchitrequest() async{
  if(_selectedItem.value != ""){


   final accno = await storage.read(key: 'accno');
   if( accno != null){
  final token = await storage.read(key: 'token');
  //  var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/getloans/'));
     var request = http.MultipartRequest('POST', Uri.parse(ip+'api/sendchitrequest/'));

   final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': '$token',
    };
    request.headers.addAll(headers);
    request.fields['accno'] =accno.toString();
     request.fields['chitid'] =chitid.toString();
     request.fields['chitalnumber'] =_selectedItem.value;
    //  print("*****");
    //  print(accno.toString());
    //  print(chitid.toString());
    //  print(_selectedItem.value);
      var response = await request.send();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Successfully send....",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.deepOrangeAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    UserHome()), (Route<dynamic> route) => false);

        
      
      
    }
    else if(response.statusCode == 204){
         return Fluttertoast.showToast(
          msg: "Your request is already in pending...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else{
              return Fluttertoast.showToast(
          msg: "Something went wrong please try again later...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
   }
   else{
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please link your account with app before applying for chits....')),
    );
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    UserHome()), (Route<dynamic> route) => false);
      
   }
  }
  else{
    return Fluttertoast.showToast(
          msg: "Choose Chittal Number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
  }
}


 void _showBottomSheet() {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          height: 250.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Choose a Chittal Number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 16.0),
      DropdownButton<dynamic>(
        value: chittal![0], // set the initial value
        items: chittal!.map<DropdownMenuItem<dynamic>>((dynamic value) {
          return DropdownMenuItem<dynamic>(
        value: value,
        child: Text(value.toString()),
          );
        }).toList(),
        onChanged: (dynamic newValue) {
          _selectedItem.value = newValue.toString();
        print(chitid);
        print(_selectedItem.value);
          // setState(() {
          //   // update the value of the dropdown when an option is selected
          //   _selectedItem = newValue.toString();
          //   print(chitid);
          //   print(_selectedItem);
          // });
        },
      ),
      // if(_selectedItem != null) Text("You selected $_selectedItem")
      ValueListenableBuilder<String>(
        valueListenable: _selectedItem, // listen to the ValueNotifier for changes
        builder: (BuildContext context, String value, Widget? child) {
          return Text('Selected item: $value'); // text() the selected value
        },
      )
      
      
      
      
      
      
      
      
      //               DropdownButton(
      //   value: _selectedItem,
      //   items: chittal!.map((item) {
      //     return DropdownMenuItem(
      //       value: item["id"],
      //       child: Text(item["id"].toString()),
      //     );
      //   }).toList(),
      //   onChanged: (value) {
      //     setState(() {
      //       _selectedItem = value.toString();
      //     });
      //   },
      // )
      //              DropdownButton<String>(
      //   value: _selectedValue,
      //   items: chittal.map((Map<String, dynamic> item) {
      //     return DropdownMenuItem<String>(
      //       value: item["id"].toString(),
      //       child: Text(item["id"].toString()),
      //     );
      //   }).toList(),
      //   onChanged: (value) {
      //     setState(() {
      //       _selectedValue = value!;
      //     });
      //   },
      //   icon: Icon(
      //     Icons.arrow_drop_down,
      //     color: Colors.grey[800],
      //   ),
      //   iconSize: 36.0,
      //   isExpanded: true,
      //   underline: SizedBox(),
      //   style: TextStyle(
      //     fontSize: 20.0,
      //     fontWeight: FontWeight.bold,
      //     color: Colors.grey[800],
      //   ),
      // ), 
      
               , SizedBox(height: 10.0),
               ElevatedButton.icon(
                icon: Icon(Icons.send_rounded),
                  onPressed: () {
                    sendchitrequest();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigoAccent,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    // padding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  label: Text(
                    'Send Request',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.close_rounded),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[800],
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    // padding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  label: Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            //     Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     ElevatedButton.icon(
                  
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //       icon: Icon(Icons.close), // custom "close" icon
            //       label: Text('Close'),
            //     ),
            //     ElevatedButton.icon(
            //       onPressed: () {
            //         // send request logic here
            //       },
            //       icon: Icon(Icons.send), // custom "send request" icon
            //       label: Text('Send Request'),
            //     ),
            //   ],
            // ),
              ],
            ),
          ),
        ),
      );
    },
  ).then((_) {
    // reset the selected item value when the bottom sheet is dismissed
    _selectedItem.value = '';
  });
}


  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    chitid="";
    myList=[];
    myList2=[];
    super.initState();
    getchits();
    getappliedchitinfo();
    _selectedItem.value= "";
    // getappliedchitinfo();
    // _tabController = TabController(length: 2, vsync: this);
    // Initialize the TabController
  }

 @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }
 // 'key': 'rzp_test_NNbwJ9tmM0fbxj', rzp_test_4o2G44Ax4AOqRE

 void openCheckout() async {
  final mail = await storage.read(key: 'mail');
  final phone = await storage.read(key: 'phone'); 
    final accholdername = await storage.read(key: 'accholdername');

  var options = {
    'key': 'rzp_test_4uGg9FUbpCj4fB', 
    'amount': 28200,
    'name': accholdername,
    'description': 'Payment',
    'method': 'netbanking,card,upi,wallet,emi',
    'prefill': {'contact': phone, 'email': mail},
    'external': {
      'wallets': ['paytm', 'freecharge', 'phonepe', 'mobikwik', 'airtelmoney'],
          

    },
    'payment_capture': '1',
    
  };

     try {
      _razorpay!.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // void openCheckout() async {
  //   var options = {
  //     'key': 'rzp_test_4o2G44Ax4AOqRE', 
  //     'amount': 28200,
  //     'name': 'Shaiq',
  //     'description': 'Payment',
  //     'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
  //     'external': {
  //       'wallets': ['paytm']
  //     },
  //     'payment_capture': '1',
  //   'method': 'netbanking,card,upi'
  //   };

  //   try {
  //     _razorpay!.open(options);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId.toString(),);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message.toString(),
        );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName.toString(),);
  }

  getappliedchitinfo() async{
       final accNum= await storage.read(key: 'accno');
 for(int i=0;i<100;i=i+1)
 {

 }

if(accNum != null){
  // print(accountno);
  
      final token = await storage.read(key: 'token');

  print("#######");
  //  var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/getappliedloan/'));
     var request = http.MultipartRequest('POST', Uri.parse(ip+'api/getappliedchits/'));

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
       myList2=[];
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

  

  getchits() async{
    final token = await storage.read(key: 'token');
  //  var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/getloans/'));
     var request = http.MultipartRequest('POST', Uri.parse(ip+'api/getchits/'));

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
        myList=[];
         myList = data;
      });
         print(myList);
    }
    else{
      //  myList=null;
    }

}


  // @override
  // void dispose() {

  //   // Dispose the TabController when the widget is removed from the tree
  //   super.dispose();
  // }
  void clearSecureStorage() async {
  await storage.deleteAll();
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
  //  var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/loanrequest/'));
      var request = http.MultipartRequest('POST', Uri.parse(ip+'api/loanrequest/'));

   final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': '$token',
    };
    request.headers.addAll(headers);
     request.fields['accno'] =accNum;
     request.fields['amount'] =amount;
     print(chitid);
     request.fields['loanid']= chitid.toString();
      var response = await request.send();
      _amountcontroller.text="";
    if (response.statusCode == 200) {
       final body = await response.stream.bytesToString();
       final data = json.decode(body);
       print(data);
         
          ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request for loan successfully send')),
      );
       Navigator.pop(context);
    
//        Navigator.pushReplacement(
//   context,
//   MaterialPageRoute(builder: (context) => Loantab()),
// );
       Navigator.push(context, MaterialPageRoute(builder: (context) => Loantab()));
      // setState(() {
      //    myList = data;
      // });
     
      
      // return;
        // Navigator.pop(context);

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
                  Tab(text: 'Chits' , icon: Icon(Icons.monetization_on_outlined),),
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
              trailing: IconButton(
  icon: Icon(Icons.send_and_archive_rounded),
  onPressed: () {
    chitid=item['id'].toString();
    getchittalnumbers();
    // _showBottomSheet();
    // handle button press
    
    // _showPopup(context);
  },
  color: Colors.blue,
  highlightColor: Colors.yellow,
  splashColor: Colors.green,
),
              title: Text( item['name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              subtitle: Column(
                children: [
                  // Text( item['chit_amount'].toString(),style: TextStyle(
                  //     fontSize: 14,
                  //     color: Colors.blueGrey,
                  //   ),),
                  //   SizedBox(height: 2,),
                    Row(
                      children: [
                      Text(
              "Amount ",
              style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),
            ),
                        Text( item['chit_amount'].toString(),style: TextStyle(
                          fontSize: 15,
                          color: Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                      Text(
              "Start Date: ",
              style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),
            ),
                        Text( item['start_date'].toString(),style: TextStyle(
                          fontSize: 15,
                          color: Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
              "End Date: ",
              style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),
            ),
                        Text( item['end_date'].toString(),style: TextStyle(
                          fontSize: 15,
                          color:  Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic
                        ),),
                      ],
                    ),
                     Row(
                      children: [
                        Text(
              "Joinind Due Date: ",
              style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),
            ),
                        Text( item['due_date'].toString(),style: TextStyle(
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
  splashColor: Color.fromRGBO(76, 175, 80, 1),) :
//   if(item['current_installment'] <= item['period']) {
//   IconButton(
//     icon: Icon(Icons.paypal_sharp),
//     onPressed: () {
//       openCheckout();
//       // handle button press
//       // loanid = item['id'].toString();
//       // _showPopup(context);
//     },
//     color: Colors.blue,
//     highlightColor: Colors.yellow,
//     splashColor: Colors.green,
//   );
// } 
      IconButton(
  icon: Icon(Icons.paypal_sharp),
  onPressed: () {
    openCheckout();
    // // handle button press
    // loanid=item['id'].toString();
    // _showPopup(context);
  },
  
  
             
  color: Colors.blue,
  highlightColor: Colors.yellow,
  splashColor: Colors.green,
), 

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
                    Row(
                      children: [
                        Text(
              "status: ",
              style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),
            ),
                        Text( item['status'].toString(),style: TextStyle(
                          fontSize: 15,
                          color:  Colors.deepPurpleAccent,
                          fontStyle: FontStyle.italic
                        ),),
                      ],
                    ),
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