// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/driver/chat.dart';
// import 'package:rickshaw_ride/driver/drhome.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
// void main(){
//   runApp(view_passenger_request());
// }
// class view_passenger_request extends StatelessWidget {
//   const view_passenger_request({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: view_passenger_requestsub(),);
//   }
// }
//
// class view_passenger_requestsub extends StatefulWidget {
//   const view_passenger_requestsub({Key? key}) : super(key: key);
//
//   @override
//   State<view_passenger_requestsub> createState() => view_passenger_requestsubstate();
// }
//
// class view_passenger_requestsubstate extends State<view_passenger_requestsub> {
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String b = prefs.getString("lid").toString();
//     String foodimage="";
//     var data =
//     await http.post(Uri.parse(prefs.getString("ip").toString()+"/view_passengers_requst"),
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
//           joke["USER"].toString(),
//           joke["date"].toString(),
//           joke["from_latitude"].toString(),
//           joke["from_longitude"].toString(),
//           joke["to_latitude"].toString(),
//           joke["to_longitude"].toString(),
//           joke["amount"].toString(),
//           joke["userid"].toString(),
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
//           'PASSENGER REQUEST',
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
//                           _buildRow("USER:", i.USER.toString()),
//                           _buildRow("date:", i.date.toString()),
//                           // _buildRow("from_latitude:", i.from_latitude.toString()),
//                           // _buildRow("from_longitude:", i.from_longitude.toString()),
//                           // _buildRow("to_latitude:", i.to_latitude.toString()),
//                           // _buildRow("to_longitude:", i.to_longitude.toString()),
//                           _buildRow("amount:", i.amount.toString()),
//                           _buildRow("Phone:", i.userid.toString()),
//                           Row(children: [
//                             ElevatedButton(onPressed: () async {
//                               final String ipfsUrl = "https://www.google.com/maps/?q=${i.from_latitude.toString()},${i.from_longitude.toString()}";
//
//                               final Uri uri = Uri.parse(ipfsUrl);
//
//                               if (await canLaunchUrl(uri)) {
//                                 // 🚀 Launch the URL in an external application (e.g., browser, PDF viewer)
//                                 await launchUrl(uri, mode: LaunchMode.externalApplication);
//                               } else {
//                                 // ⚠️ Handle the error gracefully (you can also show a toast/snackbar)
//                                 throw '❌ Could not launch $ipfsUrl';
//                               }
//                             }, child: Text('Check from location')),SizedBox(width: 20,),
//                             ElevatedButton(onPressed: () async {
//                               final String ipfsUrl = "https://www.google.com/maps/?q=${i.to_latitude.toString()},${i.to_longitude.toString()}";
//
//                               final Uri uri = Uri.parse(ipfsUrl);
//
//                               if (await canLaunchUrl(uri)) {
//                                 // 🚀 Launch the URL in an external application (e.g., browser, PDF viewer)
//                                 await launchUrl(uri, mode: LaunchMode.externalApplication);
//                               } else {
//                                 // ⚠️ Handle the error gracefully (you can also show a toast/snackbar)
//                                 throw '❌ Could not launch $ipfsUrl';
//                               }
//                             }, child: Text('Check to location')),SizedBox(width: 20,),
//                             ElevatedButton(onPressed: () async {
//                               SharedPreferences sh=await SharedPreferences.getInstance();
//                               var data=await http.post(Uri.parse('${sh.getString('ip')}/accept_passenger_request'),
//                               body: {
//                                 'id':i.id.toString()
//                               });
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>view_passenger_request()));
//                             }, child: Text('Accept')),
//
//                             ElevatedButton(onPressed: () async {
//                               SharedPreferences sh=await SharedPreferences.getInstance();
//                               var data=await http.post(Uri.parse('${sh.getString('ip')}/reject_passenger_request'),
//                                   body: {
//                                     'id':i.id.toString()
//                                   });
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>view_passenger_request()));
//
//                             }, child: Text('reject')),
//                             ElevatedButton(onPressed: () async {
//                               SharedPreferences sh=await SharedPreferences.getInstance();
//                               sh.setString('userid', i.userid.toString());
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>MyChatApp()));
//                             }, child: Text('Messages'))
//
//                           ],)
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
//   final String USER;
//   final String date;
//   final String from_latitude;
//   final String from_longitude;
//   final String to_latitude;
//   final String to_longitude;
//   final String amount;
//   final String userid;
//
//
//   Joke(this.id, this.USER, this.date, this.from_latitude, this.from_longitude, this.to_latitude, this.to_longitude, this.amount, this.userid);
// //  print("hiiiii");
// }

//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/driver/chat.dart';
// import 'package:rickshaw_ride/driver/drhome.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(view_passenger_request());
// }
//
// class view_passenger_request extends StatelessWidget {
//   const view_passenger_request({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: const Color(0xFFF57C00),
//         colorScheme: ColorScheme.fromSwatch(
//           primarySwatch: MaterialColor(0xFFF57C00, {
//             50: Color(0xFFFFF3E0),
//             100: Color(0xFFFFE0B2),
//             200: Color(0xFFFFCC80),
//             300: Color(0xFFFFB74D),
//             400: Color(0xFFFFA726),
//             500: Color(0xFFF57C00),
//             600: Color(0xFFFB8C00),
//             700: Color(0xFFF57C00),
//             800: Color(0xFFEF6C00),
//             900: Color(0xFFE65100),
//           }),
//         ),
//         scaffoldBackgroundColor: Colors.grey.shade50,
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.black,
//           foregroundColor: Color(0xFFF57C00),
//           elevation: 2,
//           centerTitle: true,
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           ),
//         ),
//       ),
//       home: view_passenger_requestsub(),
//     );
//   }
// }
//
// class view_passenger_requestsub extends StatefulWidget {
//   const view_passenger_requestsub({Key? key}) : super(key: key);
//
//   @override
//   State<view_passenger_requestsub> createState() => view_passenger_requestsubstate();
// }
//
// class view_passenger_requestsubstate extends State<view_passenger_requestsub> {
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var data = await http.post(
//         Uri.parse(prefs.getString("ip").toString() + "/view_passengers_requst"),
//         body: {"did": prefs.getString('did').toString()}
//     );
//
//     var jsonData = json.decode(data.body);
//     List<Joke> jokes = [];
//     for (var joke in jsonData["message"]) {
//       Joke newJoke = Joke(
//         joke["id"].toString(),
//         joke["USER"].toString(),
//         joke["date"].toString(),
//         joke["from_latitude"].toString(),
//         joke["from_longitude"].toString(),
//         joke["to_latitude"].toString(),
//         joke["to_longitude"].toString(),
//         joke["amount"].toString(),
//         joke["userid"].toString(),
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }
//
//   Future<void> _acceptRequest(String id) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     var data = await http.post(
//         Uri.parse('${sh.getString('ip')}/accept_passenger_request'),
//         body: {'id': id}
//     );
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Request accepted successfully'),
//         backgroundColor: Colors.green,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//
//     setState(() {});
//   }
//
//   Future<void> _rejectRequest(String id) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     var data = await http.post(
//         Uri.parse('${sh.getString('ip')}/reject_passenger_request'),
//         body: {'id': id}
//     );
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Request rejected'),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//
//     setState(() {});
//   }
//
//   Future<void> _openChat(String userId) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     sh.setString('userid', userId);
//     Navigator.push(context, MaterialPageRoute(builder: (context) => MyChatApp()));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       appBar: AppBar(
//         title: Text(
//           'PASSENGER REQUESTS',
//           style: TextStyle(
//             color: Color(0xFFF57C00),
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1,
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
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh, color: Color(0xFFF57C00)),
//             onPressed: () {
//               setState(() {});
//             },
//           ),
//         ],
//         backgroundColor: Colors.black,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.grey.shade50,
//               Colors.grey.shade100,
//             ],
//           ),
//         ),
//         child: FutureBuilder(
//           future: _getJokes(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircularProgressIndicator(
//                       color: Color(0xFFF57C00),
//                       strokeWidth: 3,
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "Loading passenger requests...",
//                       style: TextStyle(
//                         color: Colors.grey.shade600,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.error_outline,
//                       size: 60,
//                       color: Colors.red.shade400,
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "Error loading requests",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey.shade800,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton.icon(
//                       onPressed: () {
//                         setState(() {});
//                       },
//                       icon: Icon(Icons.refresh),
//                       label: Text('Retry'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFFF57C00),
//                         foregroundColor: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (!snapshot.hasData || snapshot.data.isEmpty) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Color(0xFFF57C00).withOpacity(0.1),
//                       ),
//                       child: Icon(
//                         Icons.notifications_none,
//                         size: 60,
//                         color: Color(0xFFF57C00).withOpacity(0.5),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "No Passenger Requests",
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey.shade700,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       "New ride requests will appear here",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               return ListView.builder(
//                 padding: EdgeInsets.all(16),
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   var i = snapshot.data![index];
//                   return _buildRequestCard(i, index);
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRequestCard(Joke request, int index) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade200,
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.white,
//                 Colors.grey.shade50,
//               ],
//             ),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header with user info
//                 Row(
//                   children: [
//                     Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Color(0xFFF57C00).withOpacity(0.2),
//                             Color(0xFFF57C00).withOpacity(0.4),
//                           ],
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Center(
//                         child: Text(
//                           request.USER[0].toUpperCase(),
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFFF57C00),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             request.USER,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey.shade800,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.calendar_today,
//                                 size: 14,
//                                 color: Colors.grey.shade500,
//                               ),
//                               SizedBox(width: 4),
//                               Text(
//                                 request.date,
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.grey.shade600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.blue.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(color: Colors.blue.withOpacity(0.3)),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.phone, size: 12, color: Colors.blue),
//                           SizedBox(width: 4),
//                           Text(
//                             request.userid,
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.blue,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 16),
//
//                 // Amount and Location Summary
//                 Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Trip Amount",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey.shade600,
//                             ),
//                           ),
//                           Text(
//                             "₹ ${request.amount}",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFFF57C00),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: Colors.orange.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           'Request #${index + 1}',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFFF57C00),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 16),
//
//                 // Location Buttons
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildLocationButton(
//                         icon: Icons.my_location,
//                         label: "From",
//                         latitude: request.from_latitude,
//                         longitude: request.from_longitude,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: _buildLocationButton(
//                         icon: Icons.location_on,
//                         label: "To",
//                         latitude: request.to_latitude,
//                         longitude: request.to_longitude,
//                         color: Colors.green,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 16),
//
//                 // Action Buttons Row
//                 Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _buildActionButton(
//                               icon: Icons.check_circle,
//                               label: "ACCEPT",
//                               color: Colors.green,
//                               onPressed: () => _acceptRequest(request.id),
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: _buildActionButton(
//                               icon: Icons.cancel,
//                               label: "REJECT",
//                               color: Colors.red,
//                               onPressed: () => _rejectRequest(request.id),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _buildActionButton(
//                               icon: Icons.chat,
//                               label: "MESSAGE",
//                               color: Color(0xFFF57C00),
//                               onPressed: () => _openChat(request.userid),
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: OutlinedButton.icon(
//                               onPressed: () {
//                                 // Navigate to drhome
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => drhome()),
//                                 );
//                               },
//                               icon: Icon(Icons.home, size: 16),
//                               label: Text(
//                                 "HOME",
//                                 style: TextStyle(fontSize: 12),
//                               ),
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: Colors.grey.shade700,
//                                 side: BorderSide(color: Colors.grey.shade400),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 10),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLocationButton({
//     required IconData icon,
//     required String label,
//     required String latitude,
//     required String longitude,
//     required Color color,
//   }) {
//     return ElevatedButton.icon(
//       onPressed: () async {
//         final String mapUrl = "https://www.google.com/maps/?q=$latitude,$longitude";
//         final Uri uri = Uri.parse(mapUrl);
//
//         if (await canLaunchUrl(uri)) {
//           await launchUrl(uri, mode: LaunchMode.externalApplication);
//         }
//       },
//       icon: Icon(icon, size: 16),
//       label: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             label,
//             style: TextStyle(fontSize: 10),
//           ),
//           Text(
//             "Location",
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color.withOpacity(0.1),
//         foregroundColor: color,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//           side: BorderSide(color: color.withOpacity(0.3)),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 8),
//       ),
//     );
//   }
//
//   Widget _buildActionButton({
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onPressed,
//   }) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       icon: Icon(icon, size: 16),
//       label: Text(
//         label,
//         style: TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 10),
//       ),
//     );
//   }
//
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
//                 color: Colors.grey.shade700,
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
//
// class Joke {
//   final String id;
//   final String USER;
//   final String date;
//   final String from_latitude;
//   final String from_longitude;
//   final String to_latitude;
//   final String to_longitude;
//   final String amount;
//   final String userid;
//
//   Joke(
//       this.id,
//       this.USER,
//       this.date,
//       this.from_latitude,
//       this.from_longitude,
//       this.to_latitude,
//       this.to_longitude,
//       this.amount,
//       this.userid,
//       );
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickshaw_ride/driver/chat.dart';
import 'package:rickshaw_ride/driver/drhome.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(view_passenger_request());
}

class view_passenger_request extends StatelessWidget {
  const view_passenger_request({super.key});

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
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ),
      home: view_passenger_requestsub(),
    );
  }
}

class view_passenger_requestsub extends StatefulWidget {
  const view_passenger_requestsub({super.key});

  @override
  State<view_passenger_requestsub> createState() => view_passenger_requestsubstate();
}

class view_passenger_requestsubstate extends State<view_passenger_requestsub> {
  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await http.post(
        Uri.parse("${prefs.getString("ip")}/view_passengers_requst"),
        body: {"did": prefs.getString('did').toString()}
    );

    var jsonData = json.decode(data.body);
    List<Joke> jokes = [];
    for (var joke in jsonData["message"]) {
      Joke newJoke = Joke(
        joke["id"].toString(),
        joke["USER"].toString(),
        joke["date"].toString(),
        joke["from_latitude"].toString(),
        joke["from_longitude"].toString(),
        joke["to_latitude"].toString(),
        joke["to_longitude"].toString(),
        joke["amount"].toString(),
        joke["userid"].toString(),
        joke["status"].toString(), // Added status field
      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  Future<void> _acceptRequest(String id) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    var data = await http.post(
        Uri.parse('${sh.getString('ip')}/accept_passenger_request'),
        body: {'id': id}
    );

var decodd=json.decode(data.body);
    if (decodd['status'] == "ok") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Request accepted successfully'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(decodd['message'] ?? 'Failed to accept request'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }

    setState(() {});
  }

  Future<void> _rejectRequest(String id) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    var data = await http.post(
        Uri.parse('${sh.getString('ip')}/reject_passenger_request'),
        body: {'id': id}
    );

    var decodd = json.decode(data.body);

    if (decodd['status'] == 'ok') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Request rejected'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(decodd['message'] ?? 'Failed to reject request'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }

    setState(() {});
  }

  Future<void> _openChat(String userId) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString('userid', userId);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyChatApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'PASSENGER REQUESTS',
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
                      "Loading passenger requests...",
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
                      "Error loading requests",
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
                        Icons.notifications_none,
                        size: 60,
                        color: Color(0xFFF57C00).withValues(alpha: 0.5),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "No Passenger Requests",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "New ride requests will appear here",
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
                  return _buildRequestCard(i, index);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildRequestCard(Joke request, int index) {
    bool isPending = request.status.toLowerCase() == "pending";

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
                // Header with user info and status
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
                          request.USER[0].toUpperCase(),
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
                            request.USER,
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
                                request.date,
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
                    // Status Badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isPending ? Colors.orange.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isPending ? Colors.orange.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPending ? Icons.pending : Icons.check_circle,
                            size: 12,
                            color: isPending ? Colors.orange : Colors.grey,
                          ),
                          SizedBox(width: 4),
                          Text(
                            request.status.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isPending ? Colors.orange : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Amount and Location Summary
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
                            "Trip Amount",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            "₹ ${request.amount}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF57C00),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Request #${index + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFF57C00),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Location Buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildLocationButton(
                        icon: Icons.my_location,
                        label: "From",
                        latitude: request.from_latitude,
                        longitude: request.from_longitude,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _buildLocationButton(
                        icon: Icons.location_on,
                        label: "To",
                        latitude: request.to_latitude,
                        longitude: request.to_longitude,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Action Buttons - Only show Accept/Reject for pending requests
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      // Accept/Reject buttons - only for pending requests
                      if (isPending) ...[
                        Row(
                          children: [
                            Expanded(
                              child: _buildActionButton(
                                icon: Icons.check_circle,
                                label: "ACCEPT",
                                color: Colors.green,
                                onPressed: () => _acceptRequest(request.id),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: _buildActionButton(
                                icon: Icons.cancel,
                                label: "REJECT",
                                color: Colors.red,
                                onPressed: () => _rejectRequest(request.id),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                      ],

                      // Message and Home buttons - always visible
                      Row(
                        children: [
                          // Expanded(
                          //   child: _buildActionButton(
                          //     icon: Icons.chat,
                          //     label: "MESSAGE",
                          //     color: Color(0xFFF57C00),
                          //     onPressed: () => _openChat(request.userid),
                          //   ),
                          // ),
                          SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Navigate to drhome
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => drhome()),
                                );
                              },
                              icon: Icon(Icons.home, size: 16),
                              label: Text(
                                "HOME",
                                style: TextStyle(fontSize: 12),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey.shade700,
                                side: BorderSide(color: Colors.grey.shade400),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationButton({
    required IconData icon,
    required String label,
    required String latitude,
    required String longitude,
    required Color color,
  }) {
    return ElevatedButton.icon(
      onPressed: () async {
        final String mapUrl = "https://www.google.com/maps/?q=$latitude,$longitude";
        final Uri uri = Uri.parse(mapUrl);

        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      icon: Icon(icon, size: 16),
      label: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 10),
          ),
          Text(
            "Location",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.1),
        foregroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: color.withValues(alpha: 0.3)),
        ),
        padding: EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
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
  final String USER;
  final String date;
  final String from_latitude;
  final String from_longitude;
  final String to_latitude;
  final String to_longitude;
  final String amount;
  final String userid;
  final String status; // Added status field

  Joke(
      this.id,
      this.USER,
      this.date,
      this.from_latitude,
      this.from_longitude,
      this.to_latitude,
      this.to_longitude,
      this.amount,
      this.userid,
      this.status, // Added status parameter
      );
}