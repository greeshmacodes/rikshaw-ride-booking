// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'package:rickshaw_ride/driver/add_vehicle_details.dart';
// import 'package:rickshaw_ride/driver/change_password.dart';
// import 'package:rickshaw_ride/driver/view_approved_request.dart';
// import 'package:rickshaw_ride/driver/view_passenger_location.dart';
// import 'package:rickshaw_ride/driver/view_passenger_request.dart';
// import 'package:rickshaw_ride/driver/view_payment_logs.dart';
// import 'package:rickshaw_ride/driver/view_reviews.dart';
// import 'package:rickshaw_ride/driver/view_ride_history.dart';
// import 'package:rickshaw_ride/driver/view_vehicle_details.dart';
// import 'package:rickshaw_ride/driver/viewprofile.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class drhome extends StatelessWidget {
//   const drhome({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: drhomesub(),
//     );
//   }
// }
//
// class drhomesub extends StatefulWidget {
//   const drhomesub({Key? key}) : super(key: key);
//
//   @override
//   State<drhomesub> createState() => _drhomesubState();
// }
//
// class _drhomesubState extends State<drhomesub> {
//
//   bool isAvailable = true;
//   bool isLoading = false;
//
//   /// 🔹 API call to save availability
//   Future<void> saveAvailability(bool status) async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       SharedPreferences sh=await SharedPreferences.getInstance();
//       final response = await http.post(
//         Uri.parse('${sh.getString('ip').toString()}/availability'),
//         body: {
//          'did':sh.getString('did').toString(),
//           'available':isAvailable
//         },
//       );
//
//       var d=json.decode(response.body);
//       if (d['status'] == 'ok') {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Availability updated successfully')),
//         );
//       } else {
//         throw Exception("Failed to update status");
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Server error')),
//       );
//     }
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Driver Home'),
//       ),
//
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             const DrawerHeader(
//               decoration: BoxDecoration(color: Colors.blue),
//               child: Text(
//                 'Menu',
//                 style: TextStyle(color: Colors.white, fontSize: 24),
//               ),
//             ),
//
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text('Home'),
//               onTap: () => Navigator.pop(context),
//             ),
//
//             ListTile(
//               title: const Text('Approved request'),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => view_approved_request()),
//               ),
//             ),
//
//             ListTile(
//               title: const Text('View Passenger Location'),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => view_passenger_location()),
//               ),
//             ),
//
//             ListTile(
//               title: const Text('View Passenger Request'),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => view_passenger_request()),
//               ),
//             ),
//
//             ListTile(
//               title: const Text('View Payment Logs'),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => view_payment_logs()),
//               ),
//             ),
//
//             ListTile(
//               title: const Text('View Reviews'),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => view_reviews()),
//               ),
//             ),
//
//             ListTile(
//               title: const Text('View Ride History'),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => view_ride_history()),
//               ),
//             ),
//
//             ListTile(
//               title: const Text('View Profile'),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => driver_view_profile()),
//               ),
//             ),
//
//             ListTile(
//               title: const Text('Change Password'),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => change_password()),
//               ),
//             ),
//
//             ListTile(
//               title: const Text('Add Vehicle Details'),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => add_vehicle_details()),
//               ),
//             ),

//             ListTile(
//               title: const Text('View Vehicle Details'),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => view_vehicle_details()),
//               ),
//             ),
//           ],
//         ),
//       ),
//
//       /// ✅ TOGGLE BUTTON UI
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//
//             const Text(
//               'Are you available?',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//
//             const SizedBox(height: 20),
//
//             Switch(
//               value: isAvailable,
//               activeColor: Colors.green,
//               inactiveThumbColor: Colors.red,
//               onChanged: (value) {
//                 setState(() {
//                   isAvailable = value;
//                 });
//                 saveAvailability(value);
//               },
//             ),
//
//             const SizedBox(height: 10),
//
//             Text(
//               isAvailable ? 'AVAILABLE' : 'NOT AVAILABLE',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: isAvailable ? Colors.green : Colors.red,
//               ),
//             ),
//
//             if (isLoading)
//               const Padding(
//                 padding: EdgeInsets.only(top: 15),
//                 child: CircularProgressIndicator(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// // Import your local files (ensure these paths match your project structure)
// import 'package:rickshaw_ride/driver/add_vehicle_details.dart';
// import 'package:rickshaw_ride/driver/change_password.dart';
// import 'package:rickshaw_ride/driver/view_approved_request.dart';
// import 'package:rickshaw_ride/driver/view_passenger_location.dart';
// import 'package:rickshaw_ride/driver/view_passenger_request.dart';
// import 'package:rickshaw_ride/driver/view_payment_logs.dart';
// import 'package:rickshaw_ride/driver/view_reviews.dart';
// import 'package:rickshaw_ride/driver/view_ride_history.dart';
// import 'package:rickshaw_ride/driver/view_vehicle_details.dart';
// import 'package:rickshaw_ride/driver/viewprofile.dart';
//
// class drhome extends StatelessWidget {
//   const drhome({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const drhomesub(),
//     );
//   }
// }
//
// class drhomesub extends StatefulWidget {
//   const drhomesub({Key? key}) : super(key: key);
//
//   @override
//   State<drhomesub> createState() => _drhomesubState();
// }
//
// class _drhomesubState extends State<drhomesub> {
//   bool isAvailable = false;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Load the last saved state when the app starts
//     _loadCurrentStatus();
//   }
//
//   /// 🔹 Load status from SharedPreferences (Optional: could also be an API call)
//   _loadCurrentStatus() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     setState(() {
//       isAvailable = sh.getBool('isAvailable') ?? false;
//     });
//   }
//
//   /// 🔹 API call to save availability to Python Backend
//   Future<void> saveAvailability(bool status) async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('ip').toString(); // Ensure 'url' or 'ip' is stored in login
//       String did = sh.getString('did').toString(); // Login ID
//
//       final response = await http.post(
//         Uri.parse('$url/driver_update_availability'),
//         body: {
//           'did': did,
//           'status': status ? 'available' : 'unavailable',
//         },
//       );
//
//       var d = json.decode(response.body);
//       if (d['status'] == 'ok') {
//         // Persist the state locally
//         await sh.setBool('isAvailable', status);
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(status ? 'You are now Online' : 'You are now Offline'),
//             backgroundColor: status ? Colors.green : Colors.red,
//             duration: const Duration(seconds: 1),
//           ),
//         );
//       } else {
//         throw Exception("Server rejected update");
//       }
//     } catch (e) {
//       // Revert toggle UI if API fails
//       setState(() {
//         isAvailable = !status;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Connection Error: Could not update status')),
//       );
//     }
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Driver Dashboard'),
//         backgroundColor: Colors.blueAccent,
//       ),
//
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: const BoxDecoration(color: Colors.blueAccent),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   CircleAvatar(radius: 30, backgroundColor: Colors.white, child: Icon(Icons.person, size: 40)),
//                   SizedBox(height: 10),
//                   Text('Driver Menu', style: TextStyle(color: Colors.white, fontSize: 20)),
//                 ],
//               ),
//             ),
//             _buildDrawerItem(Icons.home, 'Home', () => Navigator.pop(context)),
//             _buildDrawerItem(Icons.check_circle, 'Approved Request', () => _nav(const view_approved_request())),
//             _buildDrawerItem(Icons.check_circle, 'Add vehicle details', () => _nav(const add_vehicle_details())),
//             _buildDrawerItem(Icons.location_on, 'Passenger Location', () => _nav(const view_passenger_location())),
//             _buildDrawerItem(Icons.notifications, 'Passenger Requests', () => _nav(const view_passenger_request())),
//             _buildDrawerItem(Icons.payment, 'Payment Logs', () => _nav(const view_payment_logs())),
//             _buildDrawerItem(Icons.history, 'Ride History', () => _nav(const view_ride_history())),
//             _buildDrawerItem(Icons.star, 'Reviews', () => _nav(const view_reviews())),
//             const Divider(),
//             _buildDrawerItem(Icons.person_outline, 'My Profile', () => _nav(const driver_view_profile())),
//             _buildDrawerItem(Icons.directions_car, 'Vehicle Details', () => _nav(const view_vehicle_details())),
//             _buildDrawerItem(Icons.lock_reset, 'Change Password', () => _nav(const change_password())),
//
//           ],
//         ),
//       ),
//
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: isAvailable ? Colors.green.withOpacity(0.05) : Colors.red.withOpacity(0.05),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               isAvailable ? Icons.check_circle : Icons.do_not_disturb_on,
//               size: 80,
//               color: isAvailable ? Colors.green : Colors.red,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               isAvailable ? 'YOU ARE ONLINE' : 'YOU ARE OFFLINE',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: isAvailable ? Colors.green : Colors.red,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Toggle availability to receive ride requests',
//               style: TextStyle(color: Colors.grey),
//             ),
//             const SizedBox(height: 30),
//
//             // Toggle Switch
//             Transform.scale(
//               scale: 1.5,
//               child: Switch(
//                 value: isAvailable,
//                 activeColor: Colors.green,
//                 activeTrackColor: Colors.greenAccent,
//                 inactiveThumbColor: Colors.red,
//                 inactiveTrackColor: Colors.redAccent.withOpacity(0.3),
//                 onChanged: isLoading ? null : (value) {
//                   setState(() {
//                     isAvailable = value;
//                   });
//                   saveAvailability(value);
//                 },
//               ),
//             ),
//
//             if (isLoading)
//               const Padding(
//                 padding: EdgeInsets.only(top: 20),
//                 child: CircularProgressIndicator(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Helper function for Navigation
//   void _nav(Widget page) {
//     Navigator.push(context, MaterialPageRoute(builder: (_) => page));
//   }
//
//   // Helper for Drawer Items
//   ListTile _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title),
//       onTap: onTap,
//     );
//   }
// }




// -------------------------------------------------------------------------[
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// // Import your local files (ensure these paths match your project structure)
// import 'package:rickshaw_ride/driver/add_vehicle_details.dart';
// import 'package:rickshaw_ride/driver/change_password.dart';
// import 'package:rickshaw_ride/driver/view_approved_request.dart';
// import 'package:rickshaw_ride/driver/view_passenger_location.dart';
// import 'package:rickshaw_ride/driver/view_passenger_request.dart';
// import 'package:rickshaw_ride/driver/view_payment_logs.dart';
// import 'package:rickshaw_ride/driver/view_reviews.dart';
// import 'package:rickshaw_ride/driver/view_ride_history.dart';
// import 'package:rickshaw_ride/driver/view_vehicle_details.dart';
// import 'package:rickshaw_ride/driver/viewprofile.dart';
//
// class drhome extends StatelessWidget {
//   const drhome({Key? key}) : super(key: key);
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
//       ),
//       home: const drhomesub(),
//     );
//   }
// }
//
// class drhomesub extends StatefulWidget {
//   const drhomesub({Key? key}) : super(key: key);
//
//   @override
//   State<drhomesub> createState() => _drhomesubState();
// }
//
// class _drhomesubState extends State<drhomesub> {
//   bool isAvailable = false;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Load the last saved state when the app starts
//     _loadCurrentStatus();
//   }
//
//   /// 🔹 Load status from SharedPreferences (Optional: could also be an API call)
//   _loadCurrentStatus() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     setState(() {
//       isAvailable = sh.getBool('isAvailable') ?? false;
//     });
//   }
//
//   /// 🔹 API call to save availability to Python Backend
//   Future<void> saveAvailability(bool status) async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('ip').toString(); // Ensure 'url' or 'ip' is stored in login
//       String did = sh.getString('did').toString(); // Login ID
//
//       final response = await http.post(
//         Uri.parse('$url/driver_update_availability'),
//         body: {
//           'did': did,
//           'status': status ? 'available' : 'unavailable',
//         },
//       );
//
//       var d = json.decode(response.body);
//       if (d['status'] == 'ok') {
//         // Persist the state locally
//         await sh.setBool('isAvailable', status);
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               status ? 'You are now Online' : 'You are now Offline',
//               style: TextStyle(fontWeight: FontWeight.w600),
//             ),
//             backgroundColor: status ? Colors.green : Colors.red,
//             duration: const Duration(seconds: 1),
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         );
//       } else {
//         throw Exception("Server rejected update");
//       }
//     } catch (e) {
//       // Revert toggle UI if API fails
//       setState(() {
//         isAvailable = !status;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Connection Error: Could not update status'),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       );
//     }
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'DRIVER DASHBOARD',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1,
//             shadows: [
//               Shadow(
//                 color: Colors.white.withOpacity(0.3),
//                 blurRadius: 5,
//               ),
//             ],
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
//       drawer: Drawer(
//         child: Container(
//           color: Colors.grey.shade50,
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               Container(
//                 height: 200,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Color(0xFFF57C00),
//                       Color(0xFFFF9800),
//                     ],
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0xFFF57C00).withOpacity(0.3),
//                       blurRadius: 10,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: DrawerHeader(
//                   margin: EdgeInsets.zero,
//                   padding: EdgeInsets.zero,
//                   decoration: BoxDecoration(),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: 80,
//                         height: 80,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.white, width: 3),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.white.withOpacity(0.3),
//                               blurRadius: 10,
//                             ),
//                           ],
//                         ),
//                         child: CircleAvatar(
//                           backgroundColor: Colors.white,
//                           radius: 37,
//                           child: Icon(
//                             Icons.person,
//                             size: 50,
//                             color: Color(0xFFF57C00),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Driver Menu',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 1,
//                         ),
//                       ),
//                       Text(
//                         'Navigate to sections',
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.8),
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               _buildDrawerItem(Icons.home, 'Home', () => Navigator.pop(context), isFirst: true),
//               _buildDrawerItem(Icons.check_circle, 'Approved Request', () => _nav(const view_approved_request())),
//               _buildDrawerItem(Icons.add_circle, 'Add Vehicle Details', () => _nav(const add_vehicle_details())),
//               _buildDrawerItem(Icons.location_on, 'Passenger Location', () => _nav(const view_passenger_location())),
//               _buildDrawerItem(Icons.notifications, 'Passenger Requests', () => _nav(const view_passenger_request())),
//               _buildDrawerItem(Icons.payment, 'Payment Logs', () => _nav(const view_payment_logs())),
//               _buildDrawerItem(Icons.history, 'Ride History', () => _nav(const view_ride_history())),
//               _buildDrawerItem(Icons.star, 'Reviews', () => _nav(const view_reviews())),
//               Divider(
//                 color: Colors.grey.shade300,
//                 thickness: 1,
//                 height: 20,
//               ),
//               _buildDrawerItem(Icons.person_outline, 'My Profile', () => _nav(const driver_view_profile())),
//               _buildDrawerItem(Icons.directions_car, 'Vehicle Details', () => _nav(const view_vehicle_details())),
//               _buildDrawerItem(Icons.lock_reset, 'Change Password', () => _nav(const change_password())),
//               _buildDrawerItem(Icons.exit_to_app, 'LOgout', () => _nav(const LoginPage())),
//
//             ],
//           ),
//         ),
//       ),
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               isAvailable ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
//               Colors.grey.shade50,
//             ],
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Animated Status Icon
//             AnimatedContainer(
//               duration: Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//               width: 120,
//               height: 120,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: RadialGradient(
//                   colors: [
//                     isAvailable ? Colors.green : Colors.red,
//                     isAvailable ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.5),
//                   ],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: (isAvailable ? Colors.green : Colors.red).withOpacity(0.5),
//                     blurRadius: 20,
//                     spreadRadius: 5,
//                   ),
//                 ],
//               ),
//               child: Icon(
//                 isAvailable ? Icons.check_circle : Icons.do_not_disturb_on,
//                 size: 60,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 30),
//
//             // Status Text
//             AnimatedDefaultTextStyle(
//               duration: Duration(milliseconds: 300),
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: isAvailable ? Colors.green : Colors.red,
//                 letterSpacing: 1,
//                 shadows: [
//                   Shadow(
//                     color: (isAvailable ? Colors.green : Colors.red).withOpacity(0.3),
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               child: Text(
//                 isAvailable ? 'ONLINE' : 'OFFLINE',
//               ),
//             ),
//
//             SizedBox(height: 10),
//
//             Text(
//               isAvailable ? 'You are available to receive ride requests' : 'You are not available for rides',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey.shade600,
//               ),
//               textAlign: TextAlign.center,
//             ),
//
//             SizedBox(height: 40),
//
//             // Toggle Switch with Card
//             Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       Icons.power_settings_new,
//                       color: isAvailable ? Colors.green : Colors.red,
//                       size: 24,
//                     ),
//                     SizedBox(width: 15),
//                     Transform.scale(
//                       scale: 1.8,
//                       child: Switch(
//                         value: isAvailable,
//                         activeColor: Colors.green,
//                         activeTrackColor: Colors.green.withOpacity(0.5),
//                         inactiveThumbColor: Colors.red,
//                         inactiveTrackColor: Colors.red.withOpacity(0.3),
//                         onChanged: isLoading ? null : (value) {
//                           setState(() {
//                             isAvailable = value;
//                           });
//                           saveAvailability(value);
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 15),
//                     Text(
//                       isAvailable ? 'ON' : 'OFF',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: isAvailable ? Colors.green : Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             if (isLoading)
//               Padding(
//                 padding: EdgeInsets.only(top: 30),
//                 child: Column(
//                   children: [
//                     CircularProgressIndicator(
//                       color: Color(0xFFF57C00),
//                       strokeWidth: 3,
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Updating status...',
//                       style: TextStyle(color: Colors.grey.shade600),
//                     ),
//                   ],
//                 ),
//               ),
//
//             SizedBox(height: 30),
//
//             // Quick Stats Section
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.shade200,
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//
//             ),
//
//             SizedBox(height: 20),
//
//             // Quick Actions
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: _buildQuickActionButton(
//                       icon: Icons.notifications,
//                       label: 'Requests',
//                       onTap: () => _nav(const view_passenger_request()),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: _buildQuickActionButton(
//                       icon: Icons.check_circle,
//                       label: 'Approved',
//                       onTap: () => _nav(const view_approved_request()),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatItem(IconData icon, String value, String label) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Color(0xFFF57C00).withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: Color(0xFFF57C00), size: 25),
//         ),
//         SizedBox(height: 8),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.grey.shade800,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey.shade600,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildQuickActionButton({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(10),
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 12),
//         decoration: BoxDecoration(
//           color: Color(0xFFF57C00).withOpacity(0.1),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Color(0xFFF57C00).withOpacity(0.3)),
//         ),
//         child: Column(
//           children: [
//             Icon(icon, color: Color(0xFFF57C00), size: 28),
//             SizedBox(height: 5),
//             Text(
//               label,
//               style: TextStyle(
//                 color: Color(0xFFF57C00),
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Helper function for Navigation
//   void _nav(Widget page) {
//     Navigator.push(context, MaterialPageRoute(builder: (_) => page));
//   }
//
//   // Helper for Drawer Items
//   ListTile _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {bool isFirst = false}) {
//     return ListTile(
//       leading: Container(
//         padding: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: isFirst ? Color(0xFFF57C00).withOpacity(0.1) : Colors.transparent,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Icon(
//           icon,
//           color: isFirst ? Color(0xFFF57C00) : Colors.grey.shade700,
//         ),
//       ),
//       title: Text(
//         title,
//         style: TextStyle(
//           fontWeight: isFirst ? FontWeight.bold : FontWeight.normal,
//           color: isFirst ? Color(0xFFF57C00) : Colors.grey.shade800,
//         ),
//       ),
//       onTap: onTap,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       tileColor: isFirst ? Color(0xFFF57C00).withOpacity(0.05) : null,
//     );
//   }
// }






import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickshaw_ride/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import your local files (ensure these paths match your project structure)
import 'package:rickshaw_ride/driver/add_vehicle_details.dart';
import 'package:rickshaw_ride/driver/change_password.dart';
import 'package:rickshaw_ride/driver/view_approved_request.dart';
import 'package:rickshaw_ride/driver/view_passenger_location.dart';
import 'package:rickshaw_ride/driver/view_passenger_request.dart';
import 'package:rickshaw_ride/driver/view_payment_logs.dart';
import 'package:rickshaw_ride/driver/view_reviews.dart';
import 'package:rickshaw_ride/driver/view_ride_history.dart';
import 'package:rickshaw_ride/driver/view_vehicle_details.dart';
import 'package:rickshaw_ride/driver/viewprofile.dart';

class drhome extends StatelessWidget {
  const drhome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFF57C00),
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.black,
        cardColor: const Color(0xFF1E1E1E),
        dividerColor: const Color(0xFFF57C00).withValues(alpha: 0.2),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFF57C00),
          secondary: Color(0xFFF57C00),
          surface: Color(0xFF1E1E1E),
          error: Colors.redAccent,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Color(0xFFF57C00),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFFF57C00),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
          iconTheme: IconThemeData(color: Color(0xFFF57C00)),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          titleLarge: TextStyle(color: Color(0xFFF57C00)),
        ),
      ),
      home: const drhomesub(),
    );
  }
}

class drhomesub extends StatefulWidget {
  const drhomesub({super.key});

  @override
  State<drhomesub> createState() => _drhomesubState();
}

class _drhomesubState extends State<drhomesub> with SingleTickerProviderStateMixin {
  bool isAvailable = false;
  bool isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _loadCurrentStatus();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// 🔹 Load status from SharedPreferences
  _loadCurrentStatus() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    setState(() {
      isAvailable = sh.getBool('isAvailable') ?? false;
    });
  }

  /// 🔹 API call to save availability to Python Backend
  Future<void> saveAvailability(bool status) async {
    setState(() {
      isLoading = true;
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('ip').toString();
      String did = sh.getString('did').toString();

      final response = await http.post(
        Uri.parse('$url/driver_update_availability'),
        body: {
          'did': did,
          'status': status ? 'available' : 'unavailable',
        },
      );

      var d = json.decode(response.body);
      if (d['status'] == 'ok') {
        await sh.setBool('isAvailable', status);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  status ? Icons.check_circle : Icons.power_off,
                  color: Colors.black,
                ),
                const SizedBox(width: 12),
                Text(
                  status ? 'You are now Online' : 'You are now Offline',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            backgroundColor: status
                ? const Color(0xFFF57C00).withValues(alpha: 0.9)
                : Colors.grey.shade800.withValues(alpha: 0.9),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: const Color(0xFFF57C00).withValues(alpha: 0.3),
                width: 1,
              ),
            ),
          ),
        );
      } else {
        throw Exception("Server rejected update");
      }
    } catch (e) {
      setState(() {
        isAvailable = !status;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 12),
              Text('Connection Error: Could not update status'),
            ],
          ),
          backgroundColor: Colors.red.shade900,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DRIVER DASHBOARD',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFF57C00).withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.refresh, color: Color(0xFFF57C00)),
              onPressed: () {
                setState(() {});
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                const Color(0xFFF57C00).withValues(alpha: 0.05),
              ],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 220,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFF57C00),
                      const Color(0xFFF57C00).withValues(alpha: 0.7),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: 0.2),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 42,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Color(0xFFF57C00),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Driver Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        'Navigate to sections',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildDrawerItem(Icons.home, 'Home', () => Navigator.pop(context), isFirst: true),
              _buildDrawerItem(Icons.check_circle, 'Approved Request', () => _nav(const view_approved_request())),
              _buildDrawerItem(Icons.add_circle, 'Add Vehicle Details', () => _nav(const add_vehicle_details())),
              _buildDrawerItem(Icons.location_on, 'Passenger Location', () => _nav(const view_passenger_location())),
              _buildDrawerItem(Icons.notifications, 'Passenger Requests', () => _nav(const view_passenger_request())),
              _buildDrawerItem(Icons.payment, 'Payment Logs', () => _nav(const view_payment_logs())),
              _buildDrawerItem(Icons.history, 'Ride History', () => _nav(const view_ride_history())),
              _buildDrawerItem(Icons.star, 'Reviews', () => _nav(const view_reviews())),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Divider(
                  color: const Color(0xFFF57C00).withValues(alpha: 0.3),
                  thickness: 1,
                ),
              ),
              _buildDrawerItem(Icons.person_outline, 'My Profile', () => _nav(const driver_view_profile())),
              _buildDrawerItem(Icons.directions_car, 'Vehicle Details', () => _nav(const view_vehicle_details())),
              _buildDrawerItem(Icons.lock_reset, 'Change Password', () => _nav(const change_password())),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
                ),
                child: _buildDrawerItem(Icons.exit_to_app, 'LOGOUT', () => _nav(const LoginPage())),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              const Color(0xFFF57C00).withValues(alpha: isAvailable ? 0.15 : 0.05),
              Colors.black,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Status Icon with Pulse Effect
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          isAvailable ? const Color(0xFFF57C00) : Colors.grey.shade800,
                          Colors.black,
                        ],
                        stops: const [0.5, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (isAvailable ? const Color(0xFFF57C00) : Colors.grey.shade700).withValues(alpha: 0.5),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      isAvailable ? Icons.power : Icons.power_off,
                      size: 70,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),

            // Status Text
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isAvailable ? const Color(0xFFF57C00) : Colors.grey.shade700,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isAvailable ? const Color(0xFFF57C00) : Colors.grey.shade700).withValues(alpha: 0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Text(
                isAvailable ? 'ONLINE' : 'OFFLINE',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isAvailable ? const Color(0xFFF57C00) : Colors.grey.shade400,
                  letterSpacing: 3,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              isAvailable
                  ? 'Ready to serve passengers'
                  : 'Not available for rides',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // Premium Toggle Switch
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    const Color(0xFFF57C00).withValues(alpha: 0.1),
                    Colors.black,
                  ],
                ),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: isAvailable
                      ? const Color(0xFFF57C00).withValues(alpha: 0.5)
                      : Colors.grey.shade700.withValues(alpha: 0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isAvailable ? const Color(0xFFF57C00) : Colors.grey.shade700).withValues(alpha: 0.2),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.power_settings_new,
                    color: isAvailable ? const Color(0xFFF57C00) : Colors.grey.shade400,
                    size: 28,
                  ),
                  const SizedBox(width: 20),
                  Transform.scale(
                    scale: 1.8,
                    child: Switch(
                      value: isAvailable,
                      activeTrackColor: const Color(0xFFF57C00).withValues(alpha: 0.3),
                      inactiveThumbColor: Colors.grey.shade400,
                      inactiveTrackColor: Colors.grey.shade700.withValues(alpha: 0.3),
                      onChanged: isLoading ? null : (value) {
                        setState(() {
                          isAvailable = value;
                        });
                        saveAvailability(value);
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    isAvailable ? 'ON' : 'OFF',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isAvailable ? const Color(0xFFF57C00) : Colors.grey.shade400,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),

            if (isLoading)
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      color: const Color(0xFFF57C00),
                      strokeWidth: 3,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Updating status...',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 30),

            // Quick Actions with Premium Design
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildQuickActionButton(
                      icon: Icons.notifications,
                      label: 'Requests',
                      onTap: () => _nav(const view_passenger_request()),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildQuickActionButton(
                      icon: Icons.check_circle,
                      label: 'Approved',
                      onTap: () => _nav(const view_approved_request()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFF57C00).withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF57C00).withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFF57C00).withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Icon(icon, color: const Color(0xFFF57C00), size: 28),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              const Color(0xFFF57C00).withValues(alpha: 0.2),
              Colors.black,
            ],
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color(0xFFF57C00).withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF57C00).withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFFF57C00), size: 30),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function for Navigation
  void _nav(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  // Premium Drawer Item
  ListTile _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {bool isFirst = false}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              isFirst ? const Color(0xFFF57C00) : Colors.transparent,
              isFirst ? const Color(0xFFF57C00).withValues(alpha: 0.5) : Colors.transparent,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          border: !isFirst ? Border.all(
            color: const Color(0xFFF57C00).withValues(alpha: 0.2),
            width: 1,
          ) : null,
        ),
        child: Icon(
          icon,
          color: isFirst ? Colors.black : const Color(0xFFF57C00),
          size: 22,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isFirst ? FontWeight.bold : FontWeight.w500,
          color: isFirst ? const Color(0xFFF57C00) : Colors.white,
          fontSize: 15,
          letterSpacing: 0.5,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      tileColor: isFirst ? const Color(0xFFF57C00).withValues(alpha: 0.1) : null,
    );
  }
}