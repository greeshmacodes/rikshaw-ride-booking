// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// void main(){
//   runApp(view_reviews());
// }
// class view_reviews extends StatelessWidget {
//   const view_reviews({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: view_reviewssub(),);
//   }
// }
//
// class view_reviewssub extends StatefulWidget {
//   const view_reviewssub({Key? key}) : super(key: key);
//
//   @override
//   State<view_reviewssub> createState() => view_reviewssubstate();
// }
//
// class view_reviewssubstate extends State<view_reviewssub> {
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String b = prefs.getString("lid").toString();
//     String foodimage="";
//     var data =
//     await http.post(Uri.parse(prefs.getString("ip").toString()+"/view_user_review"),
//         body: {"id":b}
//     );
//
//     var jsonData = json.decode(data.body);
// //    print(jsonData);
//     List<Joke> jokes = [];
//     for (var joke in jsonData["message"]) {
//       print(joke);
//       Joke newJoke = Joke(
//           joke["id"].toString(),
//           joke["rating"].toString(),
//           joke["review"].toString(),
//           joke["date"].toString(),
//           joke["USER"].toString(),
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body:
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
//                           _buildRow("rating:", i.rating.toString()),
//                           _buildRow("review:", i.review.toString()),
//                           _buildRow("USER:", i.USER.toString()),
//                           _buildRow("date:", i.date.toString()),
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
//   final String rating;
//   final String review;
//   final String date;
//   final String USER;
//
//
//
//
//
//   Joke(this.id,this.rating, this.review,this.date,this.USER);
// //  print("hiiiii");
// }


//......................................................................................
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Add import for drhome
import 'package:rickshaw_ride/driver/drhome.dart';

void main() {
  runApp(view_reviews());
}

class view_reviews extends StatelessWidget {
  const view_reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFF57C00), // Changed to 0xFFF57C00
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
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFF57C00), // Changed to 0xFFF57C00
          foregroundColor: Colors.white,
          elevation: 4,
          centerTitle: true,
          shadowColor: Color(0xFFF57C00).withValues(alpha: 0.5), // Changed to 0xFFF57C00
        ),
      ),
      home: view_reviewssub(),
    );
  }
}

class view_reviewssub extends StatefulWidget {
  const view_reviewssub({super.key});

  @override
  State<view_reviewssub> createState() => view_reviewssubstate();
}

class view_reviewssubstate extends State<view_reviewssub> {
  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String b = prefs.getString("did").toString();

    var data = await http.post(
      Uri.parse("${prefs.getString("ip")}/view_user_review"),
      body: {"did": b},
    );

    var jsonData = json.decode(data.body);
    List<Joke> jokes = [];

    for (var joke in jsonData["message"]) {
      Joke newJoke = Joke(
        joke["id"].toString(),
        joke["rating"].toString(),
        joke["review"].toString(),
        joke["date"].toString(),
        joke["user"].toString(),
      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Reviews Dashboard',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Color(0xFFF57C00).withValues(alpha: 0.8), // Changed to 0xFFF57C00
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => drhome()),
            );
          },
        ),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
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
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFF57C00).withValues(alpha: 0.2), // Changed to 0xFFF57C00
                            Color(0xFFF57C00), // Changed to 0xFFF57C00
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF57C00).withValues(alpha: 0.4), // Changed to 0xFFF57C00
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
                    SizedBox(height: 20),
                    Text(
                      'Loading Reviews...',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
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
                    Icon(
                      Icons.error_outline,
                      size: 70,
                      color: Colors.red.shade400,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Failed to load reviews',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
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
                        backgroundColor: Color(0xFFF57C00), // Changed to 0xFFF57C00
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.data == null || snapshot.data.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFF57C00).withValues(alpha: 0.1), // Changed to 0xFFF57C00
                            Color(0xFFF57C00).withValues(alpha: 0.3), // Changed to 0xFFF57C00
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF57C00).withValues(alpha: 0.2), // Changed to 0xFFF57C00
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.reviews_outlined,
                        size: 80,
                        color: Color(0xFFF57C00).withValues(alpha: 0.7), // Changed to 0xFFF57C00
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'No Reviews Yet',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Reviews will appear here',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
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
                        backgroundColor: Color(0xFFF57C00), // Changed to 0xFFF57C00
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  // Header with glowing effect
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFF57C00).withValues(alpha: 0.1), // Changed to 0xFFF57C00
                          Color(0xFFF57C00).withValues(alpha: 0.05), // Changed to 0xFFF57C00
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color(0xFFF57C00).withValues(alpha: 0.3), // Changed to 0xFFF57C00
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFF57C00).withValues(alpha: 0.2), // Changed to 0xFFF57C00
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Customer Reviews',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                                shadows: [
                                  Shadow(
                                    color: Color(0xFFF57C00).withValues(alpha: 0.3), // Changed to 0xFFF57C00
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Total Reviews: ${snapshot.data.length}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFF57C00), // Changed to 0xFFF57C00
                                Color(0xFFFB8C00), // Changed to 0xFFFB8C00
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFF57C00).withValues(alpha: 0.4), // Changed to 0xFFF57C00
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 5),
                              Text(
                                _calculateAverageRating(snapshot.data),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 20,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var i = snapshot.data![index];
                        return _buildReviewCard(i, index);
                      },
                    ),
                  ),
                  // Add bottom back button
                  Container(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => drhome()),
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text('Back to Home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF57C00), // Changed to 0xFFF57C00
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildReviewCard(Joke joke, int index) {
    double rating = double.tryParse(joke.rating) ?? 0;
    bool isGlowing = rating >= 4.0;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: isGlowing
                ? Color(0xFFF57C00).withValues(alpha: 0.3) // Changed to 0xFFF57C00
                : Colors.grey.shade200,
            blurRadius: isGlowing ? 15 : 8,
            spreadRadius: isGlowing ? 2 : 1,
          ),
        ],
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isGlowing
                  ? [
                Color(0xFFF57C00).withValues(alpha: 0.05), // Changed to 0xFFF57C00
                Colors.white,
              ]
                  : [Colors.white, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with user and rating
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User avatar with neon effect for high ratings
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFF57C00).withValues(alpha: 0.2), // Changed to 0xFFF57C00
                            Color(0xFFF57C00).withValues(alpha: 0.4), // Changed to 0xFFF57C00
                          ],
                        ),
                        boxShadow: isGlowing
                            ? [
                          BoxShadow(
                            color: Color(0xFFF57C00).withValues(alpha: 0.3), // Changed to 0xFFF57C00
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          joke.user[0].toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF57C00), // Changed to 0xFFF57C00
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
                            joke.user,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: List.generate(5, (starIndex) {
                              return Icon(
                                starIndex < rating.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Color(0xFFF57C00), // Changed to 0xFFF57C00
                                size: 20,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    // Rating badge with glowing effect
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: rating >= 4.0
                            ? LinearGradient(
                          colors: [
                            Color(0xFFF57C00), // Changed to 0xFFF57C00
                            Color(0xFFFF9800),
                          ],
                        )
                            : LinearGradient(
                          colors: [
                            Colors.orange.shade300,
                            Colors.orange.shade400,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: rating >= 4.0
                            ? [
                          BoxShadow(
                            color: Color(0xFFF57C00).withValues(alpha: 0.5), // Changed to 0xFFF57C00
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            rating.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Review text container with subtle glow
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFFF57C00).withValues(alpha: 0.1), // Changed to 0xFFF57C00
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    joke.review,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 12),

                // Footer with date and ID
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Colors.grey.shade500,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Reviewed on ${joke.date}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF57C00).withValues(alpha: 0.1), // Changed to 0xFFF57C00
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xFFF57C00).withValues(alpha: 0.3), // Changed to 0xFFF57C00
                        ),
                      ),
                      child: Text(
                        '#${index + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF57C00), // Changed to 0xFFF57C00
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _calculateAverageRating(List<Joke> jokes) {
    if (jokes.isEmpty) return '0.0';
    double total = 0;
    for (var joke in jokes) {
      total += double.tryParse(joke.rating) ?? 0;
    }
    return (total / jokes.length).toStringAsFixed(1);
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
  final String rating;
  final String review;
  final String date;
  final String user;

  Joke(this.id, this.rating, this.review, this.date, this.user);
}