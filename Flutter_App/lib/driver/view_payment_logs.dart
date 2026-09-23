//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/driver/drhome.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// void main(){
//   runApp(view_payment_logs());
// }
// class view_payment_logs extends StatelessWidget {
//   const view_payment_logs({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: view_payment_logssub(),);
//   }
// }
//
// class view_payment_logssub extends StatefulWidget {
//   const view_payment_logssub({Key? key}) : super(key: key);
//
//   @override
//   State<view_payment_logssub> createState() => view_payment_logssubstate();
// }
//
// class view_payment_logssubstate extends State<view_payment_logssub> {
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String b = prefs.getString("lid").toString();
//     String foodimage="";
//     var data =
//     await http.post(Uri.parse(prefs.getString("ip").toString()+"/view_payment_logs"),
//         body: {"did":prefs.getString('did').toString()}
//     );
//
//     var jsonData = json.decode(data.body);
// //    print(jsonData);
//     List<Joke> jokes = [];
//     for (var joke in jsonData["message"]) {
//       print(joke);
//       Joke newJoke = Joke(
//           joke["id"].toString(),
//           joke["date"].toString(),
//           joke["USER"].toString(),
//           joke["amount"].toString(),
//           joke["extra_charge"].toString(),
//           joke["payment_status"].toString(),
//
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Payment Logs',
//           style: TextStyle(
//             color: Color(0xFFF57C00),
//             fontSize: 20,
//             fontWeight: FontWeight.w800,
//             letterSpacing: 1.5,
//             shadows: [
//               Shadow(
//                 color: Color(0xFFF57C00).withOpacity(0.8),
//                 blurRadius: 10,
//               ),
//             ],
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => drhome()),
//             );
//           },
//           icon: Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xFFF57C00).withOpacity(0.3),
//                   Color(0xFFF57C00),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Color(0xFFF57C00).withOpacity(0.5),
//                   blurRadius: 8,
//                   spreadRadius: 1,
//                 ),
//               ],
//             ),
//             child: Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//               size: 24,
//             ),
//           ),
//         ),
//         backgroundColor: Colors.black,
//         elevation: 0,
//       ),
//
//       body:
//     Container(
//
//       child:
//       FutureBuilder(
//         future: _getJokes(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
// //              print("snapshot"+snapshot.toString());
//           if (snapshot.data == null) {
//             return Container(
//               child: Center(
//                 child: Text("Loading..."),
//               ),
//             );
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (BuildContext context, int index) {
//                 var i = snapshot.data![index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       side: BorderSide(color: Colors.grey.shade300),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//
//                           SizedBox(height: 10),
//                           _buildRow("date:", i.date.toString()),
//                           _buildRow("USER:", i.USER.toString()),
//                           _buildRow("amount:", i.amount.toString()),
//                           _buildRow("extra_charge:", i.extra_charge.toString()),
//                           _buildRow("payment_status:", i.payment_status.toString()),
//
//
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//
//
//           }
//         },
//
//
//       ),
//
//
//
//
//
//     ),
//         );
//   }
//   Widget _buildRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 100,
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(width: 5),
//           Flexible(
//             child: Text(
//               value,
//               style: TextStyle(
//                 color: Colors.grey.shade800,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
// }
// class Joke {
//   final String id;
//   final String date;
//   final String USER;
//   final String amount;
//   final String extra_charge;
//   final String payment_status;
//
//
//
//
//
//
//   Joke(this.id, this.date, this.USER, this.amount, this.extra_charge, this.payment_status );
// //  print("hiiiii");
// }
//...........................
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickshaw_ride/driver/drhome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(view_payment_logs());
}

class view_payment_logs extends StatelessWidget {
  const view_payment_logs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: view_payment_logssub(),
    );
  }
}

class view_payment_logssub extends StatefulWidget {
  const view_payment_logssub({super.key});

  @override
  State<view_payment_logssub> createState() => view_payment_logssubstate();
}

class view_payment_logssubstate extends State<view_payment_logssub> {
  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String b = prefs.getString("lid").toString();
    String foodimage = "";
    var data = await http.post(
        Uri.parse("${prefs.getString("ip")}/view_payment_logs"),
        body: {"did": prefs.getString('did').toString()});

    var jsonData = json.decode(data.body);
    //    print(jsonData);
    List<Joke> jokes = [];
    for (var joke in jsonData["message"]) {
      print(joke);
      Joke newJoke = Joke(
        joke["id"].toString(),
        joke["date"].toString(),
        joke["USER"].toString(),
        joke["amount"].toString(),
        joke["extra_charge"].toString(),
        joke["payment_status"].toString(),
      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Logs',
          style: TextStyle(
            color: Color(0xFFFF8C42), // Warm orange
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            shadows: [
              Shadow(
                color: Color(0xFFFF8C42).withValues(alpha: 0.8),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => drhome()),
            );
          },
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFF8C42).withValues(alpha: 0.3), // Light orange
                  Color(0xFFFF5722), // Deep orange
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFF8C42).withValues(alpha: 0.5),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Color(0xFF121212), // Dark gray/black
            ],
          ),
        ),
        child: FutureBuilder(
          future: _getJokes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //              print("snapshot"+snapshot.toString());
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text(
                    "Loading...",
                    style: TextStyle(color: Color(0xFFFF8C42)), // Orange text
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var i = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      color: Color(0xFF1E1E1E), // Dark card background
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Color(0xFFFF8C42).withValues(alpha: 0.3)), // Orange border
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            _buildRow("date:", i.date.toString()),
                            _buildRow("USER:", i.USER.toString()),
                            _buildRow("amount:", i.amount.toString()),
                            _buildRow("extra_charge:", i.extra_charge.toString()),
                            _buildRow("payment_status:", i.payment_status.toString()),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF8C42), // Orange label
              ),
            ),
          ),
          SizedBox(width: 5),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white70, // Light text for dark background
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Joke {
  final String id;
  final String date;
  final String USER;
  final String amount;
  final String extra_charge;
  final String payment_status;

  Joke(this.id, this.date, this.USER, this.amount, this.extra_charge,
      this.payment_status);
//  print("hiiiii");
}