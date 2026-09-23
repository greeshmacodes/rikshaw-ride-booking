// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/driver/drhome.dart';
// import 'package:rickshaw_ride/driver/drregister.dart';
// import 'package:rickshaw_ride/locationservice.dart';
// import 'package:rickshaw_ride/main.dart';
// import 'package:rickshaw_ride/user/register.dart';
// import 'package:rickshaw_ride/user/urhome.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// void main(){
//   runApp(login());
// }
// class login extends StatelessWidget {
//   const login({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: loginsub(),);
//   }
// }
//
// class loginsub extends StatefulWidget {
//   const loginsub({Key? key}) : super(key: key);
//
//   @override
//   State<loginsub> createState() => _loginsubState();
// }
//
// class _loginsubState extends State<loginsub> {
//   final formkey = GlobalKey<FormState>();
//   final username = TextEditingController(text: "");
//   final password = TextEditingController(text: "");
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(key: formkey,child: Center(child: Column(
//         children: [
//
//           SizedBox(height: 20,),
//           SizedBox(width: 400,child:
//           TextFormField(validator: (value){
//             if(value == null || value.isEmpty){
//               return 'Required';
//             }return null;
//           },
//             controller: username,
//             decoration: InputDecoration(labelText: "Username"),
//           ),),
//           SizedBox(height: 10,),
//           SizedBox(width: 400,child:
//           TextFormField(validator: (value){
//             if(value == null || value.isEmpty){
//               return 'Required';
//             }return null;
//           },
//             controller: password,
//             decoration: InputDecoration(labelText: "Password"),
//           ),),
//           SizedBox(height: 10,),
//
//           ElevatedButton(onPressed: () async {
//             SharedPreferences sh = await SharedPreferences.getInstance();
//             var data =
//             await http.post(Uri.parse(sh.getString("ip").toString()+"/userlogin"),
//                 body: {
//               'username':username.text,
//                   'password':password.text,
//                 }
//             );
//
//             var jsonData = json.decode(data.body);
//             print(jsonData);
//             if(jsonData['status'] == 'ok'){
//               print(jsonData['type'] == 'user');
//               if(jsonData['type'] == 'driver'){
//                 sh.setString('did', jsonData['did'].toString());
//                 sh.setString('passw', password.toString());
//                 final locationService = LocationService();
//
//
//                 locationService.onNotificationMessage = (message) {
//                   // 🎯 context is available here!
//                   if (kIsWeb) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text(message)),
//                     );
//                   } else {
//                     NotificationHelper.showNotification('📢 Update', message);
//                   }
//                 };
//
//                 locationService.startLocationUpdates(jsonData['did'].toString());
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>drhome()));
//
//               }
//               else if(jsonData['type'] == 'user'){
//                 sh.setString('uid', jsonData['uid'].toString());
//                 sh.setString('passw', password.toString());
//                 final locationService = LocationService();
//
//
//                 locationService.onNotificationMessage = (message) {
//                   // 🎯 context is available here!
//                   if (kIsWeb) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text(message)),
//                     );
//                   } else {
//                     NotificationHelper.showNotification('📢 Update', message);
//                   }
//                 };
//
//                 locationService.startLocationUpdates(jsonData['uid'].toString());
//                 print("haiiiiiii");
//                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
//                 showDialog<void>(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: const Text('Login Failed'),
//                       content: const Text(
//                         'please check the username & password',
//                       ),
//                       actions: <Widget>[
//                         TextButton(
//                           style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
//                           child: const Text('Disable'),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         TextButton(
//                           style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
//                           child: const Text('Enable'),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ],
//                     );
//                   },
//                 );
//
//               }
//             }
//             else{
//               showDialog<void>(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: const Text('Login Failed'),
//                     content: const Text(
//                       'please check the username & password',
//                     ),
//                     actions: <Widget>[
//                       TextButton(
//                         style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
//                         child: const Text('Disable'),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                       TextButton(
//                         style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
//                         child: const Text('Enable'),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               );
//             }
//
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
//           }, child: Text("Login")),
//           TextButton(onPressed: () async {
//             SharedPreferences sh = await SharedPreferences.getInstance();
//
//             final locationService = LocationService();
//
//
//             locationService.onNotificationMessage = (message) {
//               // 🎯 context is available here!
//               if (kIsWeb) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(message)),
//                 );
//               } else {
//                 NotificationHelper.showNotification('📢 Update', message);
//               }
//             };
//
//             locationService.startLocationUpdates("123");
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>register()));
//
//           }, child: Text("Create Account For User")),
//           SizedBox(height: 20,),
//
//           TextButton(onPressed: () async {
//             SharedPreferences sh = await SharedPreferences.getInstance();
//
//             final locationService = LocationService();
//
//
//             locationService.onNotificationMessage = (message) {
//               // 🎯 context is available here!
//               if (kIsWeb) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(message)),
//                 );
//               } else {
//                 NotificationHelper.showNotification('📢 Update', message);
//               }
//             };
//
//             locationService.startLocationUpdates("123");
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>drregister()));
//
//           }, child: Text("Create Account For Driver")),
//
//           TextButton(onPressed: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>register()));
//           }, child: Text('ForgotPassword')),
//         ],
//       ),
//
//       )),
//
//     );
//   }
// }
//
//
// //
// // import 'dart:convert';
// //
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // import 'package:rickshaw_ride/driver/drhome.dart';
// // import 'package:rickshaw_ride/driver/drregister.dart';
// // import 'package:rickshaw_ride/user/register.dart';
// // import 'package:rickshaw_ride/user/urhome.dart';
// //
// // void main() {
// //   runApp(const LoginApp());
// // }
// //
// // class LoginApp extends StatelessWidget {
// //   const LoginApp({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: LoginPage(),
// //     );
// //   }
// // }
// //
// // class LoginPage extends StatefulWidget {
// //   const LoginPage({Key? key}) : super(key: key);
// //
// //   @override
// //   State<LoginPage> createState() => _LoginPageState();
// // }
// //
// // class _LoginPageState extends State<LoginPage> {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController username = TextEditingController();
// //   final TextEditingController password = TextEditingController();
// //
// //   Future<void> doLogin() async {
// //     if (!_formKey.currentState!.validate()) return;
// //
// //     SharedPreferences sh = await SharedPreferences.getInstance();
// //     String? ip = sh.getString("ip");
// //
// //     if (ip == null) {
// //       showMsg("Server IP not set");
// //       return;
// //     }
// //
// //     var response = await http.post(
// //       Uri.parse("$ip/userlogin"),
// //       body: {
// //         'username': username.text,
// //         'password': password.text,
// //       },
// //     );
// //
// //     var jsonData = json.decode(response.body);
// //
// //     if (jsonData['status'] == 'ok') {
// //       if (jsonData['type'] == 'driver') {
// //         sh.setString('did', jsonData['did'].toString());
// //         sh.setString('passw', password.text);
// //
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (_) => const drhome()),
// //         );
// //       } else if (jsonData['type'] == 'user') {
// //         sh.setString('uid', jsonData['uid'].toString());
// //         sh.setString('passw', password.text);
// //
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (_) => const urhome()),
// //         );
// //       }
// //     } else {
// //       showMsg("Invalid username or password");
// //     }
// //   }
// //
// //   void showMsg(String msg) {
// //     showDialog(
// //       context: context,
// //       builder: (_) => AlertDialog(
// //         title: const Text("Message"),
// //         content: Text(msg),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: const Text("OK"),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: Form(
// //           key: _formKey,
// //           child: SingleChildScrollView(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //
// //                 const Text(
// //                   "Login",
// //                   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
// //                 ),
// //
// //                 const SizedBox(height: 20),
// //
// //                 SizedBox(
// //                   width: 300,
// //                   child: TextFormField(
// //                     controller: username,
// //                     decoration: const InputDecoration(
// //                       labelText: "Username",
// //                       border: OutlineInputBorder(),
// //                     ),
// //                     validator: (v) =>
// //                     v!.isEmpty ? "Username required" : null,
// //                   ),
// //                 ),
// //
// //                 const SizedBox(height: 15),
// //
// //                 SizedBox(
// //                   width: 300,
// //                   child: TextFormField(
// //                     controller: password,
// //                     obscureText: true,
// //                     decoration: const InputDecoration(
// //                       labelText: "Password",
// //                       border: OutlineInputBorder(),
// //                     ),
// //                     validator: (v) =>
// //                     v!.isEmpty ? "Password required" : null,
// //                   ),
// //                 ),
// //
// //                 const SizedBox(height: 20),
// //
// //                 ElevatedButton(
// //                   onPressed: doLogin,
// //                   child: const Text("Login"),
// //                 ),
// //
// //                 const SizedBox(height: 20),
// //
// //                 TextButton(
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (_) => const register()),
// //                     );
// //                   },
// //                   child: const Text("Create Account For User"),
// //                 ),
// //
// //                 TextButton(
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (_) => const drregister()),
// //                     );
// //                   },
// //                   child: const Text("Create Account For Driver"),
// //                 ),
// //
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/locationservice.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'package:rickshaw_ride/driver/drhome.dart';
// import 'package:rickshaw_ride/driver/drregister.dart';
// import 'package:rickshaw_ride/user/register.dart';
// import 'package:rickshaw_ride/user/urhome.dart';
//
// void main() {
//   runApp(const LoginApp());
// }
//
// class LoginApp extends StatelessWidget {
//   const LoginApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoginPage(),
//     );
//   }
// }
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final username = TextEditingController();
//   final password = TextEditingController();
//
//   Future<void> doLogin() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     final ip = sh.getString("ip");
//
//     if (ip == null || ip.isEmpty) {
//       showMsg("Server IP not set");
//       return;
//     }
//
//     http.Response response;
//
//     try {
//       response = await http.post(
//         Uri.parse("$ip/userlogin"),
//         body: {
//           'username': username.text,
//           'password': password.text,
//         },
//       );
//     } catch (e) {
//       showMsg("Network error");
//       return;
//     }
//
//     final contentType = response.headers['content-type'] ?? "";
//
//     if (!contentType.contains('application/json')) {
//       showMsg("Server error (invalid response)");
//       return;
//     }
//
//     final jsonData = jsonDecode(response.body);
//
//     if (jsonData['status'] == 'ok') {
//       if (jsonData['type'] == 'driver') {
//         sh.setString('did', jsonData['did'].toString());
//         sh.setString('password', password.text);
//         final locationService = LocationService();
//
//
//         locationService.onNotificationMessage = (message) {
//           // 🎯 context is available here!
//           if (kIsWeb) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(message)),
//             );
//           } else {
//             NotificationHelper.showNotification('📢 Update', message);
//           }
//         };
//
//         locationService.startLocationUpdates("123");
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const drhome()),
//         );
//       } else if (jsonData['type'] == 'user') {
//         sh.setString('uid', jsonData['uid'].toString());
//         sh.setString('password', password.text);
//
//         final locationService = LocationService();
//
//
//         locationService.onNotificationMessage = (message) {
//           // 🎯 context is available here!
//           if (kIsWeb) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(message)),
//             );
//           } else {
//             NotificationHelper.showNotification('📢 Update', message);
//           }
//         };
//
//         locationService.startLocationUpdates("123");
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const urhome()),
//         );
//       }
//     } else {
//       showMsg("Invalid username or password");
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
//     }
//   }
//
//   void showMsg(String msg) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Message"),
//         content: Text(msg),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//
//                 const Text(
//                   "Login",
//                   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 SizedBox(
//                   width: 300,
//                   child: TextFormField(
//                     controller: username,
//                     decoration: const InputDecoration(
//                       labelText: "Username",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (v) =>
//                     v == null || v.isEmpty ? "Username required" : null,
//                   ),
//                 ),
//
//                 const SizedBox(height: 15),
//
//                 SizedBox(
//                   width: 300,
//                   child: TextFormField(
//                     controller: password,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       labelText: "Password",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (v) =>
//                     v == null || v.isEmpty ? "Password required" : null,
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 ElevatedButton(
//                   onPressed: doLogin,
//                   child: const Text("Login"),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const register()),
//                     );
//                   },
//                   child: const Text("Create Account For User"),
//                 ),
//
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const drregister()),
//                     );
//                   },
//                   child: const Text("Create Account For Driver"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


//.......................................................................................................................
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/locationservice.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:rickshaw_ride/driver/drhome.dart';
// import 'package:rickshaw_ride/driver/drregister.dart';
// import 'package:rickshaw_ride/user/register.dart';
// import 'package:rickshaw_ride/user/urhome.dart';
//
// void main() {
//   runApp(const LoginApp());
// }
//
// class LoginApp extends StatelessWidget {
//   const LoginApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Colors.deepPurple,
//         colorScheme: ColorScheme.fromSwatch(
//           primarySwatch: Colors.deepPurple,
//           accentColor: Colors.amber,
//         ),
//         fontFamily: 'Poppins',
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             foregroundColor: Colors.white,
//             backgroundColor: Colors.deepPurple,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//             textStyle: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
//           ),
//           filled: true,
//           fillColor: Colors.grey[50],
//           contentPadding: const EdgeInsets.all(18),
//           labelStyle: const TextStyle(
//             color: Colors.grey,
//             fontSize: 14,
//           ),
//         ),
//       ),
//       home: const LoginPage(),
//     );
//   }
// }
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final username = TextEditingController();
//   final password = TextEditingController();
//
//   Future<void> doLogin() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     final ip = sh.getString("ip");
//
//     if (ip == null || ip.isEmpty) {
//       showMsg("Server IP not set");
//       return;
//     }
//
//     http.Response response;
//
//     try {
//       response = await http.post(
//         Uri.parse("$ip/userlogin"),
//         body: {
//           'username': username.text,
//           'password': password.text,
//         },
//       );
//     } catch (e) {
//       showMsg("Network error");
//       return;
//     }
//
//     final contentType = response.headers['content-type'] ?? "";
//
//     if (!contentType.contains('application/json')) {
//       showMsg("Server error (invalid response)");
//       return;
//     }
//
//     final jsonData = jsonDecode(response.body);
//
//     if (jsonData['status'] == 'ok') {
//       if (jsonData['type'] == 'driver') {
//         sh.setString('did', jsonData['did'].toString());
//         sh.setString('password', password.text);
//         final locationService = LocationService();
//
//         locationService.onNotificationMessage = (message) {
//           if (kIsWeb) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(message),
//                 backgroundColor: Colors.deepPurple,
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//           } else {
//             NotificationHelper.showNotification('📢 Update', message);
//           }
//         };
//
//         locationService.startLocationUpdates("123");
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const drhome()),
//         );
//       } else if (jsonData['type'] == 'user') {
//         sh.setString('uid', jsonData['uid'].toString());
//         sh.setString('password', password.text);
//
//         final locationService = LocationService();
//
//         locationService.onNotificationMessage = (message) {
//           if (kIsWeb) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(message),
//                 backgroundColor: Colors.deepPurple,
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//           } else {
//             NotificationHelper.showNotification('📢 Update', message);
//           }
//         };
//
//         locationService.startLocationUpdates("123");
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const urhome()),
//         );
//       }
//     } else {
//       showMsg("Invalid username or password");
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginPage()),
//       );
//     }
//   }
//
//   void showMsg(String msg) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         elevation: 8,
//         title: const Text(
//           "Message",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.deepPurple,
//           ),
//         ),
//         content: Text(
//           msg,
//           style: const TextStyle(fontSize: 16),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text(
//               "OK",
//               style: TextStyle(
//                 color: Colors.deepPurple,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Container(
//               constraints: const BoxConstraints(maxWidth: 400),
//               margin: const EdgeInsets.all(20),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 40),
//
//                     // App Logo/Icon
//                     Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Colors.deepPurple,
//                         borderRadius: BorderRadius.circular(60),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.deepPurple.withOpacity(0.3),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.directions_car_filled,
//                         size: 60,
//                         color: Colors.white,
//                       ),
//                     ),
//
//                     const SizedBox(height: 30),
//
//                     // Title
//                     const Text(
//                       "Welcome Back",
//                       style: TextStyle(
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.deepPurple,
//                       ),
//                     ),
//
//                     const SizedBox(height: 8),
//
//                     const Text(
//                       "Sign in to continue",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey,
//                       ),
//                     ),
//
//                     const SizedBox(height: 40),
//
//                     // Username Field
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: TextFormField(
//                         controller: username,
//                         decoration: const InputDecoration(
//                           labelText: "Username",
//                           prefixIcon: Icon(
//                             Icons.person,
//                             color: Colors.deepPurple,
//                           ),
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (v) =>
//                         v == null || v.isEmpty ? "Username required" : null,
//                       ),
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     // Password Field
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: TextFormField(
//                         controller: password,
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           labelText: "Password",
//                           prefixIcon: Icon(
//                             Icons.lock,
//                             color: Colors.deepPurple,
//                           ),
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (v) =>
//                         v == null || v.isEmpty ? "Password required" : null,
//                       ),
//                     ),
//
//                     const SizedBox(height: 10),
//
//                     // Forgot Password
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {
//                           // Forgot password functionality
//                         },
//                         child: const Text(
//                           "Forgot Password?",
//                           style: TextStyle(
//                             color: Colors.deepPurple,
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 30),
//
//                     // Login Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton.icon(
//                         onPressed: doLogin,
//                         icon: const Icon(Icons.login),
//                         label: const Text(
//                           "Sign In",
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 18),
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 30),
//
//                     // Divider
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Divider(
//                             color: Colors.grey[300],
//                             thickness: 1,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           child: Text(
//                             "OR",
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Divider(
//                             color: Colors.grey[300],
//                             thickness: 1,
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 30),
//
//                     // Register Buttons
//                     Column(
//                       children: [
//                         SizedBox(
//                           width: double.infinity,
//                           child: OutlinedButton.icon(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => const register(),
//                                 ),
//                               );
//                             },
//                             icon: const Icon(Icons.person_add),
//                             label: const Text("Create User Account"),
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: Colors.deepPurple,
//                               side: const BorderSide(color: Colors.deepPurple),
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 15),
//
//                         SizedBox(
//                           width: double.infinity,
//                           child: OutlinedButton.icon(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => const drregister(),
//                                 ),
//                               );
//                             },
//                             icon: const Icon(Icons.directions_car_filled),
//                             label: const Text("Create Driver Account"),
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: Colors.amber[700],
//                               side: BorderSide(color: Colors.amber[700]!),
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 40),
//
//                     // Footer
//                     Text(
//                       "Rickshaw Ride © 2024",
//                       style: TextStyle(
//                         color: Colors.grey[500],
//                         fontSize: 14,
//                       ),
//                     ),
//
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// last working code .....................................................................................................

//
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/locationservice.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:rickshaw_ride/driver/drhome.dart';
// import 'package:rickshaw_ride/driver/drregister.dart';
// import 'package:rickshaw_ride/user/register.dart';
// import 'package:rickshaw_ride/user/urhome.dart';
//
// void main() {
//   runApp(const LoginApp());
// }
//
// class LoginApp extends StatelessWidget {
//   const LoginApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Colors.deepPurple,
//         colorScheme: ColorScheme.fromSwatch(
//           primarySwatch: Colors.deepPurple,
//           accentColor: Colors.amber,
//         ),
//         fontFamily: 'Poppins',
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             foregroundColor: Colors.white,
//             backgroundColor: Colors.deepPurple,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//             textStyle: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
//           ),
//           filled: true,
//           fillColor: Colors.grey[50],
//           contentPadding: const EdgeInsets.all(18),
//           labelStyle: const TextStyle(
//             color: Colors.grey,
//             fontSize: 14,
//           ),
//         ),
//       ),
//       home: const LoginPage(),
//     );
//   }
// }
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final username = TextEditingController();
//   final password = TextEditingController();
//   bool _isLoading = false;
//   bool _obscurePassword = true;
//
//   Future<void> doLogin() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     final ip = sh.getString("ip");
//
//     if (ip == null || ip.isEmpty) {
//       showMsg("Server IP not set");
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }
//
//     http.Response response;
//
//     try {
//       response = await http.post(
//         Uri.parse("$ip/userlogin"),
//         body: {
//           'username': username.text,
//           'password': password.text,
//         },
//       );
//     } catch (e) {
//       showMsg("Network error");
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }
//
//     final contentType = response.headers['content-type'] ?? "";
//
//     if (!contentType.contains('application/json')) {
//       showMsg("Server error (invalid response)");
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }
//
//     final jsonData = jsonDecode(response.body);
//
//     if (jsonData['status'] == 'ok') {
//       if (jsonData['type'] == 'driver') {
//         sh.setString('did', jsonData['did'].toString());
//         sh.setString('password', password.text);
//         final locationService = LocationService();
//
//         locationService.onNotificationMessage = (message) {
//           if (kIsWeb) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(message),
//                 backgroundColor: Colors.deepPurple,
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//           } else {
//             // NotificationHelper.showNotification('📢 Update', message);
//           }
//         };
//
//         locationService.startLocationUpdates("123");
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const drhome()),
//         );
//       } else if (jsonData['type'] == 'user') {
//         sh.setString('uid', jsonData['uid'].toString());
//         sh.setString('password', password.text);
//
//         final locationService = LocationService();
//
//         locationService.onNotificationMessage = (message) {
//           if (kIsWeb) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(message),
//                 backgroundColor: Colors.deepPurple,
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//           } else {
//             // NotificationHelper.showNotification('📢 Update', message);
//           }
//         };
//
//         locationService.startLocationUpdates("123");
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const urhome()),
//         );
//       }
//     } else {
//       showMsg("Invalid username or password");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void showMsg(String msg) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         elevation: 8,
//         title: const Text(
//           "Message",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.deepPurple,
//           ),
//         ),
//         content: Text(
//           msg,
//           style: const TextStyle(fontSize: 16),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text(
//               "OK",
//               style: TextStyle(
//                 color: Colors.deepPurple,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Colors.deepPurple.shade50,
//               Colors.amber.shade50,
//               Colors.white,
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Top decorative wave
//                 Container(
//                   height: 150,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.deepPurple.shade600,
//                         Colors.deepPurple.shade400,
//                       ],
//                     ),
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(40),
//                       bottomRight: Radius.circular(40),
//                     ),
//                   ),
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const SizedBox(height: 20),
//                         Icon(
//                           Icons.directions_car_filled,
//                           size: 50,
//                           color: Colors.white.withOpacity(0.9),
//                         ),
//                         const SizedBox(height: 10),
//                         const Text(
//                           "Rickshaw Ride",
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             letterSpacing: 1.2,
//                           ),
//                         ),
//                         const Text(
//                           "Your Journey, Our Priority",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.white70,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Login Form Card
//                 Padding(
//                   padding: const EdgeInsets.all(25.0),
//                   child: Card(
//                     elevation: 10,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     shadowColor: Colors.deepPurple.withOpacity(0.3),
//                     child: Padding(
//                       padding: const EdgeInsets.all(30.0),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             const Text(
//                               "Welcome Back",
//                               style: TextStyle(
//                                 fontSize: 26,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.deepPurple,
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             const Text(
//                               "Sign in to continue your journey",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             const SizedBox(height: 30),
//
//                             // Username Field
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.deepPurple.withOpacity(0.1),
//                                     blurRadius: 15,
//                                     offset: const Offset(0, 5),
//                                   ),
//                                 ],
//                               ),
//                               child: TextFormField(
//                                 controller: username,
//                                 decoration: InputDecoration(
//                                   labelText: "Username",
//                                   hintText: "Enter your username",
//                                   prefixIcon: Container(
//                                     margin: const EdgeInsets.all(12),
//                                     decoration: BoxDecoration(
//                                       color: Colors.deepPurple.withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Icon(
//                                       Icons.person,
//                                       color: Colors.deepPurple.shade600,
//                                     ),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   contentPadding:
//                                   const EdgeInsets.symmetric(vertical: 20),
//                                 ),
//                                 style: const TextStyle(fontSize: 16),
//                                 validator: (v) => v == null || v.isEmpty
//                                     ? "Username is required"
//                                     : null,
//                               ),
//                             ),
//
//                             const SizedBox(height: 20),
//
//                             // Password Field
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.deepPurple.withOpacity(0.1),
//                                     blurRadius: 15,
//                                     offset: const Offset(0, 5),
//                                   ),
//                                 ],
//                               ),
//                               child: TextFormField(
//                                 controller: password,
//                                 obscureText: _obscurePassword,
//                                 decoration: InputDecoration(
//                                   labelText: "Password",
//                                   hintText: "Enter your password",
//                                   prefixIcon: Container(
//                                     margin: const EdgeInsets.all(12),
//                                     decoration: BoxDecoration(
//                                       color: Colors.deepPurple.withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Icon(
//                                       Icons.lock,
//                                       color: Colors.deepPurple.shade600,
//                                     ),
//                                   ),
//                                   suffixIcon: IconButton(
//                                     icon: Icon(
//                                       _obscurePassword
//                                           ? Icons.visibility_off
//                                           : Icons.visibility,
//                                       color: Colors.deepPurple.shade600,
//                                     ),
//                                     onPressed: () {
//                                       setState(() {
//                                         _obscurePassword = !_obscurePassword;
//                                       });
//                                     },
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   contentPadding:
//                                   const EdgeInsets.symmetric(vertical: 20),
//                                 ),
//                                 style: const TextStyle(fontSize: 16),
//                                 validator: (v) => v == null || v.isEmpty
//                                     ? "Password is required"
//                                     : null,
//                               ),
//                             ),
//
//                             const SizedBox(height: 10),
//
//                             // Remember me & Forgot password
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Checkbox(
//                                       value: false,
//                                       onChanged: (value) {},
//                                       activeColor: Colors.deepPurple,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                       ),
//                                     ),
//                                     const Text(
//                                       "Remember me",
//                                       style: TextStyle(color: Colors.grey),
//                                     ),
//                                   ],
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     // Forgot password functionality
//                                   },
//                                   child: Text(
//                                     "Forgot Password?",
//                                     style: TextStyle(
//                                       color: Colors.deepPurple.shade600,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 25),
//
//                             // Login Button
//                             SizedBox(
//                               width: double.infinity,
//                               height: 55,
//                               child: ElevatedButton(
//                                 onPressed: _isLoading ? null : doLogin,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.deepPurple,
//                                   foregroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   elevation: 5,
//                                   shadowColor: Colors.deepPurple.withOpacity(0.4),
//                                 ),
//                                 child: _isLoading
//                                     ? const SizedBox(
//                                   height: 20,
//                                   width: 20,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                                   ),
//                                 )
//                                     : const Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(Icons.login, size: 20),
//                                     SizedBox(width: 10),
//                                     Text(
//                                       "SIGN IN",
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         letterSpacing: 1,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//
//                             const SizedBox(height: 30),
//
//                             // Divider with OR
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Divider(
//                                     color: Colors.grey.shade300,
//                                     thickness: 1,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                                   child: Text(
//                                     "OR CONTINUE WITH",
//                                     style: TextStyle(
//                                       color: Colors.grey.shade600,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Divider(
//                                     color: Colors.grey.shade300,
//                                     thickness: 1,
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 30),
//
//                             // Registration Options
//                             Column(
//                               children: [
//                                 // User Registration Button
//                                 Container(
//                                   width: double.infinity,
//                                   height: 55,
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Colors.deepPurple.shade50,
//                                         Colors.deepPurple.shade100,
//                                       ],
//                                     ),
//                                     borderRadius: BorderRadius.circular(15),
//                                     border: Border.all(
//                                       color: Colors.deepPurple.shade200,
//                                       width: 1.5,
//                                     ),
//                                   ),
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (_) => const register(),
//                                         ),
//                                       );
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.transparent,
//                                       foregroundColor: Colors.deepPurple,
//                                       elevation: 0,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(15),
//                                       ),
//                                     ),
//                                     child: const Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.person_add_alt_1),
//                                         SizedBox(width: 10),
//                                         Text(
//                                           "Create User Account",
//                                           style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 15),
//
//                                 // Driver Registration Button
//                                 Container(
//                                   width: double.infinity,
//                                   height: 55,
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Colors.amber.shade50,
//                                         Colors.amber.shade100,
//                                       ],
//                                     ),
//                                     borderRadius: BorderRadius.circular(15),
//                                     border: Border.all(
//                                       color: Colors.amber.shade300,
//                                       width: 1.5,
//                                     ),
//                                   ),
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (_) => const drregister(),
//                                         ),
//                                       );
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.transparent,
//                                       foregroundColor: Colors.amber.shade800,
//                                       elevation: 0,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(15),
//                                       ),
//                                     ),
//                                     child: const Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.directions_car_filled),
//                                         SizedBox(width: 10),
//                                         Text(
//                                           "Become a Driver",
//                                           style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 20),
//
//                             // Footer
//                             Text(
//                               "By continuing, you agree to our Terms & Privacy Policy",
//                               textAlign:TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.grey.shade600,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // Bottom decorative section
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 20),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Rickshaw Ride © 2024",
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.security,
//                             size: 14,
//                             color: Colors.green.shade600,
//                           ),
//                           const SizedBox(width: 5),
//                           Text(
//                             "Safe & Secure Login",
//                             style: TextStyle(
//                               color: Colors.green.shade600,
//                               fontSize: 12,
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
// }
//
//

//
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/locationservice.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:rickshaw_ride/driver/drhome.dart';
// import 'package:rickshaw_ride/driver/drregister.dart';
// import 'package:rickshaw_ride/user/register.dart';
// import 'package:rickshaw_ride/user/urhome.dart';
//
// void main() {
//   runApp(const LoginApp());
// }
//
// class LoginApp extends StatelessWidget {
//   const LoginApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: const Color(0xFF0097A7), // Teal
//         colorScheme: ColorScheme.fromSwatch(
//           primarySwatch: Colors.teal,
//           accentColor: const Color(0xFF0288D1), // Light blue
//         ),
//         fontFamily: 'Roboto', // Changed to Roboto (Flutter default)
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             foregroundColor: Colors.white,
//             backgroundColor: const Color(0xFF0097A7),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//             textStyle: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Color(0xFF0097A7), width: 2),
//           ),
//           filled: true,
//           fillColor: Colors.grey[50],
//           contentPadding: const EdgeInsets.all(18),
//           labelStyle: const TextStyle(
//             color: Colors.grey,
//             fontSize: 14,
//           ),
//         ),
//       ),
//       home: const LoginPage(),
//     );
//   }
// }
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final username = TextEditingController();
//   final password = TextEditingController();
//   bool _isLoading = false;
//   bool _obscurePassword = true;
//
//   Future<void> doLogin() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     final ip = sh.getString("ip");
//
//     if (ip == null || ip.isEmpty) {
//       showMsg("Server IP not set");
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }
//
//     http.Response response;
//
//     try {
//       response = await http.post(
//         Uri.parse("$ip/userlogin"),
//         body: {
//           'username': username.text,
//           'password': password.text,
//         },
//       );
//     } catch (e) {
//       showMsg("Network error");
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }
//
//     final contentType = response.headers['content-type'] ?? "";
//
//     if (!contentType.contains('application/json')) {
//       showMsg("Server error (invalid response)");
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }
//
//     final jsonData = jsonDecode(response.body);
//
//     if (jsonData['status'] == 'ok') {
//       if (jsonData['type'] == 'driver') {
//         sh.setString('did', jsonData['did'].toString());
//         sh.setString('password', password.text);
//         final locationService = LocationService();
//
//         locationService.onNotificationMessage = (message) {
//           if (kIsWeb) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(message),
//                 backgroundColor: const Color(0xFF0097A7),
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//           } else {
//             // NotificationHelper.showNotification('📢 Update', message);
//           }
//         };
//
//         locationService.startLocationUpdates("123");
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const drhome()),
//         );
//       } else if (jsonData['type'] == 'user') {
//         sh.setString('uid', jsonData['uid'].toString());
//         sh.setString('password', password.text);
//
//         final locationService = LocationService();
//
//         locationService.onNotificationMessage = (message) {
//           if (kIsWeb) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(message),
//                 backgroundColor: const Color(0xFF0097A7),
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//           } else {
//             // NotificationHelper.showNotification('📢 Update', message);
//           }
//         };
//
//         locationService.startLocationUpdates("123");
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const urhome()),
//         );
//       }
//     } else {
//       showMsg("Invalid username or password");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void showMsg(String msg) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         elevation: 8,
//         title: const Text(
//           "Message",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF0097A7),
//           ),
//         ),
//         content: Text(
//           msg,
//           style: const TextStyle(fontSize: 16),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text(
//               "OK",
//               style: TextStyle(
//                 color: Color(0xFF0097A7),
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               const Color(0xFFE0F7FA).withOpacity(0.8),
//               const Color(0xFFB3E5FC).withOpacity(0.8),
//               const Color(0xFFE1F5FE).withOpacity(0.8),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Top decorative wave
//                 Container(
//                   height: 150,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         const Color(0xFF0097A7),
//                         const Color(0xFF00BCD4),
//                       ],
//                     ),
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(40),
//                       bottomRight: Radius.circular(40),
//                     ),
//                   ),
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const SizedBox(height: 20),
//                         Icon(
//                           Icons.directions_car_filled,
//                           size: 50,
//                           color: Colors.white.withOpacity(0.9),
//                         ),
//                         const SizedBox(height: 10),
//                         const Text(
//                           "Rickshaw Ride",
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             letterSpacing: 1.2,
//                             fontFamily: 'Roboto',
//                           ),
//                         ),
//                         const Text(
//                           "Your Journey, Our Priority",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.white70,
//                             fontFamily: 'Roboto',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Login Form Card
//                 Padding(
//                   padding: const EdgeInsets.all(25.0),
//                   child: Card(
//                     elevation: 10,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     shadowColor: const Color(0xFF0097A7).withOpacity(0.3),
//                     child: Padding(
//                       padding: const EdgeInsets.all(30.0),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             const Text(
//                               "Welcome Back",
//                               style: TextStyle(
//                                 fontSize: 26,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF0097A7),
//                                 fontFamily: 'Roboto',
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             const Text(
//                               "Sign in to continue your journey",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                                 fontFamily: 'Roboto',
//                               ),
//                             ),
//                             const SizedBox(height: 30),
//
//                             // Username Field
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: const Color(0xFF0097A7).withOpacity(0.1),
//                                     blurRadius: 15,
//                                     offset: const Offset(0, 5),
//                                   ),
//                                 ],
//                               ),
//                               child: TextFormField(
//                                 controller: username,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontFamily: 'Roboto',
//                                 ),
//                                 decoration: InputDecoration(
//                                   labelText: "Username",
//                                   hintText: "Enter your username",
//                                   hintStyle: const TextStyle(
//                                     fontFamily: 'Roboto',
//                                   ),
//                                   labelStyle: const TextStyle(
//                                     fontFamily: 'Roboto',
//                                   ),
//                                   prefixIcon: Container(
//                                     margin: const EdgeInsets.all(12),
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFF0097A7).withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Icon(
//                                       Icons.person,
//                                       color: const Color(0xFF0097A7),
//                                     ),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   contentPadding:
//                                   const EdgeInsets.symmetric(vertical: 20),
//                                 ),
//                                 validator: (v) => v == null || v.isEmpty
//                                     ? "Username is required"
//                                     : null,
//                               ),
//                             ),
//
//                             const SizedBox(height: 20),
//
//                             // Password Field
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: const Color(0xFF0097A7).withOpacity(0.1),
//                                     blurRadius: 15,
//                                     offset: const Offset(0, 5),
//                                   ),
//                                 ],
//                               ),
//                               child: TextFormField(
//                                 controller: password,
//                                 obscureText: _obscurePassword,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontFamily: 'Roboto',
//                                 ),
//                                 decoration: InputDecoration(
//                                   labelText: "Password",
//                                   hintText: "Enter your password",
//                                   hintStyle: const TextStyle(
//                                     fontFamily: 'Roboto',
//                                   ),
//                                   labelStyle: const TextStyle(
//                                     fontFamily: 'Roboto',
//                                   ),
//                                   prefixIcon: Container(
//                                     margin: const EdgeInsets.all(12),
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFF0097A7).withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Icon(
//                                       Icons.lock,
//                                       color: const Color(0xFF0097A7),
//                                     ),
//                                   ),
//                                   suffixIcon: IconButton(
//                                     icon: Icon(
//                                       _obscurePassword
//                                           ? Icons.visibility_off
//                                           : Icons.visibility,
//                                       color: const Color(0xFF0097A7),
//                                     ),
//                                     onPressed: () {
//                                       setState(() {
//                                         _obscurePassword = !_obscurePassword;
//                                       });
//                                     },
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   contentPadding:
//                                   const EdgeInsets.symmetric(vertical: 20),
//                                 ),
//                                 validator: (v) => v == null || v.isEmpty
//                                     ? "Password is required"
//                                     : null,
//                               ),
//                             ),
//
//                             const SizedBox(height: 10),
//
//                             // Remember me & Forgot password
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Checkbox(
//                                       value: false,
//                                       onChanged: (value) {},
//                                       activeColor: const Color(0xFF0097A7),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                       ),
//                                     ),
//                                     const Text(
//                                       "Remember me",
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontFamily: 'Roboto',
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     // Forgot password functionality
//                                   },
//                                   child: Text(
//                                     "Forgot Password?",
//                                     style: TextStyle(
//                                       color: const Color(0xFF0097A7),
//                                       fontWeight: FontWeight.w600,
//                                       fontFamily: 'Roboto',
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 25),
//
//                             // Login Button
//                             SizedBox(
//                               width: double.infinity,
//                               height: 55,
//                               child: ElevatedButton(
//                                 onPressed: _isLoading ? null : doLogin,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: const Color(0xFF0097A7),
//                                   foregroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   elevation: 5,
//                                   shadowColor: const Color(0xFF0097A7).withOpacity(0.4),
//                                 ),
//                                 child: _isLoading
//                                     ? const SizedBox(
//                                   height: 20,
//                                   width: 20,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                                   ),
//                                 )
//                                     : const Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(Icons.login, size: 20),
//                                     SizedBox(width: 10),
//                                     Text(
//                                       "SIGN IN",
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         letterSpacing: 1,
//                                         fontFamily: 'Roboto',
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//
//                             const SizedBox(height: 30),
//
//                             // Divider with OR
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Divider(
//                                     color: Colors.grey.shade300,
//                                     thickness: 1,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                                   child: Text(
//                                     "OR CONTINUE WITH",
//                                     style: TextStyle(
//                                       color: Colors.grey.shade600,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       fontFamily: 'Roboto',
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Divider(
//                                     color: Colors.grey.shade300,
//                                     thickness: 1,
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 30),
//
//                             // Registration Options
//                             Column(
//                               children: [
//                                 // User Registration Button
//                                 Container(
//                                   width: double.infinity,
//                                   height: 55,
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         const Color(0xFFE0F7FA),
//                                         const Color(0xFFB2EBF2),
//                                       ],
//                                     ),
//                                     borderRadius: BorderRadius.circular(15),
//                                     border: Border.all(
//                                       color: const Color(0xFF0097A7).withOpacity(0.3),
//                                       width: 1.5,
//                                     ),
//                                   ),
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (_) => const register(),
//                                         ),
//                                       );
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.transparent,
//                                       foregroundColor: const Color(0xFF0097A7),
//                                       elevation: 0,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(15),
//                                       ),
//                                     ),
//                                     child: const Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.person_add_alt_1),
//                                         SizedBox(width: 10),
//                                         Text(
//                                           "Create User Account",
//                                           style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w600,
//                                             fontFamily: 'Roboto',
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 15),
//
//                                 // Driver Registration Button
//                                 Container(
//                                   width: double.infinity,
//                                   height: 55,
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         const Color(0xFFE1F5FE),
//                                         const Color(0xFFB3E5FC),
//                                       ],
//                                     ),
//                                     borderRadius: BorderRadius.circular(15),
//                                     border: Border.all(
//                                       color: const Color(0xFF0288D1).withOpacity(0.3),
//                                       width: 1.5,
//                                     ),
//                                   ),
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (_) => const drregister(),
//                                         ),
//                                       );
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.transparent,
//                                       foregroundColor: const Color(0xFF0288D1),
//                                       elevation: 0,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(15),
//                                       ),
//                                     ),
//                                     child: const Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.directions_car_filled),
//                                         SizedBox(width: 10),
//                                         Text(
//                                           "Become a Driver",
//                                           style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w600,
//                                             fontFamily: 'Roboto',
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 20),
//
//                             // Footer
//                             Text(
//                               "By continuing, you agree to our Terms & Privacy Policy",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.grey.shade600,
//                                 fontSize: 12,
//                                 fontFamily: 'Roboto',
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // Bottom decorative section
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 20),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Rickshaw Ride © 2024",
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Roboto',
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.security,
//                             size: 14,
//                             color: Colors.green.shade600,
//                           ),
//                           const SizedBox(width: 5),
//                           Text(
//                             "Safe & Secure Login",
//                             style: TextStyle(
//                               color: Colors.green.shade600,
//                               fontSize: 12,
//                               fontFamily: 'Roboto',
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
// }














// -----------------------------------------------------------------------------------
//
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/locationservice.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:rickshaw_ride/driver/drhome.dart';
// import 'package:rickshaw_ride/driver/drregister.dart';
// import 'package:rickshaw_ride/user/register.dart';
// import 'package:rickshaw_ride/user/urhome.dart';
//
// void main() {
//   runApp(const LoginApp());
// }
//
// class LoginApp extends StatelessWidget {
//   const LoginApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: const Color(0xFFF57C00), // Dark yellow
//         colorScheme: ColorScheme.fromSwatch(
//           primarySwatch: Colors.orange,
//           accentColor: const Color(0xFFFFB74D), // Lighter yellow
//           brightness: Brightness.dark, // Dark theme
//         ),
//         fontFamily: 'Roboto',
//         scaffoldBackgroundColor: Colors.black,
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             foregroundColor: Colors.black,
//             backgroundColor: const Color(0xFFF57C00),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//             textStyle: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Color(0xFFF57C00), width: 2),
//           ),
//           filled: true,
//           fillColor: Colors.grey[900],
//           contentPadding: const EdgeInsets.all(18),
//           labelStyle: const TextStyle(
//             color: Colors.grey,
//             fontSize: 14,
//           ),
//         ),
//       ),
//       home: const LoginPage(),
//     );
//   }
// }
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final username = TextEditingController();
//   final password = TextEditingController();
//   bool _isLoading = false;
//   bool _obscurePassword = true;
//
//   Future<void> doLogin() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     final ip = sh.getString("ip");
//
//     if (ip == null || ip.isEmpty) {
//       showMsg("Server IP not set");
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }
//
//     http.Response response;
//
//     try {
//       response = await http.post(
//         Uri.parse("$ip/userlogin"),
//         body: {
//           'usernam': username.text,
//           'password': password.text,
//         },
//       );
//     } catch (e) {
//       showMsg("Network error");
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }
//
//     final contentType = response.headers['content-type'] ?? "";
//
//     if (!contentType.contains('application/json')) {
//       showMsg("Server error (invalid response)");
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }
//
//     final jsonData = jsonDecode(response.body);
//
//     if (jsonData['status'] == 'ok') {
//       if (jsonData['type'] == 'driver') {
//         sh.setString('did', jsonData['did'].toString());
//         sh.setString('password', password.text);
//         final locationService = LocationService();
//
//         locationService.onNotificationMessage = (message) {
//           if (kIsWeb) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(message),
//                 backgroundColor: const Color(0xFFF57C00),
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//           } else {
//             // NotificationHelper.showNotification('📢 Update', message);
//           }
//         };
//
//         locationService.startLocationUpdates("123");
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const drhome()),
//         );
//       } else if (jsonData['type'] == 'user') {
//         sh.setString('uid', jsonData['uid'].toString());
//         sh.setString('password', password.text);
//
//         final locationService = LocationService();
//
//         locationService.onNotificationMessage = (message) {
//           if (kIsWeb) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(message),
//                 backgroundColor: const Color(0xFFF57C00),
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//           } else {
//             // NotificationHelper.showNotification('📢 Update', message);
//           }
//         };
//
//         locationService.startLocationUpdates("123");
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const urhome()),
//         );
//       }
//     } else {
//       showMsg("Invalid username or password");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void showMsg(String msg) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         backgroundColor: Colors.grey[900],
//         elevation: 8,
//         title: Text(
//           "Message",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: const Color(0xFFF57C00),
//           ),
//         ),
//         content: Text(
//           msg,
//           style: const TextStyle(color: Colors.white),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text(
//               "OK",
//               style: TextStyle(
//                 color: const Color(0xFFF57C00),
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Top decorative wave
//               Container(
//                 height: 200,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       const Color(0xFF212121),
//                       const Color(0xFF424242),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(40),
//                     bottomRight: Radius.circular(40),
//                   ),
//                 ),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const SizedBox(height: 20),
//                       Icon(
//                         Icons.directions_car_filled,
//                         size: 50,
//                         color: const Color(0xFFF57C00).withOpacity(0.9),
//                       ),
//                       const SizedBox(height: 10),
//                       const Text(
//                         "Rickshaw Ride",
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           letterSpacing: 1.2,
//                           fontFamily: 'Roboto',
//                         ),
//                       ),
//                       Text(
//                         "Your Journey, Our Priority",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey[400],
//                           fontFamily: 'Roboto',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // Login Form Card
//               Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: Card(
//                   elevation: 10,
//                   color: Colors.grey[900],
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   shadowColor: const Color(0xFFF57C00).withOpacity(0.2),
//                   child: Padding(
//                     padding: const EdgeInsets.all(30.0),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           const Text(
//                             "Welcome Back",
//                             style: TextStyle(
//                               fontSize: 26,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               fontFamily: 'Roboto',
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             "Sign in to continue your journey",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[400],
//                               fontFamily: 'Roboto',
//                             ),
//                           ),
//                           const SizedBox(height: 30),
//
//                           // Username Field
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: const Color(0xFFF57C00).withOpacity(0.2),
//                                   blurRadius: 15,
//                                   offset: const Offset(0, 5),
//                                 ),
//                               ],
//                             ),
//                             child: TextFormField(
//                               controller: username,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontFamily: 'Roboto',
//                                 color: Colors.white,
//                               ),
//                               decoration: InputDecoration(
//                                 labelText: "Username",
//                                 hintText: "Enter your username",
//                                 hintStyle: TextStyle(
//                                   fontFamily: 'Roboto',
//                                   color: Colors.grey[500],
//                                 ),
//                                 labelStyle: TextStyle(
//                                   fontFamily: 'Roboto',
//                                   color: Colors.grey[400],
//                                 ),
//                                 prefixIcon: Container(
//                                   margin: const EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     color: const Color(0xFFF57C00).withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Icon(
//                                     Icons.person,
//                                     color: const Color(0xFFF57C00),
//                                   ),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 filled: true,
//                                 fillColor: Colors.grey[800],
//                                 contentPadding:
//                                 const EdgeInsets.symmetric(vertical: 20),
//                               ),
//                               validator: (v) => v == null || v.isEmpty
//                                   ? "Username is required"
//                                   : null,
//                             ),
//                           ),
//
//                           const SizedBox(height: 20),
//
//                           // Password Field
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: const Color(0xFFF57C00).withOpacity(0.2),
//                                   blurRadius: 15,
//                                   offset: const Offset(0, 5),
//                                 ),
//                               ],
//                             ),
//                             child: TextFormField(
//                               controller: password,
//                               obscureText: _obscurePassword,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontFamily: 'Roboto',
//                                 color: Colors.white,
//                               ),
//                               decoration: InputDecoration(
//                                 labelText: "Password",
//                                 hintText: "Enter your password",
//                                 hintStyle: TextStyle(
//                                   fontFamily: 'Roboto',
//                                   color: Colors.grey[500],
//                                 ),
//                                 labelStyle: TextStyle(
//                                   fontFamily: 'Roboto',
//                                   color: Colors.grey[400],
//                                 ),
//                                 prefixIcon: Container(
//                                   margin: const EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     color: const Color(0xFFF57C00).withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Icon(
//                                     Icons.lock,
//                                     color: const Color(0xFFF57C00),
//                                   ),
//                                 ),
//                                 suffixIcon: IconButton(
//                                   icon: Icon(
//                                     _obscurePassword
//                                         ? Icons.visibility_off
//                                         : Icons.visibility,
//                                     color: const Color(0xFFF57C00),
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       _obscurePassword = !_obscurePassword;
//                                     });
//                                   },
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 filled: true,
//                                 fillColor: Colors.grey[800],
//                                 contentPadding:
//                                 const EdgeInsets.symmetric(vertical: 20),
//                               ),
//                               validator: (v) => v == null || v.isEmpty
//                                   ? "Password is required"
//                                   : null,
//                             ),
//                           ),
//
//                           const SizedBox(height: 10),
//
//                           // Remember me & Forgot password
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Checkbox(
//                                     value: false,
//                                     onChanged: (value) {},
//                                     activeColor: const Color(0xFFF57C00),
//                                     checkColor: Colors.black,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                   ),
//                                   Text(
//                                     "Remember me",
//                                     style: TextStyle(
//                                       color: Colors.grey[400],
//                                       fontFamily: 'Roboto',
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   // Forgot password functionality
//                                 },
//                                 child: Text(
//                                   "Forgot Password?",
//                                   style: TextStyle(
//                                     color: const Color(0xFFF57C00),
//                                     fontWeight: FontWeight.w600,
//                                     fontFamily: 'Roboto',
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                           const SizedBox(height: 25),
//
//                           // Login Button
//                           SizedBox(
//                             width: double.infinity,
//                             height: 55,
//                             child: ElevatedButton(
//                               onPressed: _isLoading ? null : doLogin,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFFF57C00),
//                                 foregroundColor: Colors.black,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 elevation: 5,
//                                 shadowColor: const Color(0xFFF57C00).withOpacity(0.4),
//                               ),
//                               child: _isLoading
//                                   ? const SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//                                 ),
//                               )
//                                   : const Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(Icons.login, size: 20, color: Colors.black),
//                                   SizedBox(width: 10),
//                                   Text(
//                                     "SIGN IN",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       letterSpacing: 1,
//                                       fontFamily: 'Roboto',
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//
//                           const SizedBox(height: 30),
//
//                           // Divider with OR
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Divider(
//                                   color: Colors.grey[700],
//                                   thickness: 1,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                                 child: Text(
//                                   "OR CONTINUE WITH",
//                                   style: TextStyle(
//                                     color: Colors.grey[500],
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     fontFamily: 'Roboto',
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Divider(
//                                   color: Colors.grey[700],
//                                   thickness: 1,
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                           const SizedBox(height: 30),
//
//                           // Registration Options
//                           Column(
//                             children: [
//                               // User Registration Button
//                               Container(
//                                 width: double.infinity,
//                                 height: 55,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       const Color(0xFF424242),
//                                       const Color(0xFF212121),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(15),
//                                   border: Border.all(
//                                     color: const Color(0xFFF57C00).withOpacity(0.3),
//                                     width: 1.5,
//                                   ),
//                                 ),
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (_) => const register(),
//                                       ),
//                                     );
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.transparent,
//                                     foregroundColor: const Color(0xFFF57C00),
//                                     elevation: 0,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                     ),
//                                   ),
//                                   child: const Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(Icons.person_add_alt_1),
//                                       SizedBox(width: 10),
//                                       Text(
//                                         "Create User Account",
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w600,
//                                           fontFamily: 'Roboto',
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//
//                               const SizedBox(height: 15),
//
//                               // Driver Registration Button
//                               Container(
//                                 width: double.infinity,
//                                 height: 55,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       const Color(0xFF424242),
//                                       const Color(0xFF212121),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(15),
//                                   border: Border.all(
//                                     color: const Color(0xFFFFB74D).withOpacity(0.3),
//                                     width: 1.5,
//                                   ),
//                                 ),
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (_) => const drregister(),
//                                       ),
//                                     );
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.transparent,
//                                     foregroundColor: const Color(0xFFFFB74D),
//                                     elevation: 0,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                     ),
//                                   ),
//                                   child: const Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(Icons.directions_car_filled),
//                                       SizedBox(width: 10),
//                                       Text(
//                                         "Become a Driver",
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w600,
//                                           fontFamily: 'Roboto',
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                           const SizedBox(height: 20),
//
//                           // Footer
//                           Text(
//                             "By continuing, you agree to our Terms & Privacy Policy",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.grey[500],
//                               fontSize: 12,
//                               fontFamily: 'Roboto',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               // Bottom decorative section
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Rickshaw Ride © 2024",
//                       style: TextStyle(
//                         color: Colors.grey[500],
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: 'Roboto',
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.security,
//                           size: 14,
//                           color: const Color(0xFFF57C00),
//                         ),
//                         const SizedBox(width: 5),
//                         Text(
//                           "Safe & Secure Login",
//                           style: TextStyle(
//                             color: const Color(0xFFF57C00),
//                             fontSize: 12,
//                             fontFamily: 'Roboto',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// =========================================================================







import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickshaw_ride/locationservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rickshaw_ride/driver/drhome.dart';
import 'package:rickshaw_ride/driver/drregister.dart';
import 'package:rickshaw_ride/user/register.dart';
import 'package:rickshaw_ride/user/urhome.dart';

import 'forgotemail.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFF57C00), // Dark yellow
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.orange,
          accentColor: const Color(0xFFFFB74D), // Lighter yellow
          brightness: Brightness.dark, // Dark theme
        ),
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: const Color(0xFFF57C00),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFF57C00), width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[900],
          contentPadding: const EdgeInsets.all(18),
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  // Animation controllers
  late AnimationController _floatingColorController;
  late Animation<Color?> _colorAnimation;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // For floating colors effect
  final List<Color> _floatingColors = [
    const Color(0xFFF57C00).withValues(alpha: 0.3),
    const Color(0xFFFFB74D).withValues(alpha: 0.3),
    Colors.orange.shade300.withValues(alpha: 0.2),
    Colors.amber.shade200.withValues(alpha: 0.2),
    Colors.deepOrange.shade300.withValues(alpha: 0.2),
  ];

  late List<AnimationController> _bubbleControllers;
  late List<Animation<Offset>> _bubbleAnimations;
  final int _numberOfBubbles = 8;

  @override
  void initState() {
    super.initState();

    // Floating color animation for text
    _floatingColorController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: const Color(0xFFF57C00),
      end: const Color(0xFFFFB74D),
    ).animate(_floatingColorController);

    // Pulse animation for buttons
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Slide animation for form elements
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    // Fade animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    // Bubble animations for floating effect
    _bubbleControllers = List.generate(_numberOfBubbles, (index) {
      return AnimationController(
        duration: Duration(seconds: 3 + index),
        vsync: this,
      )..repeat(reverse: true);
    });

    _bubbleAnimations = List.generate(_numberOfBubbles, (index) {
      return Tween<Offset>(
        begin: Offset(
          (index % 3) * 0.1 - 0.1,
          (index % 2) * 0.1 - 0.05,
        ),
        end: Offset(
          (index % 3) * 0.1 - 0.1,
          (index % 2) * 0.1 + 0.05,
        ),
      ).animate(CurvedAnimation(
        parent: _bubbleControllers[index],
        curve: Curves.easeInOut,
      ));
    });

    // Start animations
    _slideController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _floatingColorController.dispose();
    _pulseController.dispose();
    _slideController.dispose();
    _fadeController.dispose();
    for (var controller in _bubbleControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> doLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    SharedPreferences sh = await SharedPreferences.getInstance();
    final ip = sh.getString("ip");

    if (ip == null || ip.isEmpty) {
      showMsg("Server IP not set");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    http.Response response;

    try {
      response = await http.post(
        Uri.parse("$ip/userlogin"),
        body: {
          'usernam': username.text,
          'password': password.text,
        },
      );
    } catch (e) {
      showMsg("Network error");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final contentType = response.headers['content-type'] ?? "";

    if (!contentType.contains('application/json')) {
      showMsg("Server error (invalid response)");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final jsonData = jsonDecode(response.body);


    if (jsonData['status'] == 'ok') {
      final locationService = LocationService();

      // Handle notification messages
      locationService.onNotificationMessage = (message) {
        if (kIsWeb) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: const Color(0xFFF57C00),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          // NotificationHelper.showNotification('📢 Update', message);
        }
      };

      locationService.startLocationUpdates("123");

      if (jsonData['type'] == 'driver') {
        String driverStatus = jsonData['status'] ??"";

        if (driverStatus == 'ok') {
          sh.setString('did', jsonData['did'].toString());
          sh.setString('password', password.text);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const drhome()),
          );

        } else if (driverStatus == 'invalid') {
          showMsg("Driver approval pending");

        } else if (driverStatus == 'reject') {
          showMsg("Driver rejected by admin");

        }  else {
          showMsg("Invalid driver status");
        }

      } else if (jsonData['type'] == 'user') {
    String userStatus = jsonData['status'] ?? "";

    if (userStatus == 'ok' || userStatus == 'approved') {
          sh.setString('uid', jsonData['uid'].toString());
          sh.setString('password', password.text);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const urhome()),
          );

        } else if (userStatus == 'blocked') {
          showMsg("User blocked by admin");

        } else {
          showMsg("Invalid user status");
        }
      }

    } else {
      showMsg(jsonData['message'] ?? "Invalid username or password");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void showMsg(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.grey[900],
        elevation: 8,
        title: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return Text(
              "Message",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _colorAnimation.value,
              ),
            );
          },
        ),
        content: Text(
          msg,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage())),
            child: Text(
              "OK",
              style: TextStyle(
                color: const Color(0xFFF57C00),
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Animated background bubbles
          ...List.generate(_numberOfBubbles, (index) {
            return AnimatedBuilder(
              animation: _bubbleAnimations[index],
              builder: (context, child) {
                return Positioned(
                  left: MediaQuery.of(context).size.width *
                      (0.1 + (index * 0.1) % 0.8),
                  top: MediaQuery.of(context).size.height *
                      (0.1 + (index * 0.15) % 0.8),
                  child: Transform.translate(
                    offset: Offset(
                      _bubbleAnimations[index].value.dx * 50,
                      _bubbleAnimations[index].value.dy * 50,
                    ),
                    child: Container(
                      width: 30 + (index * 10),
                      height: 30 + (index * 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _floatingColors[index % _floatingColors.length],
                        boxShadow: [
                          BoxShadow(
                            color: _floatingColors[index % _floatingColors.length],
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),

          // Gradient overlay for better readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.3),
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    // Top decorative wave with animated icon
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF212121),
                            const Color(0xFF424242),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _pulseAnimation.value,
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFF57C00).withValues(alpha: 0.5),
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.directions_car_filled,
                                      size: 50,
                                      color: const Color(0xFFF57C00).withValues(alpha: 0.9),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            ShaderMask(
                              shaderCallback: (bounds) {
                                return LinearGradient(
                                  colors: [
                                    const Color(0xFFF57C00),
                                    const Color(0xFFFFB74D),
                                    const Color(0xFFF57C00),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds);
                              },
                              child: const Text(
                                "Voie",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _colorAnimation,
                              builder: (context, child) {
                                return Text(
                                  "Your Journey, Our Priority",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: _colorAnimation.value?.withValues(alpha: 0.8),
                                    fontFamily: 'Roboto',
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Login Form Card with slide animation
                    SlideTransition(
                      position: _slideAnimation,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Card(
                          elevation: 10,
                          color: Colors.grey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          shadowColor: const Color(0xFFF57C00).withValues(alpha: 0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const Text(
                                    "Welcome Back",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  AnimatedBuilder(
                                    animation: _colorAnimation,
                                    builder: (context, child) {
                                      return Text(
                                        "Sign in to continue your journey",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _colorAnimation.value?.withValues(alpha: 0.8),
                                          fontFamily: 'Roboto',
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 30),

                                  // Username Field with hover effect
                                  TweenAnimationBuilder(
                                    duration: const Duration(milliseconds: 300),
                                    tween: Tween<double>(begin: 0, end: 1),
                                    builder: (context, double value, child) {
                                      return Transform.scale(
                                        scale: value,
                                        child: child,
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFF57C00).withValues(alpha: 0.2),
                                            blurRadius: 15,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        controller: username,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Roboto',
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: "Username",
                                          hintText: "Enter your username",
                                          hintStyle: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Colors.grey[500],
                                          ),
                                          labelStyle: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Colors.grey[400],
                                          ),
                                          prefixIcon: Container(
                                            margin: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF57C00).withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Icon(
                                              Icons.person,
                                              color: const Color(0xFFF57C00),
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[800],
                                          contentPadding:
                                          const EdgeInsets.symmetric(vertical: 20),
                                        ),
                                        validator: (v) => v == null || v.isEmpty
                                            ? "Username is required"
                                            : null,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Password Field with hover effect
                                  TweenAnimationBuilder(
                                    duration: const Duration(milliseconds: 500),
                                    tween: Tween<double>(begin: 0, end: 1),
                                    builder: (context, double value, child) {
                                      return Transform.scale(
                                        scale: value,
                                        child: child,
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFF57C00).withValues(alpha: 0.2),
                                            blurRadius: 15,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        controller: password,
                                        obscureText: _obscurePassword,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Roboto',
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: "Password",
                                          hintText: "Enter your password",
                                          hintStyle: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Colors.grey[500],
                                          ),
                                          labelStyle: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Colors.grey[400],
                                          ),
                                          prefixIcon: Container(
                                            margin: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF57C00).withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Icon(
                                              Icons.lock,
                                              color: const Color(0xFFF57C00),
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: AnimatedBuilder(
                                              animation: _colorAnimation,
                                              builder: (context, child) {
                                                return Icon(
                                                  _obscurePassword
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: _colorAnimation.value,
                                                );
                                              },
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscurePassword = !_obscurePassword;
                                              });
                                            },
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[800],
                                          contentPadding:
                                          const EdgeInsets.symmetric(vertical: 20),
                                        ),
                                        validator: (v) => v == null || v.isEmpty
                                            ? "Password is required"
                                            : null,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Remember me & Forgot password
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: false,
                                            onChanged: (value) {},
                                            activeColor: const Color(0xFFF57C00),
                                            checkColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          ),
                                          Text(
                                            "Remember me",
                                            style: TextStyle(
                                              color: Colors.grey[400],
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=>forgotemail()))   ;                                     },
                                        child: AnimatedBuilder(
                                          animation: _colorAnimation,
                                          builder: (context, child) {
                                            return Text(
                                              "Forgot Password?",
                                              style: TextStyle(
                                                color: _colorAnimation.value,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Roboto',
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 25),

                                  // Login Button with pulse animation
                                  AnimatedBuilder(
                                    animation: _pulseAnimation,
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scale: _isLoading ? 1.0 : _pulseAnimation.value,
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 55,
                                          child: ElevatedButton(
                                            onPressed: _isLoading ? null : doLogin,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(0xFFF57C00),
                                              foregroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              elevation: 5,
                                              shadowColor: const Color(0xFFF57C00).withValues(alpha: 0.4),
                                            ),
                                            child: _isLoading
                                                ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                              ),
                                            )
                                                : const Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.login, size: 20, color: Colors.black),
                                                SizedBox(width: 10),
                                                Text(
                                                  "SIGN IN",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                    fontFamily: 'Roboto',
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 30),

                                  // Divider with OR (animated)
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: Colors.grey[700],
                                          thickness: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: AnimatedBuilder(
                                          animation: _colorAnimation,
                                          builder: (context, child) {
                                            return Text(
                                              "OR CONTINUE WITH",
                                              style: TextStyle(
                                                color: _colorAnimation.value,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Roboto',
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Colors.grey[700],
                                          thickness: 1,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 30),

                                  // Registration Options with hover effects
                                  Column(
                                    children: [
                                      // User Registration Button
                                      TweenAnimationBuilder(
                                        duration: const Duration(milliseconds: 700),
                                        tween: Tween<double>(begin: 0, end: 1),
                                        builder: (context, double value, child) {
                                          return Transform.translate(
                                            offset: Offset(0, 50 * (1 - value)),
                                            child: Opacity(
                                              opacity: value,
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: StatefulBuilder(
                                            builder: (context, setState) {
                                              return Container(
                                                width: double.infinity,
                                                height: 55,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      const Color(0xFF424242),
                                                      const Color(0xFF212121),
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
                                                      spreadRadius: 2,
                                                    ),
                                                  ],
                                                ),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    final locationService = LocationService();


                                                    locationService.onNotificationMessage = (message) {
                                                      // 🎯 context is available here!
                                                      if (kIsWeb) {
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(content: Text(message)),
                                                        );
                                                      } else {
                                                        // NotificationHelper.showNotification('📢 Update', message);
                                                      }
                                                    };

                                                    locationService.startLocationUpdates("uid");
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) => const register(),
                                                      ),
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.transparent,
                                                    foregroundColor: const Color(0xFFF57C00),
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      AnimatedBuilder(
                                                        animation: _colorAnimation,
                                                        builder: (context, child) {
                                                          return Icon(
                                                            Icons.person_add_alt_1,
                                                            color: _colorAnimation.value,
                                                          );
                                                        },
                                                      ),
                                                      const SizedBox(width: 10),
                                                      const Text(
                                                        "Create User Account",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: 'Roboto',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 15),

                                      // Driver Registration Button
                                      TweenAnimationBuilder(
                                        duration: const Duration(milliseconds: 900),
                                        tween: Tween<double>(begin: 0, end: 1),
                                        builder: (context, double value, child) {
                                          return Transform.translate(
                                            offset: Offset(0, 50 * (1 - value)),
                                            child: Opacity(
                                              opacity: value,
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: StatefulBuilder(
                                            builder: (context, setState) {
                                              return Container(
                                                width: double.infinity,
                                                height: 55,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      const Color(0xFF424242),
                                                      const Color(0xFF212121),
                                                    ],
                                                  ),
                                                  borderRadius: BorderRadius.circular(15),
                                                  border: Border.all(
                                                    color: const Color(0xFFFFB74D).withValues(alpha: 0.3),
                                                    width: 1.5,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(0xFFFFB74D).withValues(alpha: 0.1),
                                                      blurRadius: 10,
                                                      spreadRadius: 2,
                                                    ),
                                                  ],
                                                ),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    final locationService = LocationService();


                                                    locationService.onNotificationMessage = (message) {
                                                      // 🎯 context is available here!
                                                      if (kIsWeb) {
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(content: Text(message)),
                                                        );
                                                      } else {
                                                        // NotificationHelper.showNotification('📢 Update', message);
                                                      }
                                                    };

                                                    locationService.startLocationUpdates("did");
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) => const drregister(),
                                                      ),
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.transparent,
                                                    foregroundColor: const Color(0xFFFFB74D),
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      AnimatedBuilder(
                                                        animation: _colorAnimation,
                                                        builder: (context, child) {
                                                          return Icon(
                                                            Icons.directions_car_filled,
                                                            color: _colorAnimation.value,
                                                          );
                                                        },
                                                      ),
                                                      const SizedBox(width: 10),
                                                      const Text(
                                                        "Become a Driver",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: 'Roboto',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 20),

                                  // Footer with animation
                                  AnimatedBuilder(
                                    animation: _colorAnimation,
                                    builder: (context, child) {
                                      return Text(
                                        "By continuing, you agree to our Terms & Privacy Policy",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: _colorAnimation.value?.withValues(alpha: 0.7),
                                          fontSize: 12,
                                          fontFamily: 'Roboto',
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Bottom decorative section with animation
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Text(
                            "Voie © 2024",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedBuilder(
                                animation: _pulseController,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _pulseAnimation.value,
                                    child: Icon(
                                      Icons.security,
                                      size: 14,
                                      color: const Color(0xFFF57C00),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 5),
                              AnimatedBuilder(
                                animation: _colorAnimation,
                                builder: (context, child) {
                                  return Text(
                                    "Safe & Secure Login",
                                    style: TextStyle(
                                      color: _colorAnimation.value,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                    ),
                                  );
                                },
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
        ],
      ),
    );
  }
}
