// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/driver/driver_edit_profile.dart';
// import 'package:rickshaw_ride/user/edit_profile.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// void main(){
//   runApp(driver_view_profile());
// }
// class driver_view_profile extends StatelessWidget {
//   const driver_view_profile({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: driver_view_profilesub(),);
//   }
// }
//
// class driver_view_profilesub extends StatefulWidget {
//   const driver_view_profilesub({Key? key}) : super(key: key);
//
//   @override
//   State<driver_view_profilesub> createState() => driver_view_profilesubstate();
// }
//
// class driver_view_profilesubstate extends State<driver_view_profilesub> {
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String b = prefs.getString("lid").toString();
//     String foodimage="";
//     var data =
//     await http.post(Uri.parse(prefs.getString("ip").toString()+"/driver_view_profile"),
//         body: {"did":prefs.getString('did').toString()}
//     );
//
//     var jsonData = json.decode(data.body);
// //    print(jsonData);
//     List<Joke> jokes = [];
//     for (var joke in jsonData["message"]) {
//       print(joke);
//       Joke newJoke = Joke(
//         joke["id"].toString(),
//         joke["name"].toString(),
//         joke["email"].toString(),
//         joke["phone"].toString(),
//         prefs.getString('ip').toString()+joke["photo"].toString(),
//         prefs.getString('ip').toString()+joke["proof"].toString(),
//
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Container(
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
//
//                           _buildRow("name:", i.name.toString()),
//                           _buildRow("email:", i.email.toString()),
//                           _buildRow("phone:", i.phone.toString()),
//                           Image.network(i.photo.toString(),height: 200,width: 200,),
//                           Image.network(i.proof.toString(),height: 200,width: 200,),
//                           Row(children: [
//                             ElevatedButton(onPressed: (){
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>driver_edit_profilesub(
//                                 id:i.id.toString(),
//                                 name:i.name.toString(),
//                                 email:i.email.toString(),
//                                 phone:i.phone.toString(),
//                                 proof:i.proof.toString(),
//                                 photo:i.photo.toString(),
//
//                               )));
//                             }, child: Text('edit'))
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
//   final String name;
//   final String email;
//   final String phone;
//   final String photo;
//   final String proof;
//
//
//
//
//   Joke(this.id,this.name, this.email,this.phone, this.photo, this.proof);
// //  print("hiiiii");
// }
//
//
//

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickshaw_ride/driver/driver_edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Add import for drhome
import 'package:rickshaw_ride/driver/drhome.dart';

void main() {
  runApp(driver_view_profile());
}

class driver_view_profile extends StatelessWidget {
  const driver_view_profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFF57C00), // Modern orange color
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFF57C00),
          secondary: Color(0xFFFF9800),
          surface: Color(0xFF121212),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Color(0xFFF57C00),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFFF57C00)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF57C00),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            elevation: 3,
            shadowColor: Color(0xFFF57C00).withValues(alpha: 0.5),
          ),
        ),
      ),
      home: const driver_view_profilesub(),
    );
  }
}

class driver_view_profilesub extends StatefulWidget {
  const driver_view_profilesub({super.key});

  @override
  State<driver_view_profilesub> createState() => driver_view_profilesubstate();
}

class driver_view_profilesubstate extends State<driver_view_profilesub> {
  Future<List<DriverProfile>> _getDriverProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await http.post(
      Uri.parse("${prefs.getString("ip")}/driver_view_profile"),
      body: {"did": prefs.getString('did').toString()},
    );

    var jsonData = json.decode(data.body);
    List<DriverProfile> profiles = [];

    for (var profile in jsonData["message"]) {
      DriverProfile newProfile = DriverProfile(
        profile["id"].toString(),
        profile["name"].toString(),
        profile["email"].toString(),
        profile["phone"].toString(),
        prefs.getString('ip').toString() + profile["photo"].toString(),
        prefs.getString('ip').toString() + profile["proof"].toString(),
      );
      profiles.add(newProfile);
    }
    return profiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MY PROFILE',
          style: TextStyle(
            color: Color(0xFFF57C00),
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            shadows: [
              Shadow(
                color: Color(0xFFF57C00).withValues(alpha: 0.8),
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
              Color(0xFF121212),
            ],
          ),
        ),
        child: FutureBuilder(
          future: _getDriverProfile(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFF57C00).withValues(alpha: 0.2),
                            Color(0xFFF57C00),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF57C00).withValues(alpha: 0.4),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "LOADING PROFILE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
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
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.withValues(alpha: 0.2),
                            Colors.red,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withValues(alpha: 0.3),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "ERROR LOADING PROFILE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var profile = snapshot.data![index];
                  return Column(
                    children: [
                      // Profile Header Card
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF1A1A1A),
                              Color(0xFF121212),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xFFF57C00).withValues(alpha: 0.3),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFF57C00).withValues(alpha: 0.1),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Profile Image with Neon Effect
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFFF57C00),
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFF57C00).withValues(alpha: 0.4),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  profile.photo,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xFFF57C00),
                                        strokeWidth: 2,
                                      ),
                                    );
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFF57C00).withValues(alpha: 0.2),
                                            Color(0xFFF57C00).withValues(alpha: 0.4),
                                          ],
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profile.name.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'DRIVER',
                                    style: TextStyle(
                                      color: Color(0xFFF57C00),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Details Section
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xFF333333),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PERSONAL INFORMATION',
                              style: TextStyle(
                                color: Color(0xFFF57C00),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 20),
                            _buildDetailItem(
                              icon: Icons.person_outline,
                              title: 'NAME',
                              value: profile.name,
                            ),
                            Divider(color: Color(0xFF333333), height: 30),
                            _buildDetailItem(
                              icon: Icons.email_outlined,
                              title: 'EMAIL',
                              value: profile.email,
                            ),
                            Divider(color: Color(0xFF333333), height: 30),
                            _buildDetailItem(
                              icon: Icons.phone_android_outlined,
                              title: 'PHONE',
                              value: profile.phone,
                            ),
                          ],
                        ),
                      ),

                      // Images Section
                      Row(
                        children: [
                          Expanded(
                            child: _buildImageCard(
                              title: 'PROFILE PHOTO',
                              imageUrl: profile.photo,
                              icon: Icons.person,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _buildImageCard(
                              title: 'PROOF DOCUMENT',
                              imageUrl: profile.proof,
                              icon: Icons.description,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),

                      // Edit Button with Neon Effect
                      Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFF57C00),
                              Color(0xFFFF9800),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFF57C00).withValues(alpha: 0.5),
                              blurRadius: 15,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => driver_edit_profilesub(
                                  id: profile.id.toString(),
                                  name: profile.name.toString(),
                                  email: profile.email.toString(),
                                  phone: profile.phone.toString(),
                                  proof: profile.proof.toString(),
                                  photo: profile.photo.toString(),
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 22,
                            color: Colors.white,
                          ),
                          label: Text(
                            'EDIT PROFILE',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              letterSpacing: 1.5,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                    ],
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFF57C00).withValues(alpha: 0.1),
                            Color(0xFFF57C00).withValues(alpha: 0.3),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF57C00).withValues(alpha: 0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.person_off_outlined,
                        size: 60,
                        color: Color(0xFFF57C00).withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "NO PROFILE FOUND",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Please set up your profile",
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Color(0xFFF57C00).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(0xFFF57C00).withValues(alpha: 0.3),
            ),
          ),
          child: Icon(
            icon,
            color: Color(0xFFF57C00),
            size: 22,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 6),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageCard({
    required String title,
    required String imageUrl,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFF333333),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFFF57C00),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Color(0xFFF57C00).withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFF57C00).withValues(alpha: 0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFF57C00),
                      strokeWidth: 2,
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Container(
                    color: Color(0xFF1A1A1A),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF57C00).withValues(alpha: 0.1),
                            ),
                            child: Icon(
                              icon,
                              color: Color(0xFFF57C00).withValues(alpha: 0.5),
                              size: 30,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Image not available',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
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
    );
  }
}

class DriverProfile {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final String proof;

  DriverProfile(this.id, this.name, this.email, this.phone, this.photo,
      this.proof);
}