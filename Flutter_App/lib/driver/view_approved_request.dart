// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/driver/drhome.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// void main() {
//   runApp(view_approved_request());
// }
//
// class view_approved_request extends StatelessWidget {
//   const view_approved_request({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: view_approved_requestsub(),
//     );
//   }
// }
//
// class view_approved_requestsub extends StatefulWidget {
//   const view_approved_requestsub({Key? key}) : super(key: key);
//
//   @override
//   State<view_approved_requestsub> createState() =>
//       view_approved_requestsubstate();
// }
//
// class view_approved_requestsubstate
//     extends State<view_approved_requestsub> {
//
//   // ================= FETCH DATA =================
//
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     var data = await http.post(
//         Uri.parse(prefs.getString("ip").toString() +
//             "/view_apprroved_request"),
//         body: {"did": prefs.getString('did').toString()});
//
//     var jsonData = json.decode(data.body);
//
//     List<Joke> jokes = [];
//     for (var joke in jsonData["message"]) {
//       Joke newJoke = Joke(
//         joke["id"].toString(),
//         joke["date"].toString(),
//         joke["from_latitude"].toString(),
//         joke["from_longitude"].toString(),
//         joke["to_latitude"].toString(),
//         joke["to_longitude"].toString(),
//         joke["amount"].toString(),
//         joke["USER"].toString(),
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }
//
//   // ================= OPEN GOOGLE MAP =================
//
//   Future<void> openMap(
//       String fromLat, String fromLng, String toLat, String toLng) async {
//
//     final Uri googleMapUrl = Uri.parse(
//         "https://www.google.com/maps/dir/?api=1&origin=$fromLat,$fromLng&destination=$toLat,$toLng&travelmode=driving");
//
//     if (await canLaunchUrl(googleMapUrl)) {
//       await launchUrl(googleMapUrl,
//           mode: LaunchMode.externalApplication);
//     } else {
//       throw 'Could not open map';
//     }
//   }
//
//   // ================= EXTRA CHARGE DIALOG =================
//
//   void showExtraChargeDialog(String requestId) {
//     TextEditingController extraController = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Add Extra Charge"),
//           content: TextField(
//             controller: extraController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               hintText: "Enter extra amount",
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (extraController.text.trim().isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Enter extra amount")),
//                   );
//                   return;
//                 }
//
//                 addExtraCharge(
//                     requestId, extraController.text.trim());
//                 Navigator.pop(context);
//               },
//               child: Text("Submit"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // ================= CALL BACKEND =================
//
//   Future<void> addExtraCharge(
//       String requestId, String extraAmount) async {
//     SharedPreferences prefs =
//     await SharedPreferences.getInstance();
//
//     var response = await http.post(
//       Uri.parse(prefs.getString("ip").toString() +
//           "/add_extra_charges_with_fair"),
//       body: {
//         "request_id": requestId,
//         "extra_charge": extraAmount,
//       },
//     );
//
//     var jsonData = json.decode(response.body);
//
//     if (jsonData["status"] == "ok") {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             content:
//             Text("Extra Charge Added Successfully")),
//       );
//       setState(() {});
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             content:
//             Text("Failed to Add Extra Charge")),
//       );
//     }
//   }
//
//   // ================= UI =================
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'APPROVED REQUEST',
//           style: TextStyle(
//             color: Color(0xFFF57C00),
//             fontSize: 20,
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => drhome()),
//             );
//           },
//           icon: Icon(Icons.arrow_back),
//         ),
//         backgroundColor: Colors.black,
//       ),
//       body: FutureBuilder(
//         future: _getJokes(),
//         builder:
//             (BuildContext context, AsyncSnapshot snapshot) {
//
//           if (!snapshot.hasData) {
//             return Center(child: Text("Loading..."));
//           }
//
//           return ListView.builder(
//             itemCount: snapshot.data.length,
//             itemBuilder:
//                 (BuildContext context, int index) {
//
//               var i = snapshot.data[index];
//
//               return Padding(
//                 padding:
//                 const EdgeInsets.all(8.0),
//                 child: Card(
//                   child: Padding(
//                     padding:
//                     const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment:
//                       CrossAxisAlignment.start,
//                       children: [
//
//                         _buildRow("Date:", i.date),
//                         _buildRow("User:", i.USER),
//                         _buildRow(
//                             "From Lat:",
//                             i.from_lat),
//                         _buildRow(
//                             "From Lng:",
//                             i.from_lng),
//                         _buildRow(
//                             "To Lat:",
//                             i.to_lat),
//                         _buildRow(
//                             "To Lng:",
//                             i.to_lng),
//                         _buildRow(
//                             "Amount:",
//                             i.amount),
//
//                         SizedBox(height: 15),
//
//                         ElevatedButton(
//                           onPressed: () {
//                             showExtraChargeDialog(
//                                 i.id);
//                           },
//                           style:
//                           ElevatedButton.styleFrom(
//                             backgroundColor:
//                             Colors.orange,
//                           ),
//                           child:
//                           Text("Add Extra Charge"),
//                         ),
//
//                         SizedBox(height: 10),
//
//                         ElevatedButton(
//                           onPressed: () {
//                             openMap(
//                               i.from_lat,
//                               i.from_lng,
//                               i.to_lat,
//                               i.to_lng,
//                             );
//                           },
//                           style:
//                           ElevatedButton.styleFrom(
//                             backgroundColor:
//                             Colors.green,
//                           ),
//                           child:
//                           Text("View Route on Map"),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildRow(String label, String value) {
//     return Padding(
//       padding:
//       const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 100,
//             child: Text(
//               label,
//               style: TextStyle(
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//           Flexible(
//             child: Text(value),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ================= MODEL CLASS =================
//
// class Joke {
//   final String id;
//   final String date;
//   final String from_lat;
//   final String from_lng;
//   final String to_lat;
//   final String to_lng;
//   final String amount;
//   final String USER;
//
//   Joke(this.id, this.date, this.from_lat,
//       this.from_lng, this.to_lat,
//       this.to_lng, this.amount, this.USER);
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/driver/drhome.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// void main() {
//   runApp(view_approved_request());
// }
//
// class view_approved_request extends StatelessWidget {
//   const view_approved_request({Key? key}) : super(key: key);
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
//           backgroundColor: Color(0xFFF57C00),
//           foregroundColor: Colors.white,
//           elevation: 2,
//           centerTitle: true,
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           ),
//         ),
//       ),
//       home: view_approved_requestsub(),
//     );
//   }
// }
//
// class view_approved_requestsub extends StatefulWidget {
//   const view_approved_requestsub({Key? key}) : super(key: key);
//
//   @override
//   State<view_approved_requestsub> createState() =>
//       view_approved_requestsubstate();
// }
//
// class view_approved_requestsubstate
//     extends State<view_approved_requestsub> {
//
//   // ================= FETCH DATA =================
//
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     var data = await http.post(
//         Uri.parse(prefs.getString("ip").toString() +
//             "/view_apprroved_request"),
//         body: {"did": prefs.getString('did').toString()});
//
//     var jsonData = json.decode(data.body);
//
//     List<Joke> jokes = [];
//     for (var joke in jsonData["message"]) {
//       Joke newJoke = Joke(
//         joke["id"].toString(),
//         joke["date"].toString(),
//         joke["from_latitude"].toString(),
//         joke["from_longitude"].toString(),
//         joke["to_latitude"].toString(),
//         joke["to_longitude"].toString(),
//         joke["amount"].toString(),
//         joke["USER"].toString(),
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }
//
//   // ================= OPEN GOOGLE MAP =================
//
//   Future<void> openMap(
//       String fromLat, String fromLng, String toLat, String toLng) async {
//
//     final Uri googleMapUrl = Uri.parse(
//         "https://www.google.com/maps/dir/?api=1&origin=$fromLat,$fromLng&destination=$toLat,$toLng&travelmode=driving");
//
//     if (await canLaunchUrl(googleMapUrl)) {
//       await launchUrl(googleMapUrl,
//           mode: LaunchMode.externalApplication);
//     } else {
//       throw 'Could not open map';
//     }
//   }
//
//   // ================= EXTRA CHARGE DIALOG =================
//
//   void showExtraChargeDialog(String requestId) {
//     TextEditingController extraController = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: Row(
//             children: [
//               Icon(Icons.add_circle, color: Color(0xFFF57C00), size: 28),
//               SizedBox(width: 10),
//               Text(
//                 "Add Extra Charge",
//                 style: TextStyle(
//                   color: Color(0xFFF57C00),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           content: TextField(
//             controller: extraController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               hintText: "Enter extra amount",
//               prefixIcon: Icon(Icons.currency_rupee, color: Color(0xFFF57C00)),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: Color(0xFFF57C00), width: 2),
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(
//                 "Cancel",
//                 style: TextStyle(color: Colors.grey.shade600),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (extraController.text.trim().isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text("Enter extra amount"),
//                       backgroundColor: Colors.red,
//                       behavior: SnackBarBehavior.floating,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   );
//                   return;
//                 }
//
//                 addExtraCharge(
//                     requestId, extraController.text.trim());
//                 Navigator.pop(context);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFFF57C00),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Text("Submit"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // ================= CALL BACKEND =================
//
//   Future<void> addExtraCharge(
//       String requestId, String extraAmount) async {
//     SharedPreferences prefs =
//     await SharedPreferences.getInstance();
//
//     var response = await http.post(
//       Uri.parse(prefs.getString("ip").toString() +
//           "/add_extra_charges_with_fair"),
//       body: {
//         "request_id": requestId,
//         "extra_charge": extraAmount,
//       },
//     );
//
//     var jsonData = json.decode(response.body);
//
//     if (jsonData["status"] == "ok") {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Extra Charge Added Successfully"),
//           backgroundColor: Colors.green,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       );
//       setState(() {});
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Failed to Add Extra Charge"),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       );
//     }
//   }
//
//   // ================= UI =================
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       appBar: AppBar(
//         title: Text(
//           'APPROVED REQUESTS',
//           style: TextStyle(
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
//               color: Colors.white.withOpacity(0.2),
//             ),
//             child: Icon(Icons.arrow_back, color: Colors.white),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               setState(() {});
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder(
//         future: _getJokes(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(
//                     color: Color(0xFFF57C00),
//                     strokeWidth: 3,
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     "Loading approved requests...",
//                     style: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//
//           if (!snapshot.hasData || snapshot.data.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.check_circle_outline,
//                     size: 80,
//                     color: Colors.grey.shade400,
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     "No Approved Requests",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Approved ride requests will appear here",
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//
//           return ListView.builder(
//             padding: EdgeInsets.all(16),
//             itemCount: snapshot.data.length,
//             itemBuilder: (BuildContext context, int index) {
//               var i = snapshot.data[index];
//               return _buildRequestCard(i, index);
//             },
//           );
//         },
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
//                 // Header with user info and date
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
//                       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: Color(0xFFF57C00).withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: Color(0xFFF57C00).withOpacity(0.3),
//                         ),
//                       ),
//                       child: Text(
//                         '#${index + 1}',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFFF57C00),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 20),
//
//                 // Location Details
//                 Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     children: [
//                       _buildLocationRow(
//                         icon: Icons.my_location,
//                         label: "From",
//                         lat: request.from_lat,
//                         lng: request.from_lng,
//                       ),
//                       SizedBox(height: 8),
//                       _buildLocationRow(
//                         icon: Icons.location_on,
//                         label: "To",
//                         lat: request.to_lat,
//                         lng: request.to_lng,
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 16),
//
//                 // Amount Section
//                 Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color(0xFFF57C00).withOpacity(0.1),
//                         Colors.transparent,
//                       ],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: Color(0xFFF57C00).withOpacity(0.2),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Amount",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.grey.shade700,
//                         ),
//                       ),
//                       Text(
//                         "₹ ${request.amount}",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFFF57C00),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 20),
//
//                 // Action Buttons
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildActionButton(
//                         icon: Icons.add_circle,
//                         label: "Extra Charge",
//                         color: Color(0xFFF57C00),
//                         onPressed: () => showExtraChargeDialog(request.id),
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: _buildActionButton(
//                         icon: Icons.map,
//                         label: "View Route",
//                         color: Colors.green,
//                         onPressed: () => openMap(
//                           request.from_lat,
//                           request.from_lng,
//                           request.to_lat,
//                           request.to_lng,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLocationRow({
//     required IconData icon,
//     required String label,
//     required String lat,
//     required String lng,
//   }) {
//     return Row(
//       children: [
//         Container(
//           width: 36,
//           height: 36,
//           decoration: BoxDecoration(
//             color: Color(0xFFF57C00).withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(icon, color: Color(0xFFF57C00), size: 20),
//         ),
//         SizedBox(width: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey.shade600,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(height: 2),
//             Text(
//               "$lat, $lng",
//               style: TextStyle(
//                 fontSize: 13,
//                 color: Colors.grey.shade800,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ],
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
//       icon: Icon(icon, size: 18),
//       label: Text(
//         label,
//         style: TextStyle(
//           fontSize: 13,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 12),
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
// // ================= MODEL CLASS =================
//
// class Joke {
//   final String id;
//   final String date;
//   final String from_lat;
//   final String from_lng;
//   final String to_lat;
//   final String to_lng;
//   final String amount;
//   final String USER;
//
//   Joke(this.id, this.date, this.from_lat,
//       this.from_lng, this.to_lat,
//       this.to_lng, this.amount, this.USER);
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/driver/drhome.dart';
// import 'package:rickshaw_ride/driver/chat.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// void main() {
//   runApp(view_approved_request());
// }
//
// class view_approved_request extends StatelessWidget {
//   const view_approved_request({super.key});
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
//           backgroundColor: Color(0xFFF57C00),
//           foregroundColor: Colors.white,
//           elevation: 2,
//           centerTitle: true,
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           ),
//         ),
//       ),
//       home: view_approved_requestsub(),
//     );
//   }
// }
//
// class view_approved_requestsub extends StatefulWidget {
//   const view_approved_requestsub({super.key});
//
//   @override
//   State<view_approved_requestsub> createState() =>
//       view_approved_requestsubstate();
// }
//
// class view_approved_requestsubstate
//     extends State<view_approved_requestsub> {
//
//   // ================= FETCH DATA =================
//
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     var data = await http.post(
//         Uri.parse("${prefs.getString("ip")}/view_apprroved_request"),
//         body: {"did": prefs.getString('did').toString()});
//
//     var jsonData = json.decode(data.body);
//
//     List<Joke> jokes = [];
//     for (var joke in jsonData["message"]) {
//       Joke newJoke = Joke(
//           joke["id"].toString(),
//           joke["date"].toString(),
//           joke["from_latitude"].toString(),
//           joke["from_longitude"].toString(),
//           joke["to_latitude"].toString(),
//           joke["to_longitude"].toString(),
//           joke["amount"].toString(),
//           joke["USER"].toString(),
//           joke["userid"].toString(),
//           joke["payment_status"].toString(),
//           joke["extra_charge"].toString()
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }
//
//   // ================= OPEN GOOGLE MAP =================
//
//   Future<void> openMap(
//       String fromLat, String fromLng, String toLat, String toLng) async {
//
//     final Uri googleMapUrl = Uri.parse(
//         "https://www.google.com/maps/dir/?api=1&origin=$fromLat,$fromLng&destination=$toLat,$toLng&travelmode=driving");
//
//     if (await canLaunchUrl(googleMapUrl)) {
//       await launchUrl(googleMapUrl,
//           mode: LaunchMode.externalApplication);
//     } else {
//       throw 'Could not open map';
//     }
//   }
//
//   // ================= OPEN CHAT =================
//
//   Future<void> _openChat(String userId) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     sh.setString('userid', userId.toString());
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => MyChatApp()),
//     );
//   }
//
//   // ================= EXTRA CHARGE DIALOG =================
//
//   void showExtraChargeDialog(String requestId) {
//     TextEditingController extraController = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: Row(
//             children: [
//               Icon(Icons.add_circle, color: Color(0xFFF57C00), size: 28),
//               SizedBox(width: 10),
//               Text(
//                 "Add Extra Charge",
//                 style: TextStyle(
//                   color: Color(0xFFF57C00),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           content: TextField(
//             controller: extraController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               hintText: "Enter extra amount",
//               prefixIcon: Icon(Icons.currency_rupee, color: Color(0xFFF57C00)),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: Color(0xFFF57C00), width: 2),
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(
//                 "Cancel",
//                 style: TextStyle(color: Colors.grey.shade600),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (extraController.text.trim().isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text("Enter extra amount"),
//                       backgroundColor: Colors.red,
//                       behavior: SnackBarBehavior.floating,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   );
//                   return;
//                 }
//
//                 addExtraCharge(
//                     requestId, extraController.text.trim());
//                 Navigator.pop(context);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFFF57C00),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Text("Submit"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // ================= CALL BACKEND =================
//
//   Future<void> addExtraCharge(
//       String requestId, String extraAmount) async {
//     SharedPreferences prefs =
//     await SharedPreferences.getInstance();
//
//     var response = await http.post(
//       Uri.parse("${prefs.getString("ip")}/add_extra_charges_with_fair"),
//       body: {
//         "request_id": requestId,
//         "extra_charge": extraAmount,
//       },
//     );
//
//     var jsonData = json.decode(response.body);
//
//     if (jsonData["status"] == "ok") {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Extra Charge Added Successfully"),
//           backgroundColor: Colors.green,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       );
//       setState(() {});
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Failed to Add Extra Charge"),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       );
//     }
//   }
//
//   // ================= UI =================
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       appBar: AppBar(
//         title: Text(
//           'APPROVED REQUESTS',
//           style: TextStyle(
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
//               color: Colors.white.withValues(alpha: 0.2),
//             ),
//             child: Icon(Icons.arrow_back, color: Colors.white),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               setState(() {});
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder(
//         future: _getJokes(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(
//                     color: Color(0xFFF57C00),
//                     strokeWidth: 3,
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     "Loading approved requests...",
//                     style: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//
//           if (!snapshot.hasData || snapshot.data.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.check_circle_outline,
//                     size: 80,
//                     color: Colors.grey.shade400,
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     "No Approved Requests",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Approved ride requests will appear here",
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//
//           return ListView.builder(
//             padding: EdgeInsets.all(16),
//             itemCount: snapshot.data.length,
//             itemBuilder: (BuildContext context, int index) {
//               var i = snapshot.data[index];
//               return _buildRequestCard(i, index);
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildRequestCard(Joke request, int index) {
//     bool isPaid = request.payment_status.toLowerCase() == "paid" ||
//         request.payment_status.toLowerCase() == "completed";
//     bool hasExtraCharge = request.extra_charge != "0" && request.extra_charge.isNotEmpty;
//
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
//                 // Header with user info, date and payment status
//                 Row(
//                   children: [
//                     Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Color(0xFFF57C00).withValues(alpha: 0.2),
//                             Color(0xFFF57C00).withValues(alpha: 0.4),
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
//                     // Payment Status Badge
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       margin: EdgeInsets.only(right: 8),
//                       decoration: BoxDecoration(
//                         color: isPaid ? Colors.green.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: isPaid ? Colors.green.withValues(alpha: 0.3) : Colors.orange.withValues(alpha: 0.3),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                             isPaid ? Icons.paid : Icons.pending,
//                             size: 12,
//                             color: isPaid ? Colors.green : Colors.orange,
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             request.payment_status.toUpperCase(),
//                             style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                               color: isPaid ? Colors.green : Colors.orange,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 20),
//
//                 // Location Details
//                 Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     children: [
//                       _buildLocationRow(
//                         icon: Icons.my_location,
//                         label: "From",
//                         lat: request.from_lat,
//                         lng: request.from_lng,
//                       ),
//                       SizedBox(height: 8),
//                       _buildLocationRow(
//                         icon: Icons.location_on,
//                         label: "To",
//                         lat: request.to_lat,
//                         lng: request.to_lng,
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 16),
//
//                 // Amount Section with Extra Charge if any
//                 Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color(0xFFF57C00).withValues(alpha: 0.1),
//                         Colors.transparent,
//                       ],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: Color(0xFFF57C00).withValues(alpha: 0.2),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Base Fare",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey.shade600,
//                             ),
//                           ),
//                           Text(
//                             "₹ ${request.amount}",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.grey.shade800,
//                             ),
//                           ),
//                         ],
//                       ),
//                       if (hasExtraCharge) ...[
//                         SizedBox(height: 4),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Extra Charge",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ),
//                             Text(
//                               "+ ₹ ${request.extra_charge}",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFFF57C00),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Divider(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Total Amount",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey.shade800,
//                               ),
//                             ),
//                             Text(
//                               "₹ ${(double.parse(request.amount) + double.parse(request.extra_charge)).toStringAsFixed(2)}",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFFF57C00),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ] else
//                         Divider(height: 16),
//                       if (!hasExtraCharge)
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Total Amount",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey.shade800,
//                               ),
//                             ),
//                             Text(
//                               "₹ ${request.amount}",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFFF57C00),
//                               ),
//                             ),
//                           ],
//                         ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 20),
//
//                 // Action Buttons - Only show Extra Charge if not paid
//                 Row(
//                   children: [
//                     if (!isPaid && !hasExtraCharge) ...[
//                       Expanded(
//                         child: _buildActionButton(
//                           icon: Icons.add_circle,
//                           label: "Extra Charge",
//                           color: Color(0xFFF57C00),
//                           onPressed: () => showExtraChargeDialog(request.id),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                     ],
//                     Expanded(
//                       child: _buildActionButton(
//                         icon: Icons.map,
//                         label: "View Route",
//                         color: Colors.green,
//                         onPressed: () => openMap(
//                           request.from_lat,
//                           request.from_lng,
//                           request.to_lat,
//                           request.to_lng,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 10),
//
//                 // Action Buttons - Second Row with Chat
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildActionButton(
//                         icon: Icons.chat,
//                         label: "MESSAGE",
//                         color: Colors.blue,
//                         onPressed: () => _openChat(request.userid),
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: OutlinedButton.icon(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(builder: (context) => drhome()),
//                           );
//                         },
//                         icon: Icon(Icons.home, size: 18, color: Color(0xFFF57C00)),
//                         label: Text(
//                           "HOME",
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFFF57C00),
//                           ),
//                         ),
//                         style: OutlinedButton.styleFrom(
//                           side: BorderSide(color: Color(0xFFF57C00), width: 1.5),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           padding: EdgeInsets.symmetric(vertical: 12),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLocationRow({
//     required IconData icon,
//     required String label,
//     required String lat,
//     required String lng,
//   }) {
//     return Row(
//       children: [
//         Container(
//           width: 36,
//           height: 36,
//           decoration: BoxDecoration(
//             color: Color(0xFFF57C00).withValues(alpha: 0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(icon, color: Color(0xFFF57C00), size: 20),
//         ),
//         SizedBox(width: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey.shade600,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(height: 2),
//             Text(
//               "$lat, $lng",
//               style: TextStyle(
//                 fontSize: 13,
//                 color: Colors.grey.shade800,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ],
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
//       icon: Icon(icon, size: 18),
//       label: Text(
//         label,
//         style: TextStyle(
//           fontSize: 13,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 12),
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
// // ================= MODEL CLASS =================
//
// class Joke {
//   final String id;
//   final String date;
//   final String from_lat;
//   final String from_lng;
//   final String to_lat;
//   final String to_lng;
//   final String amount;
//   final String USER;
//   final String userid;
//   final String payment_status;
//   final String extra_charge;
//
//   Joke(this.id, this.date, this.from_lat,
//       this.from_lng, this.to_lat,
//       this.to_lng, this.amount, this.USER, this.userid,this.payment_status,this.extra_charge);
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickshaw_ride/driver/drhome.dart';
import 'package:rickshaw_ride/driver/chat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(view_approved_request());
}

class view_approved_request extends StatelessWidget {
  const view_approved_request({super.key});

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
          backgroundColor: Color(0xFFF57C00),
          foregroundColor: Colors.white,
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
      home: view_approved_requestsub(),
    );
  }
}

class view_approved_requestsub extends StatefulWidget {
  const view_approved_requestsub({super.key});

  @override
  State<view_approved_requestsub> createState() =>
      view_approved_requestsubstate();
}

class view_approved_requestsubstate
    extends State<view_approved_requestsub> {

  // ================= FETCH DATA =================

  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var data = await http.post(
        Uri.parse("${prefs.getString("ip")}/view_apprroved_request"),
        body: {"did": prefs.getString('did').toString()});

    var jsonData = json.decode(data.body);

    List<Joke> jokes = [];
    for (var joke in jsonData["message"]) {
      Joke newJoke = Joke(
          joke["id"].toString(),
          joke["date"].toString(),
          joke["from_latitude"].toString(),
          joke["from_longitude"].toString(),
          joke["to_latitude"].toString(),
          joke["to_longitude"].toString(),
          joke["amount"].toString(),
          joke["USER"].toString(),
          joke["userid"].toString(),
          joke["payment_status"].toString(),
          joke["extra_charge"].toString()
      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  // ================= OPEN GOOGLE MAP =================

  Future<void> openMap(
      String fromLat, String fromLng, String toLat, String toLng) async {

    final Uri googleMapUrl = Uri.parse(
        "https://www.google.com/maps/dir/?api=1&origin=$fromLat,$fromLng&destination=$toLat,$toLng&travelmode=driving");

    if (await canLaunchUrl(googleMapUrl)) {
      await launchUrl(googleMapUrl,
          mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open map';
    }
  }

  // ================= OPEN CHAT =================

  Future<void> _openChat(String userId) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString('userid', userId.toString());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyChatApp()),
    );
  }

  // ================= EXTRA CHARGE DIALOG =================

  void showExtraChargeDialog(String requestId) {
    TextEditingController extraController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.add_circle, color: Color(0xFFF57C00), size: 28),
              SizedBox(width: 10),
              Text(
                "Add Extra Charge",
                style: TextStyle(
                  color: Color(0xFFF57C00),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: TextField(
            controller: extraController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter extra amount",
              prefixIcon: Icon(Icons.currency_rupee, color: Color(0xFFF57C00)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(0xFFF57C00), width: 2),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (extraController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Enter extra amount"),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                  return;
                }

                addExtraCharge(
                    requestId, extraController.text.trim());
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF57C00),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  // ================= CALL BACKEND =================

  Future<void> addExtraCharge(
      String requestId, String extraAmount) async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    var response = await http.post(
      Uri.parse("${prefs.getString("ip")}/add_extra_charges_with_fair"),
      body: {
        "request_id": requestId,
        "extra_charge": extraAmount,
      },
    );

    var jsonData = json.decode(response.body);

    if (jsonData["status"] == "ok") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Extra Charge Added Successfully"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to Add Extra Charge"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  // ================= NEW: COMPLETE RIDE =================
  Future<void> _completeRide(String requestId) async {
    // Show confirmation dialog
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Complete Ride"),
        content: Text("Are you sure you want to mark this ride as completed?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: Text("Yes, Complete"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(
      Uri.parse("${prefs.getString("ip")}/driver_complete_ride"),
      body: {"id": requestId},
    );

    var jsonData = json.decode(response.body);

    if (jsonData["status"] == "ok") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ride marked as completed"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to complete ride"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'APPROVED REQUESTS',
          style: TextStyle(
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
              color: Colors.white.withValues(alpha: 0.2),
            ),
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder(
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
                    "Loading approved requests...",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "No Approved Requests",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Approved ride requests will appear here",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var i = snapshot.data[index];
              return _buildRequestCard(i, index);
            },
          );
        },
      ),
    );
  }

  Widget _buildRequestCard(Joke request, int index) {
    bool isPaid = request.payment_status.toLowerCase() == "paid" ||
        request.payment_status.toLowerCase() == "completed";
    bool hasExtraCharge = request.extra_charge != "0" && request.extra_charge.isNotEmpty;

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
                // Header with user info, date and payment status
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
                    // Payment Status Badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: isPaid ? Colors.green.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isPaid ? Colors.green.withValues(alpha: 0.3) : Colors.orange.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPaid ? Icons.paid : Icons.pending,
                            size: 12,
                            color: isPaid ? Colors.green : Colors.orange,
                          ),
                          SizedBox(width: 4),
                          Text(
                            request.payment_status.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isPaid ? Colors.green : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

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
                        lat: request.from_lat,
                        lng: request.from_lng,
                      ),
                      SizedBox(height: 8),
                      _buildLocationRow(
                        icon: Icons.location_on,
                        label: "To",
                        lat: request.to_lat,
                        lng: request.to_lng,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Amount Section with Extra Charge if any
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFF57C00).withValues(alpha: 0.1),
                        Colors.transparent,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFFF57C00).withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Base Fare",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            "₹ ${request.amount}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                      if (hasExtraCharge) ...[
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Extra Charge",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              "+ ₹ ${request.extra_charge}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFF57C00),
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Amount",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            Text(
                              "₹ ${(double.parse(request.amount) + double.parse(request.extra_charge)).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF57C00),
                              ),
                            ),
                          ],
                        ),
                      ] else
                        Divider(height: 16),
                      if (!hasExtraCharge)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Amount",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
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
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Action Buttons - First row (Extra Charge & View Route)
                Row(
                  children: [
                    if (!isPaid && !hasExtraCharge) ...[
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.add_circle,
                          label: "Extra Charge",
                          color: Color(0xFFF57C00),
                          onPressed: () => showExtraChargeDialog(request.id),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.map,
                        label: "View Route",
                        color: Colors.green,
                        onPressed: () => openMap(
                          request.from_lat,
                          request.from_lng,
                          request.to_lat,
                          request.to_lng,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                // Action Buttons - Second row (Message & Home)
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.chat,
                        label: "MESSAGE",
                        color: Colors.blue,
                        onPressed: () => _openChat(request.userid),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => drhome()),
                          );
                        },
                        icon: Icon(Icons.home, size: 18, color: Color(0xFFF57C00)),
                        label: Text(
                          "HOME",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFF57C00),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xFFF57C00), width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),

                // ========== NEW: COMPLETE RIDE BUTTON ==========
                // Only show if ride is not already completed
                if (!isPaid) ...[
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: _buildActionButton(
                      icon: Icons.check_circle,
                      label: "COMPLETE RIDE",
                      color: Colors.green,
                      onPressed: () => _completeRide(request.id),
                    ),
                  ),
                ],
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
        Column(
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
                fontSize: 13,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
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
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 12),
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

// ================= MODEL CLASS =================

class Joke {
  final String id;
  final String date;
  final String from_lat;
  final String from_lng;
  final String to_lat;
  final String to_lng;
  final String amount;
  final String USER;
  final String userid;
  final String payment_status;
  final String extra_charge;

  Joke(this.id, this.date, this.from_lat,
      this.from_lng, this.to_lat,
      this.to_lng, this.amount, this.USER, this.userid,this.payment_status,this.extra_charge);
}