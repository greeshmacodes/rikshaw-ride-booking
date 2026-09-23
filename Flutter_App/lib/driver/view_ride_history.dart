// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/driver/drhome.dart';
// import 'package:rickshaw_ride/driver/report_user.dart';
// import 'package:rickshaw_ride/user/report_driver.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// void main(){
//   runApp(view_ride_history());
// }
// class view_ride_history extends StatelessWidget {
//   const view_ride_history({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: view_ride_historysub(),);
//   }
// }
//
// class view_ride_historysub extends StatefulWidget {
//   const view_ride_historysub({Key? key}) : super(key: key);
//
//   @override
//   State<view_ride_historysub> createState() => view_ride_historysubstate();
// }
//
// class view_ride_historysubstate extends State<view_ride_historysub> {
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String b = prefs.getString("lid").toString();
//     String foodimage="";
//     var data =
//     await http.post(Uri.parse(prefs.getString("ip").toString()+"/view_ride_history"),
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
//           joke["from_latitude"].toString(),
//           joke["from_longitude"].toString(),
//           joke["to_longitude"].toString(),
//           joke["to_latitude"].toString(),
//           joke["USER"].toString(),
//           joke["amount"].toString(),
//           joke["extra_charge"].toString(),
//           joke["payment_status"].toString(),
//           joke["status"].toString(),
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'RIDE HISTORY',
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
//       body: Container(
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
//                           _buildRow("Date:", i.date.toString()),
//                           _buildRow("from_latitude:", i.from_latitude.toString()),
//                           _buildRow("from_longitude:", i.from_longitude.toString()),
//                           _buildRow("to_longitude:", i.to_longitude.toString()),
//                           _buildRow("to_latitude:", i.to_latitude.toString()),
//                           _buildRow("USER:", i.USER.toString()),
//                           _buildRow("amount:", i.amount.toString()),
//                           _buildRow("extra_charge:", i.extra_charge.toString()),
//                           _buildRow("payment_status:", i.payment_status.toString()),
//                           _buildRow("status:", i.status.toString()),
//                           Row(children: [
//                             ElevatedButton(onPressed: () async {
//                               SharedPreferences sh=await SharedPreferences.getInstance();
//                               sh.setString('reqid', i.id.toString());
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>report_user()));
//                             }, child: Text('Report'))
//                           ],)
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
//     ),);
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
// }
// class Joke {
//   final String id;
//   final String date;
//   final String from_latitude;
//   final String from_longitude;
//   final String to_longitude;
//   final String to_latitude;
//   final String USER;
//   final String amount;
//   final String payment_status;
//   final String extra_charge;
//   final String status;
//
//
//   Joke(this.id, this.date, this.from_latitude, this.from_longitude, this.to_longitude, this.to_latitude, this.USER, this.amount, this.payment_status, this.extra_charge, this.status);
// //  print("hiiiii");
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickshaw_ride/driver/drhome.dart';
import 'package:rickshaw_ride/driver/report_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(view_ride_history());
}

class view_ride_history extends StatelessWidget {
  const view_ride_history({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFF57C00),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(0xFFF57C00, {
            50: Color(0xFFFFF3E0),
            100: Color(0xFFFFE0B2),
            200: Color(0xFFFFCC80),
            300: Color(0xFFFFB74D),
            400: Color(0xFFFFA726),
            500: Color(0xFFF57C00),
            600: Color(0xFFFB8C00),
            700: Color(0xFFF57C00),
            800: Color(0xFFEF6C00),
            900: Color(0xFFE65100),
          }),
        ),
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Color(0xFFF57C00),
          elevation: 2,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
      home: view_ride_historysub(),
    );
  }
}

class view_ride_historysub extends StatefulWidget {
  const view_ride_historysub({super.key});

  @override
  State<view_ride_historysub> createState() => view_ride_historysubstate();
}

class view_ride_historysubstate extends State<view_ride_historysub> {
  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await http.post(
        Uri.parse("${prefs.getString("ip")}/view_ride_history"),
        body: {"did": prefs.getString('did').toString()}
    );

    var jsonData = json.decode(data.body);
    List<Joke> jokes = [];
    for (var joke in jsonData["message"]) {
      Joke newJoke = Joke(
        joke["id"].toString(),
        joke["date"].toString(),
        joke["from_latitude"].toString(),
        joke["from_longitude"].toString(),
        joke["to_longitude"].toString(),
        joke["to_latitude"].toString(),
        joke["USER"].toString(),
        joke["amount"].toString(),
        joke["extra_charge"].toString(),
        joke["payment_status"].toString(),
        joke["status"].toString(),
        joke["ride_status"].toString(),

      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  Color _getStatusColor(String status) {
    switch(status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch(status.toLowerCase()) {
      case 'completed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      case 'pending':
        return Icons.pending;
      default:
        return Icons.help;
    }
  }

  String _getPaymentStatusText(String status) {
    if (status.toLowerCase() == 'paid') {
      return 'PAID';
    } else if (status.toLowerCase() == 'pending') {
      return 'PENDING';
    } else {
      return status.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'RIDE HISTORY',
          style: TextStyle(
            color: Color(0xFFF57C00),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
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
                  Color(0xFFF57C00).withValues(alpha: 0.3),
                  Color(0xFFF57C00),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFF57C00).withValues(alpha: 0.5),
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
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Color(0xFFF57C00)),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade50,
              Colors.grey.shade100,
            ],
          ),
        ),
        child: FutureBuilder(
          future: _getJokes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Color(0xFFF57C00),
                      strokeWidth: 3,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Loading ride history...",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red.shade400,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Error loading ride history",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(Icons.refresh),
                      label: Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF57C00),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF57C00).withValues(alpha: 0.1),
                      ),
                      child: Icon(
                        Icons.history,
                        size: 60,
                        color: Color(0xFFF57C00).withValues(alpha: 0.5),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "No Ride History",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Your completed rides will appear here",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var i = snapshot.data![index];
                  return _buildRideCard(i, index);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildRideCard(Joke ride, int index) {
    Color statusColor = _getStatusColor(ride.status);
    IconData statusIcon = _getStatusIcon(ride.status);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.grey.shade50,
              ],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with user and date
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFF57C00).withValues(alpha: 0.2),
                            Color(0xFFF57C00).withValues(alpha: 0.4),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          ride.USER[0].toUpperCase(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF57C00),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ride.USER,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(width: 4),
                              Text(
                                ride.date,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, size: 14, color: statusColor),
                          SizedBox(width: 4),
                          Text(
                            ride.status.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Amount and Payment Status
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Fare",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "₹ ${ride.amount}",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF57C00),
                                ),
                              ),
                              if (ride.extra_charge != '0')
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "+ ₹${ride.extra_charge}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: ride.payment_status.toLowerCase() == 'paid'
                              ? Colors.green.withValues(alpha: 0.1)
                              : Colors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              ride.payment_status.toLowerCase() == 'paid'
                                  ? Icons.payment
                                  : Icons.pending,
                              size: 14,
                              color: ride.payment_status.toLowerCase() == 'paid'
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                            SizedBox(width: 4),
                            Text(
                              _getPaymentStatusText(ride.payment_status),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: ride.payment_status.toLowerCase() == 'paid'
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ADDED: Ride Status Section
                if (ride.ride_status.isNotEmpty) ...[
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.directions_car, size: 18, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          "Ride Status: ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ride.ride_status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                SizedBox(height: 16),

                // Location Details
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildLocationRow(
                        icon: Icons.my_location,
                        label: "From",
                        lat: ride.from_latitude,
                        lng: ride.from_longitude,
                      ),
                      SizedBox(height: 8),
                      _buildLocationRow(
                        icon: Icons.location_on,
                        label: "To",
                        lat: ride.to_latitude,
                        lng: ride.to_longitude,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Report Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      SharedPreferences sh = await SharedPreferences.getInstance();
                      sh.setString('reqid', ride.id.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => report_user())
                      );
                    },
                    icon: Icon(Icons.report_problem, size: 18),
                    label: Text(
                      'REPORT USER',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),

                SizedBox(height: 8),

                // Back to Home Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => drhome()),
                      );
                    },
                    icon: Icon(Icons.home, size: 18),
                    label: Text(
                      'BACK TO HOME',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Color(0xFFF57C00),
                      side: BorderSide(color: Color(0xFFF57C00)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationRow({
    required IconData icon,
    required String label,
    required String lat,
    required String lng,
  }) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Color(0xFFF57C00).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFFF57C00), size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "$lat, $lng",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
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
                color: Colors.grey.shade700,
              ),
            ),
          ),
          SizedBox(width: 5),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey.shade800,
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
  final String from_latitude;
  final String from_longitude;
  final String to_longitude;
  final String to_latitude;
  final String USER;
  final String amount;
  final String extra_charge;
  final String payment_status;
  final String status;
  final String ride_status;

  Joke(
      this.id,
      this.date,
      this.from_latitude,
      this.from_longitude,
      this.to_longitude,
      this.to_latitude,
      this.USER,
      this.amount,
      this.extra_charge,
      this.payment_status,
      this.status,
      this.ride_status
      );
}