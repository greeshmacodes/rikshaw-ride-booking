// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/driver/view_vehicle_details.dart';
// import 'package:rickshaw_ride/driver/viewprofile.dart';
// import 'package:rickshaw_ride/login.dart';
// import 'package:rickshaw_ride/user/urhome.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart'; // kIsWeb
// import 'dart:typed_data';
//
// class edit_vehicle_detailssub extends StatefulWidget {
//   final String id;
//   final String model;
//   final String no_of_seat;
//   final String photo;
//   final String rc;
//   final String license;
//
//   const edit_vehicle_detailssub({
//     Key? key,
//     required this.id,
//     required this.model,
//     required this.no_of_seat,
//     required this.photo,
//     required this.rc,
//     required this.license,
//   }) : super(key: key);
//
//   @override
//   State<edit_vehicle_detailssub> createState() => edit_vehicle_detailssubstate();
// }
//
// class edit_vehicle_detailssubstate extends State<edit_vehicle_detailssub> {
//   final formkey = GlobalKey<FormState>();
//   final model = TextEditingController();
//   final no_of_seat = TextEditingController();
//   final photo = TextEditingController();
//   final rc = TextEditingController();
//   final license = TextEditingController();
//
//   PlatformFile? _selectedPhoto;
//   PlatformFile? _selectedRc;
//   PlatformFile? _selectedLicense;
//
//   Uint8List? _webPhotoBytes;
//   Uint8List? _webRcBytes;
//   Uint8List? _webLicenseBytes;
//   bool _isLoading = false;
//
//   // Generic file picker method
//   Future<void> _pickFile(String fileType) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       type: FileType.any, // Any file type allowed
//     );
//
//     if (result != null) {
//       setState(() {
//         if (fileType == 'photo') {
//           _selectedPhoto = result.files.first;
//         } else if (fileType == 'rc') {
//           _selectedRc = result.files.first;
//         } else if (fileType == 'license') {
//           _selectedLicense = result.files.first;
//         }
//       });
//
//       if (kIsWeb) {
//         if (fileType == 'photo') {
//           _webPhotoBytes = result.files.first.bytes;
//         } else if (fileType == 'rc') {
//           _webRcBytes = result.files.first.bytes;
//         } else if (fileType == 'license') {
//           _webLicenseBytes = result.files.first.bytes;
//         }
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     model.text = widget.model;
//     no_of_seat.text = widget.no_of_seat;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: formkey,
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(
//                 width: 400,
//                 child: TextFormField(
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Required';
//                     }
//                     return null;
//                   },
//                   controller: model,
//                   decoration: InputDecoration(labelText: "Model"),
//                 ),
//               ),
//               SizedBox(height: 10),
//               SizedBox(
//                 width: 400,
//                 child: TextFormField(
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Required';
//                     }
//                     return null;
//                   },
//                   controller: no_of_seat,
//                   decoration: InputDecoration(labelText: "No of seats"),
//                 ),
//               ),
//               SizedBox(height: 10),
//               _buildFileUploadButton("photo"),
//               if (_selectedPhoto != null) ...[
//                 SizedBox(height: 10),
//                 Text("Selected: ${_selectedPhoto!.name}"),
//               ],
//               SizedBox(height: 10),
//               _buildFileUploadButton("rc"),
//               if (_selectedRc != null) ...[
//                 SizedBox(height: 10),
//                 Text("Selected: ${_selectedRc!.name}"),
//               ],
//               SizedBox(height: 10),
//               _buildFileUploadButton("license"),
//               if (_selectedLicense != null) ...[
//                 SizedBox(height: 10),
//                 Text("Selected: ${_selectedLicense!.name}"),
//               ],
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () async {
//                   SharedPreferences sh = await SharedPreferences.getInstance();
//
//                   var request = http.MultipartRequest(
//                     'POST',
//                     Uri.parse('${sh.getString('ip')}/edit_vehicle_details'),
//                   );
//
//                   // Normal form data
//                   request.fields['id']=widget.id;
//                   request.fields['model'] = model.text;
//                   request.fields['no_of_seat'] = no_of_seat.text;
//
//                   // File upload for photo
//                   if (_selectedPhoto != null) {
//                     if (kIsWeb) {
//                       request.files.add(http.MultipartFile.fromBytes(
//                         'photo',
//                         _webPhotoBytes!,
//                         filename: _selectedPhoto!.name,
//                       ));
//                     } else {
//                       request.files.add(await http.MultipartFile.fromPath(
//                         'photo',
//                         _selectedPhoto!.path!,
//                       ));
//                     }
//                   }
//
//                   // File upload for rc
//                   if (_selectedRc != null) {
//                     if (kIsWeb) {
//                       request.files.add(http.MultipartFile.fromBytes(
//                         'rc',
//                         _webRcBytes!,
//                         filename: _selectedRc!.name,
//                       ));
//                     } else {
//                       request.files.add(await http.MultipartFile.fromPath(
//                         'rc',
//                         _selectedRc!.path!,
//                       ));
//                     }
//                   }
//
//                   // File upload for license
//                   if (_selectedLicense != null) {
//                     if (kIsWeb) {
//                       request.files.add(http.MultipartFile.fromBytes(
//                         'license',
//                         _webLicenseBytes!,
//                         filename: _selectedLicense!.name,
//                       ));
//                     } else {
//                       request.files.add(await http.MultipartFile.fromPath(
//                         'license',
//                         _selectedLicense!.path!,
//                       ));
//                     }
//                   }
//
//                   var response = await request.send();
//
//                   // After request completion, navigate to profile page
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => view_vehicle_details()),
//                   );
//                 },
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // File upload button builder
//   Widget _buildFileUploadButton(String fileType) {
//     return ElevatedButton.icon(
//       icon: Icon(Icons.upload_file),
//       label: Text("Select $fileType"),
//       onPressed: () => _pickFile(fileType),
//     );
//   }
// }

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickshaw_ride/driver/view_vehicle_details.dart';
import 'package:rickshaw_ride/driver/viewprofile.dart';
import 'package:rickshaw_ride/login.dart';
import 'package:rickshaw_ride/user/urhome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart'; // kIsWeb

class edit_vehicle_detailssub extends StatefulWidget {
  final String id;
  final String model;
  final String no_of_seat;
  final String photo;
  final String rc;
  final String license;

  const edit_vehicle_detailssub({
    super.key,
    required this.id,
    required this.model,
    required this.no_of_seat,
    required this.photo,
    required this.rc,
    required this.license,
  });

  @override
  State<edit_vehicle_detailssub> createState() => edit_vehicle_detailssubstate();
}

class edit_vehicle_detailssubstate extends State<edit_vehicle_detailssub> {
  final formkey = GlobalKey<FormState>();
  final model = TextEditingController();
  final no_of_seat = TextEditingController();
  final photo = TextEditingController();
  final rc = TextEditingController();
  final license = TextEditingController();

  PlatformFile? _selectedPhoto;
  PlatformFile? _selectedRc;
  PlatformFile? _selectedLicense;

  Uint8List? _webPhotoBytes;
  Uint8List? _webRcBytes;
  Uint8List? _webLicenseBytes;
  bool _isLoading = false;

  // Generic file picker method
  Future<void> _pickFile(String fileType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        if (fileType == 'photo') {
          _selectedPhoto = result.files.first;
        } else if (fileType == 'rc') {
          _selectedRc = result.files.first;
        } else if (fileType == 'license') {
          _selectedLicense = result.files.first;
        }
      });

      if (kIsWeb) {
        if (fileType == 'photo') {
          _webPhotoBytes = result.files.first.bytes;
        } else if (fileType == 'rc') {
          _webRcBytes = result.files.first.bytes;
        } else if (fileType == 'license') {
          _webLicenseBytes = result.files.first.bytes;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    model.text = widget.model;
    no_of_seat.text = widget.no_of_seat;
  }

  Future<void> _submitForm() async {
    if (!formkey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${sh.getString('ip')}/edit_vehicle_details'),
      );

      // Normal form data
      request.fields['id'] = widget.id;
      request.fields['model'] = model.text;
      request.fields['no_of_seat'] = no_of_seat.text;

      // File upload for photo
      if (_selectedPhoto != null) {
        if (kIsWeb) {
          request.files.add(http.MultipartFile.fromBytes(
            'photo',
            _webPhotoBytes!,
            filename: _selectedPhoto!.name,
          ));
        } else {
          request.files.add(await http.MultipartFile.fromPath(
            'photo',
            _selectedPhoto!.path!,
          ));
        }
      }

      // File upload for rc
      if (_selectedRc != null) {
        if (kIsWeb) {
          request.files.add(http.MultipartFile.fromBytes(
            'rc',
            _webRcBytes!,
            filename: _selectedRc!.name,
          ));
        } else {
          request.files.add(await http.MultipartFile.fromPath(
            'rc',
            _selectedRc!.path!,
          ));
        }
      }

      // File upload for license
      if (_selectedLicense != null) {
        if (kIsWeb) {
          request.files.add(http.MultipartFile.fromBytes(
            'license',
            _webLicenseBytes!,
            filename: _selectedLicense!.name,
          ));
        } else {
          request.files.add(await http.MultipartFile.fromPath(
            'license',
            _selectedLicense!.path!,
          ));
        }
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Vehicle details updated successfully!'),
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
        MaterialPageRoute(builder: (context) => view_vehicle_details()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating vehicle details'),
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
          'EDIT VEHICLE',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => view_vehicle_details()),
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
        backgroundColor: Color(0xFFF57C00),
        elevation: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: 500),
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
              key: formkey,
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
                      Icons.directions_car,
                      color: Color(0xFFF57C00),
                      size: 40,
                    ),
                  ),
                  SizedBox(height: 20),

                  Text(
                    'Edit Vehicle Details',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 10),

                  Text(
                    'Update your vehicle information',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 30),

                  // Model Field
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Model is required';
                      }
                      return null;
                    },
                    controller: model,
                    style: TextStyle(color: Colors.grey.shade800),
                    decoration: InputDecoration(
                      labelText: "Vehicle Model",
                      hintText: "Enter vehicle model",
                      prefixIcon: Icon(
                        Icons.model_training,
                        color: Color(0xFFF57C00),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFFF57C00), width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Number of Seats Field
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Number of seats is required';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    controller: no_of_seat,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.grey.shade800),
                    decoration: InputDecoration(
                      labelText: "Number of Seats",
                      hintText: "Enter seat count",
                      prefixIcon: Icon(
                        Icons.event_seat,
                        color: Color(0xFFF57C00),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFFF57C00), width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // File Upload Section
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildFileUploadSection(
                          title: "Vehicle Photo",
                          fileType: "photo",
                          selectedFile: _selectedPhoto,
                          onPressed: () => _pickFile('photo'),
                        ),
                        SizedBox(height: 16),
                        _buildFileUploadSection(
                          title: "RC Document",
                          fileType: "rc",
                          selectedFile: _selectedRc,
                          onPressed: () => _pickFile('rc'),
                        ),
                        SizedBox(height: 16),
                        _buildFileUploadSection(
                          title: "License",
                          fileType: "license",
                          selectedFile: _selectedLicense,
                          onPressed: () => _pickFile('license'),
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
                      onPressed: _isLoading ? null : _submitForm,
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
                        'UPDATE VEHICLE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: Colors.white,
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
                          MaterialPageRoute(builder: (context) => view_vehicle_details()),
                        );
                      },
                      icon: Icon(Icons.cancel, size: 18),
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

  Widget _buildFileUploadSection({
    required String title,
    required String fileType,
    required PlatformFile? selectedFile,
    required VoidCallback onPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selectedFile != null
                  ? Color(0xFFF57C00)
                  : Colors.grey.shade300,
              width: selectedFile != null ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              ElevatedButton.icon(
                onPressed: onPressed,
                icon: Icon(
                  selectedFile != null ? Icons.check_circle : Icons.upload_file,
                  size: 18,
                ),
                label: Text(
                  selectedFile != null ? 'Change $title' : 'Upload $title',
                  style: TextStyle(fontSize: 13),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedFile != null
                      ? Color(0xFFF57C00).withValues(alpha: 0.1)
                      : Colors.grey.shade200,
                  foregroundColor: selectedFile != null
                      ? Color(0xFFF57C00)
                      : Colors.grey.shade700,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              if (selectedFile != null)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFF57C00).withValues(alpha: 0.05),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.insert_drive_file,
                        size: 14,
                        color: Color(0xFFF57C00),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          selectedFile.name,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}