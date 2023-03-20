import 'dart:io';
import 'package:demoproject/bottomnav.dart';
import 'package:demoproject/drawer.dart';
import 'package:demoproject/homeelements.dart';
import 'package:demoproject/ip.dart';
import 'package:demoproject/userdash.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Kyc extends StatefulWidget {
  const Kyc({Key? key}) : super(key: key);

  @override
  _KycState createState() => _KycState();
}

class _KycState extends State<Kyc> {
    final storage = FlutterSecureStorage();

  FilePickerResult? result;
  FilePickerResult? result2;
  File? uploadDocument;
  String documentPath = '';
  File? uploadDocument2;
  String documentPath2 = '';

  Future<void> pickFile() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        uploadDocument = File(result!.files.single.path!);
        // Do something with the file...
      });
    } else {
      print("No file selected");
    }
  }
  Future<void> pickFile2() async {
    result2 = await FilePicker.platform.pickFiles();

    if (result2 != null) {
      setState(() {
        uploadDocument2 = File(result2!.files.single.path!);
        // Do something with the file...
      });
    } else {
      print("No file selected");
    }
  }

  Future<void> uploadDocumentToServer() async {
    // if (uploadDocument == null || uploadDocument2 == null) {
    //   // No file selected
    //   return;
    // }
          final token = await storage.read(key: 'token');
           final accno = await storage.read(key: 'accno');

    var request = http.MultipartRequest('POST', Uri.parse(ip+'api/kycupload/'));
   final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': '$token',
    'accno': '$accno'
    };
    request.headers.addAll(headers);
    // request.files.add(await http.MultipartFile.fromPath(
    //     'document', uploadDocument!.path));

   List<int> docBytes = await uploadDocument!.readAsBytes();
  
  // Extract the file name from the path
     String fileName = uploadDocument!.path.split('/').last;
  
  // Create the multipart file

    

    var docFile= http.MultipartFile.fromBytes(
    'doc', // field name
    docBytes, // file content
    filename: fileName,
  );
  List<int> docBytes2 = await uploadDocument2!.readAsBytes();
  
  // Extract the file name from the path
     String fileName2 = uploadDocument2!.path.split('/').last;
  
  // Create the multipart file

    

    var docFile2= http.MultipartFile.fromBytes(
    'doc2', // field name
    docBytes2, // file content
    filename: fileName2,
  );
  request.files.add(docFile);
  request.files.add(docFile2);

    final response = await request.send();

    if (response.statusCode == 200) {
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Documents uploaded successfully....')),
    );
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    UserHome()), (Route<dynamic> route) => false);
      // File uploaded successfully
      
    } 
    else if(response.statusCode == 204) {
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You where already uploaded....')),
    );
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) =>
    UserHome()), (Route<dynamic> route) => false);
      
    }
    else{
        ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Something went wrong please try again later....')),
    );
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    drawer: Mydrawer(),
    backgroundColor: Colors.white,
    appBar: Homeelements(),
    bottomNavigationBar: Screen1(),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
        child: Card(
          elevation: 15,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/kycdoc.png'),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: Text(
                    'Upload KYC Document',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.file_open_outlined),
                    onPressed: () {
                      pickFile();
                    },
                    label: Text(
                      'Choose KYC document file',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: Colors.grey,
                      elevation: 5,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                if (uploadDocument != null)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          'Selected file: ${uploadDocument!.path}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                                    SizedBox(height: 10),
    
                      Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.file_present_outlined),
                    onPressed: () {
                      pickFile2();
                    },
                    label: Text(
                      'Choose proof of identity',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: Colors.grey,
                      elevation: 5,
                    ),
                  ),
                ),
                              SizedBox(height: 10),
    
                              if (uploadDocument2 != null)
    
                 Column(
                   children: [
                     Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                              'Selected file: ${uploadDocument2!.path}',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                   ],
                 ),
                      SizedBox(height: 10),
                       if (uploadDocument2 != null || uploadDocument2 != null )
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.file_upload_rounded),
                          onPressed: () {
                            uploadDocumentToServer();
                          },
                          label: Text(
                            'Upload File',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.purpleAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            shadowColor: Colors.grey,
                            elevation: 5,
                          ),
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
