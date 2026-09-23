import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickshaw_ride/login.dart';
import 'package:rickshaw_ride/user/urhome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart'; // kIsWeb
import 'dart:typed_data';

void main() {
  runApp(drregister());
}

class drregister extends StatelessWidget {
  const drregister({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange,
        colorScheme: ColorScheme.dark(
          primary: Colors.orange,
          secondary: Colors.orange.shade700,
          surface: Colors.black,
          error: Colors.red,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.orange,
        ),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.orange, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.orange),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.orange,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.orange.shade300),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.orange.shade700),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.orange.shade700),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.orange, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          errorStyle: TextStyle(color: Colors.red.shade300),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.orange),
          bodyMedium: TextStyle(color: Colors.orange.shade300),
          titleLarge: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        ),
      ),
      home: drregistersub(),
    );
  }
}

class drregistersub extends StatefulWidget {
  const drregistersub({super.key});

  @override
  State<drregistersub> createState() => _drregistersubstate();
}

class _drregistersubstate extends State<drregistersub> {
  final formkey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final newpass = TextEditingController();
  final cpass = TextEditingController();

  PlatformFile? _selectedFile;
  Uint8List? _webFileBytes;
  String? _result;
  final bool _isLoading = false;

  PlatformFile? _selectedFile1;
  Uint8List? _webFileBytes1;
  String? _result1;
  final bool _isLoading1 = false;

  // Validation flags for file uploads
  bool _isPhotoValid = true;
  bool _isProofValid = true;
  String? _photoError;
  String? _proofError;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image, // Restrict to images for photo
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
        _result = null;
        _isPhotoValid = true;
        _photoError = null;
      });

      if (kIsWeb) {
        _webFileBytes = result.files.first.bytes;
      }
    }
  }

  Future<void> _pickFile1() async {
    FilePickerResult? result1 = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any, // Any file type allowed for proof
    );

    if (result1 != null) {
      setState(() {
        _selectedFile1 = result1.files.first;
        _result = null;
        _isProofValid = true;
        _proofError = null;
      });

      if (kIsWeb) {
        _webFileBytes1 = result1.files.first.bytes;
      }
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    // Allow only letters and spaces, minimum 2 characters
    final nameRegExp = RegExp(r'^[a-zA-Z\s]{2,50}$');
    if (!nameRegExp.hasMatch(value)) {
      return 'Enter a valid name (letters only, min 2 characters)';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Email validation pattern
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    // Phone validation - 10 digits, optional +91 or 0 prefix
    final phoneRegExp = RegExp(r'^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[6789]\d{9}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Enter a valid 10-digit Indian phone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // Password validation: min 8 chars, at least one uppercase, one lowercase, one number, one special character
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != newpass.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  bool validateFiles() {
    bool isValid = true;

    if (_selectedFile == null) {
      setState(() {
        _isPhotoValid = false;
        _photoError = 'Please select a photo';
      });
      isValid = false;
    }

    if (_selectedFile1 == null) {
      setState(() {
        _isProofValid = false;
        _proofError = 'Please select a proof document';
      });
      isValid = false;
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.orange.shade900.withValues(alpha: 0.3),
              Colors.black,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.orange.shade700, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: 0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "DRIVER REGISTRATION",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Name Field
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        validator: validateName,
                        controller: name,
                        style: TextStyle(color: Colors.orange),
                        decoration: InputDecoration(
                          labelText: "Name",
                          prefixIcon: Icon(Icons.person, color: Colors.orange),
                          hintText: "Enter your full name",
                          hintStyle: TextStyle(color: Colors.orange.withValues(alpha: 0.3)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Email Field
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        validator: validateEmail,
                        controller: email,
                        style: TextStyle(color: Colors.orange),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email, color: Colors.orange),
                          hintText: "example@email.com",
                          hintStyle: TextStyle(color: Colors.orange.withValues(alpha: 0.3)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Phone Field
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        validator: validatePhone,
                        controller: phone,
                        style: TextStyle(color: Colors.orange),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone",
                          prefixIcon: Icon(Icons.phone, color: Colors.orange),
                          hintText: "9876543210",
                          hintStyle: TextStyle(color: Colors.orange.withValues(alpha: 0.3)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Photo Upload Button with Validation
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.upload_file),
                          label: Text("Select Photo (Image)"),
                          onPressed: _pickFile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.black,
                            minimumSize: Size(200, 45),
                          ),
                        ),
                        if (!_isPhotoValid) ...[
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              _photoError!,
                              style: TextStyle(color: Colors.red.shade300, fontSize: 12),
                            ),
                          ),
                        ],
                        if (_selectedFile != null) ...[
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.orange.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.orange.shade700),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_circle, color: Colors.green, size: 16),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    "Selected: ${_selectedFile!.name}",
                                    style: TextStyle(color: Colors.orange),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),

                    SizedBox(height: 20),

                    // Proof Upload Button with Validation
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.upload_file),
                          label: Text("Select Proof (Document)"),
                          onPressed: _pickFile1,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.black,
                            minimumSize: Size(200, 45),
                          ),
                        ),
                        if (!_isProofValid) ...[
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              _proofError!,
                              style: TextStyle(color: Colors.red.shade300, fontSize: 12),
                            ),
                          ),
                        ],
                        if (_selectedFile1 != null) ...[
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.orange.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.orange.shade700),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_circle, color: Colors.green, size: 16),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    "Selected: ${_selectedFile1!.name}",
                                    style: TextStyle(color: Colors.orange),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),

                    SizedBox(height: 20),

                    // Password Field
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        validator: validatePassword,
                        controller: newpass,
                        obscureText: true,
                        style: TextStyle(color: Colors.orange),
                        decoration: InputDecoration(
                          labelText: "New Password",
                          prefixIcon: Icon(Icons.lock, color: Colors.orange),
                          hintText: "Min 8 chars with uppercase, number & special char",
                          hintStyle: TextStyle(color: Colors.orange.withValues(alpha: 0.3), fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Confirm Password Field
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        validator: validateConfirmPassword,
                        controller: cpass,
                        obscureText: true,
                        style: TextStyle(color: Colors.orange),
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.orange),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Submit Button
                    ElevatedButton(
                      onPressed: () async {
                        // Validate all form fields first
                        if (formkey.currentState!.validate() && validateFiles()) {
                          SharedPreferences sh = await SharedPreferences.getInstance();



                          try {
                            // =====================================================
                            // 🌐 SERVER REQUEST (POST to Django)
                            // =====================================================
                            var request = http.MultipartRequest(
                                'POST',
                                Uri.parse('${sh.getString('ip')}/driver_register')
                            );

                            // 🔹 Normal Form Data
                            request.fields['name'] = name.text;
                            request.fields['email'] = email.text;
                            request.fields['phone'] = phone.text;
                            request.fields['newpass'] = newpass.text;
                            request.fields['cpass'] = cpass.text;
                            request.fields['latitude'] = sh.getString('latitude').toString();
                            request.fields['longitude'] = sh.getString('longitude').toString();

                            // 🔹 File Upload Part
                            if (kIsWeb) {
                              request.files.add(http.MultipartFile.fromBytes(
                                'photo',
                                _webFileBytes!,
                                filename: _selectedFile!.name,
                              ));
                            } else {
                              request.files.add(await http.MultipartFile.fromPath(
                                'photo',
                                _selectedFile!.path!,
                              ));
                            }

                            if (kIsWeb) {
                              request.files.add(http.MultipartFile.fromBytes(
                                'proof',
                                _webFileBytes1!,
                                filename: _selectedFile1!.name,
                              ));
                            } else {
                              request.files.add(await http.MultipartFile.fromPath(
                                'proof',
                                _selectedFile1!.path!,
                              ));
                            }
                            // =====================================================
                            // 🌐 END SERVER UPLOAD SECTION
                            // =====================================================

                            var response = await request.send();

                            // Close loading dialog

                            if (response.statusCode == 200) {
                              // Show success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Registration Successful!"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginApp()));
                            } else {
                              // Show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Registration Failed. Please try again."),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } catch (e) {
                            // Close loading dialog
                            Navigator.pop(context);

                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Network Error. Please check your connection."),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } else {
                          // Show validation error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please fill all fields correctly and upload required files"),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        child: Text(
                          'REGISTER',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}