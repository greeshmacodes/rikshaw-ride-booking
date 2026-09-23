// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/driver/driver_edit_profile.dart';
// import 'package:rickshaw_ride/driver/edit_vehicle_details.dart';
// import 'package:rickshaw_ride/driver/viewprofile.dart';
// import 'package:rickshaw_ride/user/edit_profile.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// void main(){
//   runApp(driver_view_profile());
// }
// class view_vehicle_details extends StatelessWidget {
//   const view_vehicle_details({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: view_vehicle_detailssub(),);
//   }
// }
//
// class view_vehicle_detailssub extends StatefulWidget {
//   const view_vehicle_detailssub({Key? key}) : super(key: key);
//
//   @override
//   view_vehicle_detailssubstate createState() => view_vehicle_detailssubstate();
// }
//
// class view_vehicle_detailssubstate extends State<view_vehicle_detailssub> {
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String b = prefs.getString("lid").toString();
//     String foodimage="";
//     var data =
//     await http.post(Uri.parse(prefs.getString("ip").toString()+"/view_vehicle_details"),
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
//         joke["model"].toString(),
//         joke["no_of_seat"].toString(),
//         prefs.getString("ip").toString()+joke["rc"].toString(),
//         prefs.getString("ip").toString()+joke["photo"].toString(),
//         prefs.getString("ip").toString()+joke["license"].toString(),
//
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
//                           _buildRow("model:", i.model.toString()),
//                           _buildRow("no_of_seat:", i.no_of_seat.toString()),
//
//                           Image.network(i.photo,height: 200,width: 200,),
//                           Image.network(i.rc,height: 200,width: 200,),
//                           Image.network(i.license,height: 200,width: 200,),
//
//                           Row(children: [
//                             ElevatedButton(onPressed: (){
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>edit_vehicle_detailssub(
//                                 id:i.id.toString(),
//                                 model:i.model.toString(),
//                                 no_of_seat:i.no_of_seat.toString(),
//                                 rc:i.rc.toString(),
//                                 photo:i.photo.toString(),
//                                 license:i.license.toString(),
//
//                               )));
//                             }, child: Text('edit')),
//                             ElevatedButton(onPressed: () async {
//                               SharedPreferences sh = await SharedPreferences.getInstance();
//                               var data =
//                               await http.post(Uri.parse(sh.getString("ip").toString()+"/remove_vehicle_details"),
//                                   body: {
//                                   'id':i.id.toString(),
//
//                                   });
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>view_vehicle_details()));
//                             }, child: Text('Remove'))
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
//   final String model;
//   final String no_of_seat;
//   final String rc;
//   final String photo;
//   final String license;
//
//
//
//
//   Joke(this.id,this.model, this.no_of_seat,this.rc, this.photo, this.license);
// //  print("hiiiii");
// }
//
//
//

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickshaw_ride/driver/drhome.dart';
import 'package:rickshaw_ride/driver/driver_edit_profile.dart';
import 'package:rickshaw_ride/driver/edit_vehicle_details.dart';
import 'package:rickshaw_ride/driver/viewprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Add import for urhome
import 'package:rickshaw_ride/user/urhome.dart';

void main(){
  runApp(view_vehicle_details());
}

class view_vehicle_details extends StatelessWidget {
  const view_vehicle_details({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFF57C00), // Orange color
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFF57C00),
          secondary: Color(0xFFFF9800),
          surface: Colors.grey[900]!,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Color(0xFFF57C00),
          elevation: 2,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF57C00),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ),
      home: view_vehicle_detailssub(),
    );
  }
}

class view_vehicle_detailssub extends StatefulWidget {
  const view_vehicle_detailssub({super.key});

  @override
  view_vehicle_detailssubstate createState() => view_vehicle_detailssubstate();
}

class view_vehicle_detailssubstate extends State<view_vehicle_detailssub> {
  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String b = prefs.getString("lid").toString();

    var data = await http.post(
        Uri.parse("${prefs.getString("ip")}/view_vehicle_details"),
        body: {"did": prefs.getString('did').toString()}
    );

    var jsonData = json.decode(data.body);
    List<Joke> jokes = [];

    for (var joke in jsonData["message"]) {
      Joke newJoke = Joke(
        joke["id"].toString(),
        joke["model"].toString(),
        joke["no_of_seat"].toString(),
        prefs.getString("ip").toString() + joke["rc"].toString(),
        prefs.getString("ip").toString() + joke["photo"].toString(),
        prefs.getString("ip").toString() + joke["license"].toString(),
      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Vehicle Details',
          style: TextStyle(
            color: Color(0xFFF57C00),
            fontSize: 22,
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
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFFF57C00),
            size: 28,
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
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.grey[900]!,
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
                      "Loading Vehicle Details...",
                      style: TextStyle(
                        color: Colors.orange[300],
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
                      color: Color(0xFFF57C00),
                      size: 60,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Error loading details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => drhome()),
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text('Back to Home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF57C00),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData && snapshot.data.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.directions_car_outlined,
                      color: Color(0xFFF57C00).withValues(alpha: 0.5),
                      size: 80,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "No Vehicle Details Found",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Add your vehicle details to get started",
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => drhome()),
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text('Back to Home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF57C00),
                        foregroundColor: Colors.white,
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
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey[900]!,
                          Colors.black,
                        ],
                      ),
                      border: Border.all(
                        color: Color(0xFFF57C00).withValues(alpha: 0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFF57C00).withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF57C00).withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Color(0xFFF57C00),
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.directions_car,
                                  color: Color(0xFFF57C00),
                                  size: 28,
                                ),
                              ),
                              SizedBox(width: 15),
                              Text(
                                "Vehicle ${index + 1}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20),

                          // Details Section
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey[800]!,
                              ),
                            ),
                            child: Column(
                              children: [
                                _buildDetailRow(
                                  icon: Icons.model_training,
                                  label: "Model",
                                  value: i.model,
                                ),
                                Divider(color: Colors.grey[800], height: 20),
                                _buildDetailRow(
                                  icon: Icons.event_seat,
                                  label: "Number of Seats",
                                  value: i.no_of_seat,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),

                          // Images Section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vehicle Images",
                                style: TextStyle(
                                  color: Colors.orange[300],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    _buildImageCard(
                                      title: "Vehicle Photo",
                                      imageUrl: i.photo,
                                      icon: Icons.photo_camera,
                                    ),
                                    SizedBox(width: 10),
                                    _buildImageCard(
                                      title: "RC Document",
                                      imageUrl: i.rc,
                                      icon: Icons.description,
                                    ),
                                    SizedBox(width: 10),
                                    _buildImageCard(
                                      title: "License",
                                      imageUrl: i.license,
                                      icon: Icons.card_membership,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 25),

                          // Buttons Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => edit_vehicle_detailssub(
                                          id: i.id.toString(),
                                          model: i.model.toString(),
                                          no_of_seat: i.no_of_seat.toString(),
                                          rc: i.rc.toString(),
                                          photo: i.photo.toString(),
                                          license: i.license.toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit, size: 18),
                                  label: Text(
                                    'EDIT',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFF57C00),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    SharedPreferences sh = await SharedPreferences.getInstance();
                                    var data = await http.post(
                                      Uri.parse("${sh.getString("ip")}/remove_vehicle_details"),
                                      body: {'id': i.id.toString()},
                                    );
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.delete, size: 18),
                                  label: Text(
                                    'REMOVE',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade800,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),

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
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xFFF57C00).withValues(alpha: 0.5),
              ),
            ),
            child: Icon(
              icon,
              color: Color(0xFFF57C00),
              size: 20,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.orange[300],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard({
    required String title,
    required String imageUrl,
    required IconData icon,
  }) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFFF57C00).withValues(alpha: 0.3),
          width: 2,
        ),
        color: Colors.black.withValues(alpha: 0.5),
      ),
      child: Column(
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFF57C00),
                      strokeWidth: 2,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[900],
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icon,
                            color: Color(0xFFF57C00).withValues(alpha: 0.5),
                            size: 40,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Image not found',
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
          Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFF57C00).withValues(alpha: 0.1),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.orange[300],
                fontSize: 12,
                fontWeight: FontWeight.w600,
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
  final String model;
  final String no_of_seat;
  final String rc;
  final String photo;
  final String license;

  Joke(this.id, this.model, this.no_of_seat, this.rc, this.photo, this.license);
}
