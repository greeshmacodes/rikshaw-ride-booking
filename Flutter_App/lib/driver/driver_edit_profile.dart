// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/driver/viewprofile.dart';
// import 'package:rickshaw_ride/login.dart';
// import 'package:rickshaw_ride/user/urhome.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart'; // kIsWeb
// import 'dart:typed_data';
//
//
//
//
// class driver_edit_profilesub extends StatefulWidget {
//   final String id;
//   final String name;
//   final String email;
//   final String phone;
//   final String proof;
//   final String photo;
//
//
//
//   const driver_edit_profilesub({Key? key, required this.id, required this.name,
//     required this.email, required this.phone, required this.proof, required this.photo}) : super(key: key);
//
//   @override
//   State<driver_edit_profilesub> createState() => _driver_edit_profilesubstate();
// }
//
// class _driver_edit_profilesubstate extends State<driver_edit_profilesub> {
//   final formkey = GlobalKey<FormState>();
//   final name = TextEditingController();
//   final email = TextEditingController();
//   final phone = TextEditingController();
//   final proof = TextEditingController();
//   final photo = TextEditingController();
//
//
//   PlatformFile? _selectedFile;
//   Uint8List? _webFileBytes;
//   String? _result;
//   bool _isLoading = false;
//
//   PlatformFile? _selectedFile1;
//   Uint8List? _webFileBytes1;
//   String? _result1;
//   bool _isLoading1 = false;
//
//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       type: FileType.any, // Any file type allowed
//     );
//
//     if (result != null) {
//       setState(() {
//         _selectedFile = result.files.first;
//         _result = null;
//       });
//
//       if (kIsWeb) {
//         _webFileBytes = result.files.first.bytes;
//       }
//     }
//   }
//
//   Future<void> _pickFile1() async {
//     FilePickerResult? result1 = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       type: FileType.any, // Any file type allowed
//     );
//
//     if (result1 != null) {
//       setState(() {
//         _selectedFile1 = result1.files.first;
//         _result = null;
//       });
//
//       if (kIsWeb) {
//         _webFileBytes1 = result1.files.first.bytes;
//       }
//     }
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     name.text=widget.name;
//     email.text=widget.email;
//     phone.text=widget.phone;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(key: formkey,child: Center(child: Column(
//         children: [
//           SizedBox(width: 400,child:
//           TextFormField(validator: (value){
//             if(value == null || value.isEmpty){
//               return 'Required';
//             }return null;
//           },
//             controller: name,
//             decoration: InputDecoration(labelText: "name"),
//           ),),
//           SizedBox(height: 10,),
//
//
//           SizedBox(width: 400,child:
//           TextFormField(validator: (value){
//             if(value == null || value.isEmpty){
//               return 'Required';
//             }return null;
//           },
//             controller: email,
//             decoration: InputDecoration(labelText: "email"),
//           ),),
//           SizedBox(height: 10,),
//
//
//           SizedBox(width: 400,child:
//           TextFormField(validator: (value){
//             if(value == null || value.isEmpty){
//               return 'Required';
//             }return null;
//           },
//             controller: phone,
//             decoration: InputDecoration(labelText: "phone"),
//           ),),
//
//           SizedBox(height: 10,),
//           ElevatedButton.icon(
//             icon: Icon(Icons.upload_file),
//             label: Text("Select Photo"),
//             onPressed: _pickFile,
//           ),
//           if (_selectedFile != null) ...[
//             SizedBox(height: 10),
//             Text("Selected: ${_selectedFile!.name}"),
//           ],
//
//           SizedBox(height: 10,),
//           ElevatedButton.icon(
//             icon: Icon(Icons.upload_file),
//             label: Text("Select Proof"),
//             onPressed: _pickFile1,
//           ),
//           if (_selectedFile1 != null) ...[
//             SizedBox(height: 10),
//             Text("Selected: ${_selectedFile1!.name}"),
//           ],
//
//
//           SizedBox(height: 10,),
//
//
//           SizedBox(height: 10,),
//           ElevatedButton(onPressed: () async {
//
//             SharedPreferences sh=await SharedPreferences.getInstance();
//
//             // =====================================================
//             // 🌐 SERVER REQUEST (POST to Django)
//             // =====================================================
//             var request =   await http.MultipartRequest(
//                 'POST',
//                 Uri.parse('${sh.getString('ip')}/driver_edit_profile')
//             );
//
//             // 🔹 Normal Form Data
//             request.fields['id'] = widget.id;
//             request.fields['name'] = name.text;
//             request.fields['email'] = email.text;
//             request.fields['phone'] = phone.text;
//
//             // request.fields['uid'] = uid.getString('uid').toString();
//
//             // 🔹 File Upload Part
//             if (kIsWeb) {
//               request.files.add(http.MultipartFile.fromBytes(
//                 'photo',
//                 _webFileBytes!,
//                 filename: _selectedFile!.name,
//               ));
//             } else {
//               request.files.add(await http.MultipartFile.fromPath(
//                 'photo',
//                 _selectedFile!.path!,
//               ));
//             }
//
//             if (kIsWeb) {
//               request.files.add(http.MultipartFile.fromBytes(
//                 'proof',
//                 _webFileBytes1!,
//                 filename: _selectedFile1!.name,
//               ));
//             } else {
//               request.files.add(await http.MultipartFile.fromPath(
//                 'proof',
//                 _selectedFile1!.path!,
//               ));
//             }
//             // =====================================================
//             // 🌐 END SERVER UPLOAD SECTION
//             // =====================================================
//
//             var response = await request.send();
//
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>driver_view_profile()));
//
//           }, child: Text('send'))
//
//         ],
//       ))),
//
//
//     );
//   }
// }

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickshaw_ride/driver/viewprofile.dart';
import 'package:rickshaw_ride/login.dart';
import 'package:rickshaw_ride/user/urhome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart'; // kIsWeb

// Import for back navigation
import 'package:rickshaw_ride/driver/drhome.dart';

class driver_edit_profilesub extends StatefulWidget {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String proof;
  final String photo;

  const driver_edit_profilesub({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.proof,
    required this.photo
  });

  @override
  State<driver_edit_profilesub> createState() => _driver_edit_profilesubstate();
}

class _driver_edit_profilesubstate extends State<driver_edit_profilesub> {
  final formkey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final proof = TextEditingController();
  final photo = TextEditingController();

  PlatformFile? _selectedFile;
  Uint8List? _webFileBytes;
  String? _result;
  final bool _isLoading = false;

  PlatformFile? _selectedFile1;
  Uint8List? _webFileBytes1;
  String? _result1;
  final bool _isLoading1 = false;

  // Track if files are selected
  bool _isPhotoSelected = false;
  bool _isProofSelected = false;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image, // Restrict to images
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
        _isPhotoSelected = true;
        _result = null;
      });

      if (kIsWeb) {
        _webFileBytes = result.files.first.bytes;
      }
    } else {
      // User canceled the picker
      setState(() {
        _isPhotoSelected = false;
      });
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
        _isProofSelected = true;
        _result = null;
      });

      if (kIsWeb) {
        _webFileBytes1 = result1.files.first.bytes;
      }
    } else {
      // User canceled the picker
      setState(() {
        _isProofSelected = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    name.text = widget.name;
    email.text = widget.email;
    phone.text = widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'EDIT PROFILE',
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
              MaterialPageRoute(builder: (context) => driver_view_profile()),
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
        elevation: 2,
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
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(maxWidth: 500),
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    // Header Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFFF57C00).withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFFF57C00),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF57C00).withValues(alpha: 0.3),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Color(0xFFF57C00),
                        size: 40,
                      ),
                    ),
                    SizedBox(height: 20),

                    Text(
                      'Edit Driver Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Name Field
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          if (value.length < 3) {
                            return 'Name must be at least 3 characters';
                          }
                          return null;
                        },
                        controller: name,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          hintText: "Enter your full name",
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Color(0xFFF57C00),
                          ),
                          labelStyle: TextStyle(color: Color(0xFFF57C00)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[800]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[800]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFFF57C00), width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.black.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Email Field
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        controller: email,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          hintText: "Enter your email",
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Color(0xFFF57C00),
                          ),
                          labelStyle: TextStyle(color: Color(0xFFF57C00)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[800]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[800]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFFF57C00), width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.black.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Phone Field
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          }
                          if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                            return 'Enter a valid 10-digit phone number';
                          }
                          return null;
                        },
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          hintText: "Enter your phone number",
                          prefixIcon: Icon(
                            Icons.phone_android_outlined,
                            color: Color(0xFFF57C00),
                          ),
                          labelStyle: TextStyle(color: Color(0xFFF57C00)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[800]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[800]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFFF57C00), width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.black.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Photo Upload Section (Optional)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isPhotoSelected ? Color(0xFFF57C00) : Colors.grey[800]!,
                          width: _isPhotoSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Profile Photo',
                                style: TextStyle(
                                  color: Colors.orange[300],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Optional',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          _buildFileUploadButton(
                            label: _isPhotoSelected ? "Change Photo" : "Upload New Photo (Optional)",
                            isSelected: _isPhotoSelected,
                            fileName: _selectedFile?.name,
                            onPressed: _pickFile,
                          ),
                          if (_isPhotoSelected) ...[
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Photo selected: ${_selectedFile!.name}",
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _selectedFile = null;
                                      _isPhotoSelected = false;
                                      _webFileBytes = null;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Proof Upload Section (Optional)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isProofSelected ? Color(0xFFF57C00) : Colors.grey[800]!,
                          width: _isProofSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Proof Document',
                                style: TextStyle(
                                  color: Colors.orange[300],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Optional',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          _buildFileUploadButton(
                            label: _isProofSelected ? "Change Proof" : "Upload New Proof (Optional)",
                            isSelected: _isProofSelected,
                            fileName: _selectedFile1?.name,
                            onPressed: _pickFile1,
                          ),
                          if (_isProofSelected) ...[
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Proof selected: ${_selectedFile1!.name}",
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _selectedFile1 = null;
                                      _isProofSelected = false;
                                      _webFileBytes1 = null;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
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
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            SharedPreferences sh = await SharedPreferences.getInstance();

                            // =====================================================
                            // 🌐 SERVER REQUEST (POST to Django)
                            // =====================================================
                            var request = http.MultipartRequest(
                                'POST',
                                Uri.parse('${sh.getString('ip')}/driver_edit_profile')
                            );

                            // 🔹 Normal Form Data
                            request.fields['id'] = widget.id;
                            request.fields['name'] = name.text;
                            request.fields['email'] = email.text;
                            request.fields['phone'] = phone.text;

                            // 🔹 File Upload Part - Photo (only if selected)
                            if (_isPhotoSelected && _selectedFile != null) {
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
                            }

                            // 🔹 File Upload Part - Proof (only if selected)
                            if (_isProofSelected && _selectedFile1 != null) {
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
                            }
                            // =====================================================
                            // 🌐 END SERVER UPLOAD SECTION
                            // =====================================================

                            var response = await request.send();

                            if (response.statusCode == 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Profile updated successfully!'),
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
                                MaterialPageRoute(builder: (context) => driver_view_profile())
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'UPDATE PROFILE',
                          style: TextStyle(
                            fontSize: 18,
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
                            MaterialPageRoute(builder: (context) => driver_view_profile()),
                          );
                        },
                        icon: Icon(Icons.cancel),
                        label: Text('CANCEL'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Color(0xFFF57C00),
                          side: BorderSide(color: Color(0xFFF57C00)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
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
      ),
    );
  }

  Widget _buildFileUploadButton({
    required String label,
    required bool isSelected,
    required String? fileName,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? Color(0xFFF57C00) : Colors.grey[800]!,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          isSelected ? Icons.edit : Icons.upload_file,
          color: Colors.white,
          size: 20,
        ),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? Color(0xFFF57C00).withValues(alpha: 0.7)
              : Colors.grey[800],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}