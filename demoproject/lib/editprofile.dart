
import 'dart:io';
import 'package:demoproject/Login_Screen.dart';
import 'package:demoproject/bottomnav.dart';
import 'package:demoproject/ip.dart';
import 'package:demoproject/userdash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:demoproject/drawer.dart';
import 'package:demoproject/homeelements.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Editprofile extends StatefulWidget {
   Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {

 
 late Map<String, dynamic> _profileData;
  final storage = FlutterSecureStorage();
    final _fname = TextEditingController();
        final _address = TextEditingController();
          final _lname = TextEditingController(); 
          final _nameoffms = TextEditingController(); 
          final _nationality = TextEditingController(); 
          final _income=TextEditingController();
           final _nomname=TextEditingController();
           final _nomaddress=TextEditingController();
             final _relation=TextEditingController();
             final _aadhar=TextEditingController();
     int? _gender = 0;
     DateTime? _selectedDate=null;
     String? maritalstatus ;  
      String? dependants ; 
      String? employmentstatus ;   
      String? graduationstatus ; 
       String? property ;  
       String? _acctype ; 
              String? imgurl ;  
 
        XFile? image;

  final ImagePicker picker = ImagePicker();



  

   validateanduploadeditprofile() async{
      final token = await storage.read(key: 'token');
      print(token);

    print(_selectedDate);
    
    
   
     if(_address.text.toString() == null || _address.text.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter address...')),
                
                );
    }
     else if(maritalstatus == null || maritalstatus.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select marital status...')),
                
                );
    }
   
     else if(dependants == null || dependants.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select depandants...')),
                
                );
    }
     
     else if(employmentstatus == null || employmentstatus.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select employment status...')),
                
                );
    }
     else if(!RegExp(r'^[0-9]+$').hasMatch(_income.text.trim())){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter income...')),
                
                );
    }
    else if(graduationstatus == null || graduationstatus.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select graduation status...')),
                
                );
    }
    else if(property == null || property.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select property...')),
                
                );
    }
    
     
    
    
     
    // else if(image== null){
    //        ScaffoldMessenger.of(context).showSnackBar(
    //               const SnackBar(content: Text('Select image...')),
                
    //             );
    // }
    else{
     final accNum= await storage.read(key: 'accno');
  //  var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/updateprofile/'));
     var request = http.MultipartRequest('POST', Uri.parse(ip+'api/updateprofile/'));

   final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': '$token',
    };
    request.headers.addAll(headers);
    //  request.headers['Content-Type'] = 'multipart/form-data';
    //  request.fields['fname'] = _fname.text.toString();
    //  request.fields['lname'] = _lname.text.toString();
    //  request.fields['gender'] = _gender.toString();
     request.fields['accno'] = accNum.toString();
     request.fields['address'] = _address.text.toString();
     request.fields['marital_status'] = maritalstatus.toString();
    //  request.fields['nameof_fms'] = _nameoffms.text.toString();
     request.fields['dependants'] =dependants.toString();
    //  request.fields['nation'] = _nationality.text.toString();
     request.fields['employment'] = employmentstatus.toString();
     request.fields['income'] = _income.text.toString();
     request.fields['graduation'] =graduationstatus.toString();
     request.fields['property'] = property.toString();
    //  request.fields['account'] = _acctype.toString();
    //  request.fields['nominee'] =_nomname.text.toString();
    //  request.fields['nomaddress'] = _nomaddress.text.toString();
    //  request.fields['relation'] =_relation.text.toString();
    //   request.fields['aadhar'] =_aadhar.text.toString();

    if (image != null) {
  List<int> imageBytes = await image!.readAsBytes();
  
  // Extract the file name from the path
  String fileName = image!.path.split('/').last;

  // Create the multipart file
  var imageFile= http.MultipartFile.fromBytes(
    'image', // field name
    imageBytes, // file content
    filename: fileName,
  );

  request.files.add(imageFile);
  request.fields['image'] ="notnull";
} else {
  request.fields['image'] ="null";
}
  //    List<int> imageBytes = await image!.readAsBytes();
  
  // // Extract the file name from the path
  //    String fileName = image!.path.split('/').last;
  
  // // Create the multipart file

    

  //   var imageFile= http.MultipartFile.fromBytes(
  //   'image', // field name
  //   imageBytes, // file content
  //   filename: fileName,
  // );
  // request.files.add(imageFile);
   var response = await request.send();
    if (response.statusCode == 200) {
     
      // print('success');
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(' Successfully Updated')),
    );
    Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => Editprofile(),
  ),
);
//     Timer(Duration(seconds: 5), () {
//   // code to execute after 5 seconds
// });
Future.delayed(Duration(seconds: 5), () {
  // code to execute after 5 seconds
});
      //  Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => UserHome()),
      //           );

    } 
    // else if(response.statusCode == 403){
    //    ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Email Already exists....')),
    // );

    // }
    else if(response.statusCode==204){
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to update....')),
    );
     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    UserHome()), (Route<dynamic> route) => false);
    }
    
    
    else {
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Internal error occured....')),
    );

    }
  



    }
   }
  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

      @override
  void initState() {
    super.initState();
    getinformation();
    // _selectedDate=null;
    // maritalstatus = null;
    // dependants=null;
    // employmentstatus=null;
    // property=null;
    // _acctype=null;
  }
getinformation() async{
  final token = await storage.read(key: 'token');
  final accno = await storage.read(key: 'accno');
  // var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/getprofile/'));
    var request = http.MultipartRequest('POST', Uri.parse(ip+'api/getprofile/'));

   final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': '$token',
    };
    request.headers.addAll(headers);
    //  request.headers['Content-Type'] = 'multipart/form-data';
     request.fields['accno'] = accno.toString();

     var response = await request.send();
    if (response.statusCode == 200) {
     print('success profile');
     final body = await response.stream.bytesToString();
       final data = json.decode(body);
       print(data);
       print(data['maritalstatus']);
       
      _address.text=data['address'];
      _income.text=data['income'];
      imgurl=data['image'].toString() ; 
       setState(() {
          maritalstatus=data['maritalstatus'].toString() ; 
       });
       setState(() {
          dependants=data['dependants'].toString() ; 
       });
        setState(() {
          employmentstatus=data['employment'].toString() ; 
       });
         setState(() {
          graduationstatus=data['graduationstatus'].toString() ; 
       });
         setState(() {
          property=data['property'].toString(); 
       });
      //  _address=data['address'] .toString();  
      //  dependants ; 
      // employmentstatus ;   
      //  graduationstatus ; 
      //   property ;  
      //   _acctype ; 
        
    }
    else{
         ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Unable to load your profile...')),
    );
     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    UserHome()), (Route<dynamic> route) => false);
    }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Homeelements(),
      drawer:  Mydrawer(),
       bottomNavigationBar: Screen1(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              // SizedBox(
              //   width: 340,
              //    height: 60,
              //   child: Card(
              //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              //             child: TextFormField(
              //               controller: _fname,
                           
              //               decoration: InputDecoration(
              //                             border: OutlineInputBorder(
              //                               borderRadius: BorderRadius.circular(15)
              //                             ),
                                
              //               labelText: 'Legal First Name',
              //               prefixIcon: Icon(Icons.person_outlined)
              //             ),),
              //           ),
              // ),
              //  SizedBox(
              //   width: 340,
              //    height: 60,
              //   child: Card(
              //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              //             child: TextFormField(
              //               controller: _lname,
                           
              //               decoration: InputDecoration(
              //                             border: OutlineInputBorder(
              //                               borderRadius: BorderRadius.circular(15)
              //                             ),
                                
              //               labelText: 'Legal Last Name',
              //               prefixIcon: Icon(Icons.person)
              //             ),),
              //           ),
              // ),
            // Padding(
            //   padding: const EdgeInsets.only(left:50.0),
            //   child: Row(
            //     children: [
            //       Text('Gender: '),
            //       Radio(
            //     value: 0,
            //     groupValue: _gender,
            //     onChanged: (value) {
            //       setState(() {
            //         _gender = value;
            //       });
            //     },
            //   ),
            //   Text('Male'),
            //   Radio(
            //     value: 1,
            //     groupValue: _gender,
            //     onChanged: (value) {
            //       setState(() {
            //         _gender = value;
            //       });
            //     },
            //   ),
            //   Text('Female'),
            //       ],
            //   ),
            // ) ,
            // Padding(
            //   padding: const EdgeInsets.only(left: 50),
            //   child: Row(
            //     children: [
            //       Text('Date of Birth: '),
            //       TextButton.icon(
            //         onPressed: ()async {
            //           final selectedDateTemp=await showDatePicker(
                        
            //             context: context,
            //              initialDate: DateTime.now(),
            //               firstDate: DateTime(1900),
            //                lastDate: DateTime.now(),
            //                );
            //                if(selectedDateTemp==null){
            //                 return;
            //                }
            //                print(selectedDateTemp);
            //                setState(() {
            //                   _selectedDate=selectedDateTemp;
            //                });
                            

            //         },
            //          icon: Icon(Icons.calendar_today),
            //           label: Text(_selectedDate == null ? 'Select Date' : _selectedDate!.toString())),
            //     ],
            //   ),
            CircleAvatar(
  radius: 50,
  backgroundColor: Colors.grey[200], // set the background color to a light grey
  backgroundImage: NetworkImage(ip+'media/${imgurl}'),
  foregroundColor: Colors.white, // set the text and icon color to white
  child: Icon(Icons.person, size: 50), // add an icon in the center of the avatar
),
                // SizedBox(width: 4,),
                 SizedBox(
                width: 350,
                
                child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                           
                            controller: _address,
                           maxLines: 3,
                            decoration: InputDecoration(
                                        
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                
                            labelText: 'Address',
                            prefixIcon: Icon(Icons.home_outlined)
                          ),),
                        ),
              ),
              // SizedBox(height: 10,),
              Row(
                children: [
                  Text('       Marital status:           '),
                  SizedBox(
                    width: 200,
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                                border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: 300,
                          
                          child: DropdownButton<String>(
                            value: maritalstatus,
                            hint: Text('Marital status'),
                            //  disabledHint: Text('Marital status'),
                                  //  icon: const Icon(Icons.arrow_downward_outlined),
                              elevation: 16,
                               style: const TextStyle(color: Colors.deepPurple),
                          // underline: Container(
                          //   height: 2,
                          //   color: Colors.blueAccent,
                          // ),
                          items: <String>['Yes','No'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                             
                            );
                          }).toList(),
                          onChanged: (newvalue) {
                               setState(() {
                              maritalstatus = newvalue;
                                });
                          },
                                      ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 5,),
              // SizedBox(
              //   width: 340,
              //    height: 60,
              //   child: Card(
              //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              //             child: TextFormField(
              //               controller: _nameoffms,
                           
              //               decoration: InputDecoration(
              //                             border: OutlineInputBorder(
              //                               borderRadius: BorderRadius.circular(15)
              //                             ),
                                
              //               labelText: 'Name of father/mother/spouse',
              //               prefixIcon: Icon(Icons.man_rounded)
              //             ),),
              //           ),
              // ),
                //  SizedBox(height: 5,),
              Row(
                children: [
                  Text('           Depandants:          '),
                  SizedBox(
                    width: 200,
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                                border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: 300,
                          
                          child: DropdownButton<String>(
                            value: dependants,
                            hint: Text('Dependants'),
                            //  disabledHint: Text('Marital status'),
                                  //  icon: const Icon(Icons.arrow_downward_outlined),
                              elevation: 16,
                               style: const TextStyle(color: Colors.deepPurple),
                          // underline: Container(
                          //   height: 2,
                          //   color: Colors.blueAccent,
                          // ),
                          items: <String>['0','1','2','3+'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                             
                            );
                          }).toList(),
                          onChanged: (newvalue) {
                               setState(() {
                              dependants = newvalue;
                                });
                          },
                                      ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 5,),
              // SizedBox(
              //   width: 340,
              //   height: 60,
              //   child: Card(
              //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              //             child: TextFormField(
              //               controller: _nationality,
                           
              //               decoration: InputDecoration(
              //                             border: OutlineInputBorder(
              //                               borderRadius: BorderRadius.circular(15)
              //                             ),
                                
              //               labelText: 'Nationality',
              //               prefixIcon: Icon(Icons.flag_rounded)
              //             ),),
              //           ),
              // ),
              //  SizedBox(height: 5,),
                Row(
                  children: [
                    Text('  Self employment status:'),
                    SizedBox(
                      width: 200,
                      child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                                border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: 300,
                          
                          child: DropdownButton<String>(
                            value: employmentstatus,
                            hint: Text('Self Employed?'),
                            //  disabledHint: Text('Marital status'),
                                  //  icon: const Icon(Icons.arrow_downward_outlined),
                              elevation: 16,
                               style: const TextStyle(color: Colors.deepPurple),
                          // underline: Container(
                          //   height: 2,
                          //   color: Colors.blueAccent,
                          // ),
                          items: <String>['Yes','No'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                             
                            );
                          }).toList(),
                          onChanged: (newvalue) {
                               setState(() {
                              employmentstatus = newvalue;
                                });
                          },
                                      ),
                        ),
                      ),
                                  ),
                    ),
                  ],
                ),
              //  SizedBox(height: 5,),
              SizedBox(
                width: 340,
                 height: 60,
                child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: _income,
                           
                            decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                
                            labelText: 'Income',
                            prefixIcon: Icon(Icons.money_sharp)
                          ),),
                        ),
              ),
               Row(
                 children: [
                  Text('   Graduation status:        '),
                   SizedBox(
                    width: 200,
                     child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                                border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: 300,
                          
                          child: DropdownButton<String>(
                            value: graduationstatus,
                            hint: Text('Graduation status'),
                            //  disabledHint: Text('Marital status'),
                                  //  icon: const Icon(Icons.arrow_downward_outlined),
                              elevation: 16,
                               style: const TextStyle(color: Colors.deepPurple),
                          // underline: Container(
                          //   height: 2,
                          //   color: Colors.blueAccent,
                          // ),
                          items: <String>['Graduate','Not Graduate'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                             
                            );
                          }).toList(),
                          onChanged: (newvalue) {
                               setState(() {
                              graduationstatus = newvalue;
                                });
                          },
                                      ),
                        ),
                      ),
                                 ),
                   ),
                 ],
               ),
              Row(
                children: [
                  Text('         Property:                  '),
                  SizedBox(
                    width: 200,
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                                border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: 300,
                          
                          child: DropdownButton<String>(
                            value: property,
                            hint: Text('Property'),
                            //  disabledHint: Text('Marital status'),
                                  //  icon: const Icon(Icons.arrow_downward_outlined),
                              elevation: 16,
                               style: const TextStyle(color: Colors.deepPurple),
                          // underline: Container(
                          //   height: 2,
                          //   color: Colors.blueAccent,
                          // ),
                          items: <String>['Urban','Rural','Semiurban'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                             
                            );
                          }).toList(),
                          onChanged: (newvalue) {
                               setState(() {
                              property = newvalue;
                                });
                          },
                                      ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Card(
              //   child: Container(
              //     decoration: BoxDecoration(
              //             border: Border.all(
              //   color: Colors.grey,
              //   width: 1.0,
              //             ),
              //             borderRadius: BorderRadius.circular(8.0),
              //           ),
              //           padding: EdgeInsets.symmetric(horizontal: 16.0),
              //     child: SizedBox(
              //       width: 300,
                    
              //       child: DropdownButton<String>(
              //         value: _acctype,
              //         hint: Text('Account Type'),
              //         //  disabledHint: Text('Marital status'),
              //               //  icon: const Icon(Icons.arrow_downward_outlined),
              //           elevation: 16,
              //            style: const TextStyle(color: Colors.deepPurple),
              //       // underline: Container(
              //       //   height: 2,
              //       //   color: Colors.blueAccent,
              //       // ),
              //       items: <String>['Savings AC','Current AC','Term Deposit'].map((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text(value),
                       
              //         );
              //       }).toList(),
              //       onChanged: (newvalue) {
              //            setState(() {
              //           _acctype = newvalue;
              //             });
              //       },
              //                   ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   width: 340,
              //    height: 60,
              //   child: Card(
              //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              //             child: TextFormField(
              //               controller: _nomname,
                           
              //               decoration: InputDecoration(
              //                             border: OutlineInputBorder(
              //                               borderRadius: BorderRadius.circular(15)
              //                             ),
                                
              //               labelText: 'Nominee Name',
              //               prefixIcon: Icon(Icons.person_outlined)
              //             ),),
              //           ),
              // ),
              // SizedBox(
              //   width: 340,
               
              //   child: Card(
              //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              //             child: TextFormField(
              //               controller: _nomaddress,
              //              maxLines: 3,
              //               decoration: InputDecoration(
                                        
              //                             border: OutlineInputBorder(
              //                               borderRadius: BorderRadius.circular(15)
              //                             ),
                                
              //               labelText: 'Nominee Address',
              //               prefixIcon: Icon(Icons.home_outlined)
              //             ),),
              //           ),
              // ),
              // SizedBox(
              //   width: 340,
              //    height: 60,
              //   child: Card(
              //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              //             child: TextFormField(
              //               controller: _relation,
                           
              //               decoration: InputDecoration(
              //                             border: OutlineInputBorder(
              //                               borderRadius: BorderRadius.circular(15)
              //                             ),
                                
              //               labelText: 'Relationship',
              //               prefixIcon: Icon(Icons.connect_without_contact_rounded)
              //             ),),
              //           ),
              // ),
            
              // SizedBox(
              //   width: 340,
              //    height: 60,
              //   child: Card(
              //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              //             child: TextFormField(
              //               controller: _aadhar,
                           
              //               decoration: InputDecoration(
              //                             border: OutlineInputBorder(
              //                               borderRadius: BorderRadius.circular(15)
              //                             ),
                                
              //               labelText: 'Aadhar Number',
              //               prefixIcon: Icon(Icons.pin)
              //             ),),
              //           ),
              // ),  SizedBox(height: 10,),
              
              
               ElevatedButton.icon(
                icon: Icon(Icons.image_rounded),
                label: Text('Update Image'),
              onPressed: () {
                myAlert();
              },
              // child: Text('Upload Photo'),
            ),
            SizedBox(
              height: 10,
            ),
            //if image not null show the image
            //if image null show text
            image != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        //to show image, you type like this.
                        File(image!.path),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                      ),
                    ),
                  )
                : Text(
                    "No Image selected",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 4,)
              
              
              ,
              SizedBox(
                width: 332,
                height: 40,
                child: ElevatedButton(onPressed: (){
                          validateanduploadeditprofile();
               

                }, child: Text('Submit'))),
                 SizedBox(height: 20,),
            ],
            
          ),
        ),
      ),
    );
  }
}