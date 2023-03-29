import 'dart:async';
import 'package:demoproject/ip.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class AuctionScreen extends StatefulWidget {
  final int auctionid;
  final int custchitid;
  final String auction_name;
  final String auction_amount;
  const AuctionScreen(
      this.custchitid, this.auction_name, this.auction_amount, this.auctionid);
  @override
  _AuctionScreenState createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  Timer? _timer;
  int _secondsRemaining = 120; // 0.5 hours = 1800 seconds
  String _maxBidAmount = "";
  TextEditingController _amountController = TextEditingController();
  List<dynamic>? myList;
  // ValueNotifier<List<String>> bidAmountData = ValueNotifier([]);
  List<Bid> updatedBids = [];
  ValueNotifier<List<Bid>> bidAmountData = ValueNotifier([]);

  @override
  void initState() {
    print(widget.auction_name);
    print(widget.auction_amount);
    print(widget.custchitid);
    print(widget.auctionid);

    super.initState();
    myList = [];
    startTimer();
    startBidAmountUpdater();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          timer.cancel();
          Navigator.pop(context);
          // Terminate the auction screen here
        }
      });
    });
  }

  bidamount() async {
    print("entered bid");
    if (_amountController.text.toString() == "null" ||
        _amountController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Amount field cant be empty...')),
      );
    } else {
      var request =
          http.MultipartRequest('POST', Uri.parse(ip + 'api/submitbid/'));

      final Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        // 'Authorization': '$token',
      };
      // request.headers.addAll(headers);
      request.fields['custchitid'] = widget.custchitid.toString();
      request.fields['auctionid'] = widget.auctionid.toString();
      request.fields['amount'] = _amountController.text.toString();

      var response = await request.send();
      final body = await response.stream.bytesToString();
      final data = json.decode(body);
      print(data);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully Posted your bid...')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post amount...')),
        );
      }
    }
  }

  void startBidAmountUpdater() async {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      var request =
          http.MultipartRequest('POST', Uri.parse(ip + 'api/auctionupdate/'));

      final Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        // 'Authorization': '$token',
      };

      var response = await request.send();
      final body = await response.stream.bytesToString();
      final data = json.decode(body);

      print(data);
      // bidAmountData
      //.value = data['bidamount'];
      print("%%%");

      final bidsData = data['bidamount'] as List<dynamic>;
      final bids = bidsData
          .map((bidData) => Bid(
                auction_id_id: bidData['auction_id_id'],
                cust_chitid_id: bidData['cust_chitid_id'],
                amount: double.parse(bidData['amount'].toString()),
              ))
          .toList();

      setState(() {
        updatedBids = bids;
        bidAmountData.value = bids;
      });
      // print(bidAmountData.value);
      // setState(() {
      //  myList=data['bidamount'];
      //  print(myList);
    });
  }

  String formatDuration(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auction Screen'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 15, right: 15),
                child: Card(
                  elevation: 10.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Text(
                            //   'Auction Name',
                            //   style: TextStyle(
                            //     fontSize: 24.0,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.black,
                            //   ),
                            // ),
                            SizedBox(width: 8.0),
                            Text(
                              widget.auction_name,
                              style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 25, 144, 241),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 20.0,
                          thickness: 3.0,
                          color: Colors.black,
                        ),
                        SizedBox(height: 8.0),
                        SizedBox(height: 12.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.currency_rupee_outlined,
                                color: Colors.blue),
                            Text(
                              'Starting Bid',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              '\$${widget.auction_amount}',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.date_range, color: Colors.blue),
                              Text(
                                'Auction Date',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                DateTime.now().toString().substring(0, 10),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ]),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.timer, color: Colors.blue),
                            Text(
                              'Auction Time',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              '2:00 PM',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Divider(
                          height: 20.0,
                          thickness: 3.0,
                          color: Colors.black,
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.person_rounded, color: Colors.blue),
                            Text(
                              'Customer ID',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              '${widget.custchitid}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Card(
                  elevation: 4,
                  color: _secondsRemaining <= 60
                      ? Colors.red[100]
                      : Colors.blue[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: _secondsRemaining <= 60
                              ? Colors.red[900]
                              : Colors.blue[900],
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Time remaining: ${formatDuration(_secondsRemaining)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _secondsRemaining <= 60
                                ? Colors.red[900]
                                : Colors.blue[900],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 5),
              // Text('Maximum bid amount: $_maxBidAmount'),
              Card(
                elevation: 20.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter amount',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        width: 80.0,
                        child: ElevatedButton(
                          onPressed: () {
                            bidamount();
                          },
                          child: Text('Bid'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

// Expanded(
//   child:   RepaintBoundary(
//     child: ValueListenableBuilder<List<dynamic>>(

//       valueListenable: bidAmountData,

//       builder: (context, myList1, _) {

//         return ListView.builder(

//           itemCount: myList1.length,

//           itemBuilder: (context, index) {

//             final bidAmount = myList1[index];

//             return ListTile(

//               title: Text(bidAmount['amount']),

//               subtitle: Text(bidAmount['cust_chitid_id']),

//             );

//           },

//         );

//       },

//     ),
//   ),
// ),
              SizedBox(height: 16),
// Card(
//             elevation: 4,
//             child: ListTile(
//               leading: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ListTile(

//               title: Text("1"),

//               subtitle: Text("1"),
//                   ),
//                   ListTile(

//               title: Text("2"),

//               subtitle: Text("2"),
//                   ),
//                   ListTile(

//               title: Text("3"),

//               subtitle: Text("3"),
//                   )
//                 ]

//               )
//               )
//               )
              SizedBox(height: 16),
               Text(
            'Current highest bids:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
             SizedBox(
  width: 350,
  height: 200,
  child: RepaintBoundary(
    child: ValueListenableBuilder<List<Bid>>(
      valueListenable: bidAmountData,
      builder: (context, updatedBids, _) {
        return ListView.builder(
          itemCount: updatedBids.length,
          itemBuilder: (context, index) {
            final bid = updatedBids[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  bid.amount.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Cust Chit ID: ${bid.cust_chitid_id.toString()}',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            );
          },
        );
      },
    ),
  ),
),


            ],
          ),
        ),
      ),
    );
  }
}

class Bid {
  final int auction_id_id;
  final int cust_chitid_id;
  final double amount;

  Bid({
    required this.auction_id_id,
    required this.cust_chitid_id,
    required this.amount,
  });
}
