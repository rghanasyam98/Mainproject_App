import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';





class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
 
   
class _HomeState extends State<Home> {
   final storage = const FlutterSecureStorage();
  String myValue = '';
    
   
    
  @override
  void initState() {
    print("init");
    // TODO: implement initState
    super.initState();
     _loadValue();
  }
  Future<void> _loadValue() async {
    print("loadvalue");
   String? usernameValue = await storage.read(key:'usermail');
    print(usernameValue);
      myValue = usernameValue ?? 'default value';
  
  }
  @override
  void handleClick(int item) {
  // switch (item) {
  //   case 0:
  //     break;
  //   case 1:
  //     break;
  // }
  // if(item==0){

  // }
  userlogout();
}

Future<void> userlogout() async {
  final url = Uri.parse('http://10.0.2.2:8000/api/userlogout/');
  final token = await storage.read(key: 'token');
 
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json','Authorization': '$token'},
  );
  
  if (response.statusCode == 200) {
    // User has been logged out successfully
    await storage.delete(key: 'auth_token'); // Clear the token from storage
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/login',
      (Route<dynamic> route) => false,
    ); // Navigate to login screen
  } else {
    // There was an error logging out the user
  }
}


  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Smart Bank'),
       actions: [IconButton(
            icon: Icon(Icons.logout),
            onPressed: userlogout,
          ),],
    // actions: <Widget>[
    //   PopupMenuButton<int>(
    //       onSelected: (item) => handleClick(item),
    //       itemBuilder: (context) => [
    //         PopupMenuItem<int>(value: 0, child: Text('Logout')),
    //         // PopupMenuItem<int>(value: 1, child: Text('Settings')),
    //       ],
    //     ),
    // ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(myValue),
              accountEmail: Text(myValue,style: TextStyle(fontSize: 16)),
              currentAccountPicture: CircleAvatar(
                // backgroundImage: NetworkImage(
                //     "https://www.pexels.com/photo/india-rupee-banknote-904735/"),
                backgroundImage: AssetImage('assets/images/pexels-photo-904735.jpeg'),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(

                  image:  AssetImage('assets/images/pexels-photo-904735.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
              // otherAccountsPictures: [
              //   CircleAvatar(
              //     backgroundColor: Colors.white,
              //     // backgroundImage: NetworkImage(
              //     //     "https://randomuser.me/api/portraits/women/74.jpg"),
              //   ),
              //   CircleAvatar(
              //     backgroundColor: Colors.white,
              //     // backgroundImage: NetworkImage(
              //     //     "https://randomuser.me/api/portraits/men/47.jpg"),
              //   ),
              // ],
            ),
            ListTile(
              
              leading: Icon(Icons.person),
              title: Text("Account"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.money),
              title: Text("Loans"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.attach_money_outlined),
              title: Text("Chits"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.gamepad_outlined),
              title: Text("Auction"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.document_scanner_rounded),
              title: Text("KYC management"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.new_releases),
              title: Text("News"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.balance_outlined),
              title: Text("Balance enquiry"),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
  }

