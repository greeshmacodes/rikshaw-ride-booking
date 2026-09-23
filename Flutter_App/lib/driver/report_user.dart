// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/driver/drhome.dart';
// import 'package:rickshaw_ride/driver/report_user.dart';
// import 'package:rickshaw_ride/user/urhome.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// void main(){
//   runApp(report_user());
// }
// class report_user extends StatelessWidget {
//   const report_user({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: report_usersub(),);
//   }
// }
//
// class report_usersub extends StatefulWidget {
//   const report_usersub({Key? key}) : super(key: key);
//
//   @override
//   State<report_usersub> createState() => report_usersubstate();
// }
//
// class report_usersubstate extends State<report_usersub> {
//   TextEditingController report=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text('view_previous_ride'),leading: IconButton(onPressed: (){
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>urhome()));
//         }, icon: Icon(Icons.arrow_back)),),
//         body:Center(
//         child: Container(
//           height: 300,
//           width:300,
//
//           child:
//           Column(
//             children: [TextField(
//               controller: report,
//               decoration: InputDecoration(
//                   labelText: "report user",
//                   hintText: "report",
//                   prefixIcon: Icon(Icons.report),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
//
//               ),
//
//             ),
//               SizedBox(height: 20,),
//               ElevatedButton(onPressed: ()async {
//                 SharedPreferences sh=await SharedPreferences.getInstance();
//                 var data=await http.post(Uri.parse('${sh.getString('ip')}/report_user'),
//                     body: {
//                       'report':report.text,
//                       'did':sh.getString('did').toString(),
//                       'reqid':sh.getString('reqid').toString()
//                     }
//                 );
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>drhome()));
//               }, child:Text("report"))
//
//             ],
//
//           ),
//
//         )
//     )
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:rickshaw_ride/user/urhome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'drhome.dart';

void main() {
  runApp(report_user());
}

class report_user extends StatelessWidget {
  const report_user({super.key});

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
            backgroundColor: Color(0xFFF57C00),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFF57C00), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          labelStyle: TextStyle(color: Color(0xFFF57C00)),
          hintStyle: TextStyle(color: Colors.grey.shade500),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      home: report_driversub(),
    );
  }
}

class report_driversub extends StatefulWidget {
  const report_driversub({super.key});

  @override
  State<report_driversub> createState() => report_driversubstate();
}

class report_driversubstate extends State<report_driversub> {
  TextEditingController report = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      var data = await http.post(
        Uri.parse('${sh.getString('ip')}/report_driver'),
        body: {
          'report': report.text,
          'uid': sh.getString('uid').toString(),
          'reqid': sh.getString('reqid').toString()
        },
      );

      if (data.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Report submitted successfully'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => drhome()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting report'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'REPORT DRIVER',
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
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
                BoxShadow(
                  color: Color(0xFFF57C00).withValues(alpha: 0.1),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFFF57C00).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFF57C00),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFF57C00).withValues(alpha: 0.3),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.report_problem,
                      color: Color(0xFFF57C00),
                      size: 40,
                    ),
                  ),
                  SizedBox(height: 20),

                  Text(
                    'Report a Driver',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 10),

                  Text(
                    'Please describe the issue you encountered',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),

                  // Report Field
                  TextFormField(
                    controller: report,
                    maxLines: 5,
                    maxLength: 500,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please describe the issue';
                      }
                      if (value.length < 10) {
                        return 'Please provide more details (minimum 10 characters)';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Report Details",
                      hintText: "Describe what happened...",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.description,
                          color: Color(0xFFF57C00),
                        ),
                      ),
                      alignLabelWithHint: true,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Warning Message
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.orange.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.orange,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Your report will be reviewed by our team. False reports may result in account suspension.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.orange.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),

                  // Submit Button
                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFF57C00),
                          Color(0xFFFF9800),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFF57C00).withValues(alpha: 0.5),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submitReport,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                          : Text(
                        'SUBMIT REPORT',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Cancel Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => urhome()),
                        );
                      },
                      icon: Icon(Icons.cancel),
                      label: Text('CANCEL'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFFF57C00),
                        side: BorderSide(color: Color(0xFFF57C00)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}