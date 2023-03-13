
import 'dart:io';
import 'package:demoproject/Login_Screen.dart';
import 'package:demoproject/bottomnav.dart';
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

class Accountrequest extends StatefulWidget {
   Accountrequest({super.key});

  @override
  State<Accountrequest> createState() => _AccountrequestState();
}

class _AccountrequestState extends State<Accountrequest> {
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
        XFile? image;

  final ImagePicker picker = ImagePicker();

   validateandupload() async{
      final token = await storage.read(key: 'token');
      print(token);

    print(_selectedDate);
    if(_fname.text.toString() == null || _fname.text.toString().isEmpty ){
      ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter first name...')),
                
                );
    }
    else if(_lname.text.toString() == null || _lname.text.toString().isEmpty){
             ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter last name...')),
                
                );
    }
    else if( _selectedDate== null ||  _selectedDate.toString().isEmpty){
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select date of birth...')),
                 
                );
    }
    else if(_address.text.toString() == null || _address.text.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter address...')),
                
                );
    }
     else if(maritalstatus == null || maritalstatus.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select marital status...')),
                
                );
    }
    else if(_nameoffms.text.toString() == null || _nameoffms.text.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter name of father/mother/spouse...')),
                
                );
    }
     else if(dependants == null || dependants.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select depandants...')),
                
                );
    }
     else if(_nationality.text.toString() == null || _nationality.text.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter nationality...')),
                
                );
    }
     else if(employmentstatus == null || employmentstatus.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select employment status...')),
                
                );
    }
     else if(_income.text.toString() == null || _income.text.toString().isEmpty){
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
    else if(_acctype == null || _acctype.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select account type...')),
                
                );
    }
     else if(_nomname.text.toString() == null || _nomname.text.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter nominee name...')),
                
                );
    }
     else if(_nomaddress.text.toString() == null || _nomaddress.text.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter nominee address...')),
                
                );
    }
     else if(_relation.text.toString() == null || _relation.text.toString().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter relation to nominee...')),
                
                );
    }
     else if(_aadhar.text.toString() == null || _aadhar.text.toString().length !=12){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter valid aadhar...')),
                
                );
    }
    else if(image== null){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select image...')),
                
                );
    }
    else{
    //   final imageBytes = await image!.readAsBytes();
    //   final base64Image = base64Encode(imageBytes);
      
    //          final url = Uri.parse('http://192.168.43.210:8000/api/Accountrequest/');
    //           // final url = Uri.parse('http://10.0.2.2:8000/api/accountrequest/');  // replace with your own API endpoint
    // final body = jsonEncode({
    //   'fname': _fname.text.toString(),
    //   'lname':_lname.text.toString(),
    //   'gender': _gender.toString(),
    //   'dob':  _selectedDate.toString(),
    //   'address': _address.text.toString(),
    //   'marital_status':maritalstatus.toString(),
    //   'nameof_fms':_nameoffms.text.toString(),
    //   'dependants':dependants.toString(),
    //   'nation':_nationality.text.toString(),
    //   'employment':employmentstatus.toString(),
    //   'income':_income.text.toString(),
    //   'graduation':graduationstatus.toString(),
    //   'property':property.toString(),
    //   'account':_acctype.toString(),
    //   'nominee':_nomname.text.toString(),
    //   'nomaddress':_nomaddress.text.toString(),
    //   'relation':_relation.text.toString(),
    //   'aadhar':_aadhar.text.toString(),
    //   'image':base64Image
    // });
    // final headers = {'Content-Type': 'application/json', 'Authorization': '$token',};
    // final response = await http.post(url, body: body, headers: headers);
    //     // final response = await http.post(url, body: body,);
   var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.210:8000/api/accountrequest/'));
   final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': '$token',
    };
    request.headers.addAll(headers);
    //  request.headers['Content-Type'] = 'multipart/form-data';
     request.fields['fname'] = _fname.text.toString();
     request.fields['lname'] = _lname.text.toString();
     request.fields['gender'] = _gender.toString();
     request.fields['dob'] = _selectedDate.toString();
     request.fields['address'] = _address.text.toString();
     request.fields['marital_status'] = maritalstatus.toString();
     request.fields['nameof_fms'] = _nameoffms.text.toString();
     request.fields['dependants'] =dependants.toString();
     request.fields['nation'] = _nationality.text.toString();
     request.fields['employment'] = employmentstatus.toString();
     request.fields['income'] = _income.text.toString();
     request.fields['graduation'] =graduationstatus.toString();
     request.fields['property'] = property.toString();
     request.fields['account'] = _acctype.toString();
     request.fields['nominee'] =_nomname.text.toString();
     request.fields['nomaddress'] = _nomaddress.text.toString();
     request.fields['relation'] =_relation.text.toString();
      request.fields['aadhar'] =_aadhar.text.toString();
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
   var response = await request.send();
    if (response.statusCode == 200) {
     
      // print('success');
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Request Successfully send')),
    );
     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    UserHome()), (Route<dynamic> route) => false);
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
    else if(response.statusCode==409){
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Your previous request is already in pending....')),
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
    _selectedDate=null;
    maritalstatus = null;
    dependants=null;
    employmentstatus=null;
    property=null;
    _acctype=null;
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
              SizedBox(
                width: 340,
                 height: 60,
                child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: _fname,
                           
                            decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                
                            labelText: 'Legal First Name',
                            prefixIcon: Icon(Icons.person_outlined)
                          ),),
                        ),
              ),
               SizedBox(
                width: 340,
                 height: 60,
                child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: _lname,
                           
                            decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                
                            labelText: 'Legal Last Name',
                            prefixIcon: Icon(Icons.person)
                          ),),
                        ),
              ),
            Padding(
              padding: const EdgeInsets.only(left:50.0),
              child: Row(
                children: [
                  Text('Gender: '),
                  Radio(
                value: 0,
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
              Text('Male'),
              Radio(
                value: 1,
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
              Text('Female'),
                  ],
              ),
            ) ,
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  Text('Date of Birth: '),
                  TextButton.icon(
                    onPressed: ()async {
                      final selectedDateTemp=await showDatePicker(
                        
                        context: context,
                         initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                           lastDate: DateTime.now(),
                           );
                           if(selectedDateTemp==null){
                            return;
                           }
                           print(selectedDateTemp);
                           setState(() {
                              _selectedDate=selectedDateTemp;
                           });
                            

                    },
                     icon: Icon(Icons.calendar_today),
                      label: Text(_selectedDate == null ? 'Select Date' : _selectedDate!.toString())),
                ],
              ),
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
              Card(
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
              // SizedBox(height: 5,),
              SizedBox(
                width: 340,
                 height: 60,
                child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: _nameoffms,
                           
                            decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                
                            labelText: 'Name of father/mother/spouse',
                            prefixIcon: Icon(Icons.man_rounded)
                          ),),
                        ),
              ),
                //  SizedBox(height: 5,),
              Card(
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
              // SizedBox(height: 5,),
              SizedBox(
                width: 340,
                height: 60,
                child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: _nationality,
                           
                            decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                
                            labelText: 'Nationality',
                            prefixIcon: Icon(Icons.flag_rounded)
                          ),),
                        ),
              ),
              //  SizedBox(height: 5,),
                Card(
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
               Card(
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
              Card(
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
              Card(
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
                      value: _acctype,
                      hint: Text('Account Type'),
                      //  disabledHint: Text('Marital status'),
                            //  icon: const Icon(Icons.arrow_downward_outlined),
                        elevation: 16,
                         style: const TextStyle(color: Colors.deepPurple),
                    // underline: Container(
                    //   height: 2,
                    //   color: Colors.blueAccent,
                    // ),
                    items: <String>['Savings AC','Current AC','Term Deposit'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                       
                      );
                    }).toList(),
                    onChanged: (newvalue) {
                         setState(() {
                        _acctype = newvalue;
                          });
                    },
                                ),
                  ),
                ),
              ),
              SizedBox(
                width: 340,
                 height: 60,
                child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: _nomname,
                           
                            decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                
                            labelText: 'Nominee Name',
                            prefixIcon: Icon(Icons.person_outlined)
                          ),),
                        ),
              ),
              SizedBox(
                width: 340,
               
                child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: _nomaddress,
                           maxLines: 3,
                            decoration: InputDecoration(
                                        
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                
                            labelText: 'Nominee Address',
                            prefixIcon: Icon(Icons.home_outlined)
                          ),),
                        ),
              ),
              SizedBox(
                width: 340,
                 height: 60,
                child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: _relation,
                           
                            decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                
                            labelText: 'Relationship',
                            prefixIcon: Icon(Icons.connect_without_contact_rounded)
                          ),),
                        ),
              ),
            
              SizedBox(
                width: 340,
                 height: 60,
                child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: _aadhar,
                           
                            decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                
                            labelText: 'Aadhar Number',
                            prefixIcon: Icon(Icons.pin)
                          ),),
                        ),
              ),  SizedBox(height: 10,),
              
              
               ElevatedButton.icon(
                icon: Icon(Icons.image_rounded),
                label: Text('Upload Image'),
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
                          validateandupload();
               

                }, child: Text('Send Request'))),
                 SizedBox(height: 20,),
            ],
            
          ),
        ),
      ),
    );
  }
}