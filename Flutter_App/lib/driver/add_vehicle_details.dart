// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/driver/drhome.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// void main(){
//   runApp(add_vehicle_details());
// }
// class add_vehicle_details extends StatelessWidget {
//   const add_vehicle_details({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: add_vehicle_detailssub(),);
//   }
// }
//
// class add_vehicle_detailssub extends StatefulWidget {
//   const add_vehicle_detailssub({Key? key}) : super(key: key);
//
//   @override
//   State<add_vehicle_detailssub> createState() => add_vehicle_detailssubstate();
// }
//
// class add_vehicle_detailssubstate extends State<add_vehicle_detailssub> {
//   final model=TextEditingController();
//   final no_of_seat=TextEditingController();
//
//   PlatformFile? _selectedFile;
//   Uint8List? _webFileBytes;
//   String? _result;
//   bool _isLoading = false;
//
//   // =====================================================
//   // 📸 PICK FILE FUNCTION
//   // =====================================================
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
//   // __-------------------------------
//
//   PlatformFile? _selectedFile1;
//   Uint8List? _webFileBytes1;
//   String? _result1;
//   bool _isLoading1 = false;
//
//   // =====================================================
//   // 📸 PICK FILE FUNCTION
//   // =====================================================
//   Future<void> _pickFile1() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       type: FileType.any, // Any file type allowed
//     );
//
//     if (result != null) {
//       setState(() {
//         _selectedFile1 = result.files.first;
//         _result1 = null;
//       });
//
//       if (kIsWeb) {
//         _webFileBytes1 = result.files.first.bytes;
//       }
//     }
//   }
//
//   // ---------------------------------
//
//   PlatformFile? _selectedFile2;
//   Uint8List? _webFileBytes2;
//   String? _result2;
//   bool _isLoading2 = false;
//
//   // =====================================================
//   // 📸 PICK FILE FUNCTION
//   // =====================================================
//   Future<void> _pickFile2() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       type: FileType.any, // Any file type allowed
//     );
//
//     if (result != null) {
//       setState(() {
//         _selectedFile2 = result.files.first;
//         _result2 = null;
//       });
//
//       if (kIsWeb) {
//         _webFileBytes2 = result.files.first.bytes;
//       }
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child: SingleChildScrollView(child: SizedBox(height: 500,width: 500,child: Column(
//       children: [
//
//         ElevatedButton.icon(
//           icon: Icon(Icons.upload_file),
//           label: Text("Select Image"),
//           onPressed: _pickFile,
//         ),
//         if (_selectedFile != null) ...[
//           SizedBox(height: 10),
//           Text("Selected: ${_selectedFile!.name}"),
//         ],SizedBox(height: 20,),
//         ElevatedButton.icon(
//           icon: Icon(Icons.upload_file),
//           label: Text("Select rc"),
//           onPressed: _pickFile1,
//         ),
//         if (_selectedFile1 != null) ...[
//           SizedBox(height: 10),
//           Text("Selected: ${_selectedFile1!.name}"),
//         ],SizedBox(height: 20,),
//         ElevatedButton.icon(
//           icon: Icon(Icons.upload_file),
//           label: Text("Select License"),
//           onPressed: _pickFile2,
//         ),
//         if (_selectedFile2 != null) ...[
//           SizedBox(height: 10),
//           Text("Selected: ${_selectedFile2!.name}"),
//         ],
//         TextField(controller: model,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             hintText: 'Enter model'
//
//           ),),SizedBox(height: 20,),
//
//         TextField(controller: no_of_seat,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             hintText: 'Enter seat no'
//
//           ),),SizedBox(height: 20,),
//         ElevatedButton(onPressed: () async {
//           SharedPreferences sh=await SharedPreferences.getInstance();
//
//           // =====================================================
//           // 🌐 SERVER REQUEST (POST to Django)
//           // =====================================================
//           var request =   await http.MultipartRequest(
//               'POST',
//               Uri.parse('${sh.getString('ip')}/add_vehicle')
//           );
//
//           // 🔹 Normal Form Data
//           request.fields['model'] = model.text;
//           request.fields['no_of_seat'] = no_of_seat.text;
//           request.fields['did'] = sh.getString('did').toString();
//
//           // 🔹 File Upload Part
//           if (kIsWeb) {
//             request.files.add(http.MultipartFile.fromBytes(
//               'image',
//               _webFileBytes!,
//               filename: _selectedFile!.name,
//             ));
//           } else {
//             request.files.add(await http.MultipartFile.fromPath(
//               'image',
//               _selectedFile!.path!,
//             ));
//           }
//           if (kIsWeb) {
//             request.files.add(http.MultipartFile.fromBytes(
//               'rc',
//               _webFileBytes1!,
//               filename: _selectedFile1!.name,
//             ));
//           } else {
//             request.files.add(await http.MultipartFile.fromPath(
//               'rc',
//               _selectedFile1!.path!,
//             ));
//           }
//           if (kIsWeb) {
//             request.files.add(http.MultipartFile.fromBytes(
//               'license',
//               _webFileBytes2!,
//               filename: _selectedFile2!.name,
//             ));
//           } else {
//             request.files.add(await http.MultipartFile.fromPath(
//               'license',
//               _selectedFile2!.path!,
//             ));
//           }
//           // =====================================================
//           // 🌐 END SERVER UPLOAD SECTION
//           // =====================================================
//
//           var response = await request.send();
//
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>drhome()));
//         }, child: Text('add'))
//
//       ],
//     ),),),),);
//   }
// }



import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickshaw_ride/driver/drhome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(add_vehicle_details());
}

class add_vehicle_details extends StatelessWidget {
  const add_vehicle_details({super.key});

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
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[800]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFF57C00), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[800]!),
          ),
          labelStyle: TextStyle(color: Color(0xFFF57C00)),
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),
      ),
      home: add_vehicle_detailssub(),
    );
  }
}

class add_vehicle_detailssub extends StatefulWidget {
  const add_vehicle_detailssub({super.key});

  @override
  State<add_vehicle_detailssub> createState() => add_vehicle_detailssubstate();
}

class add_vehicle_detailssubstate extends State<add_vehicle_detailssub> {
  final model = TextEditingController();
  final no_of_seat = TextEditingController();

  PlatformFile? _selectedFile;
  Uint8List? _webFileBytes;
  String? _result;
  final bool _isLoading = false;

  // =====================================================
  // 📸 PICK FILE FUNCTION
  // =====================================================
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any, // Any file type allowed
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
        _result = null;
      });

      if (kIsWeb) {
        _webFileBytes = result.files.first.bytes;
      }
    }
  }
  // __-------------------------------

  PlatformFile? _selectedFile1;
  Uint8List? _webFileBytes1;
  String? _result1;
  final bool _isLoading1 = false;

  // =====================================================
  // 📸 PICK FILE FUNCTION
  // =====================================================
  Future<void> _pickFile1() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any, // Any file type allowed
    );

    if (result != null) {
      setState(() {
        _selectedFile1 = result.files.first;
        _result1 = null;
      });

      if (kIsWeb) {
        _webFileBytes1 = result.files.first.bytes;
      }
    }
  }

  // ---------------------------------

  PlatformFile? _selectedFile2;
  Uint8List? _webFileBytes2;
  String? _result2;
  final bool _isLoading2 = false;

  // =====================================================
  // 📸 PICK FILE FUNCTION
  // =====================================================
  Future<void> _pickFile2() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any, // Any file type allowed
    );

    if (result != null) {
      setState(() {
        _selectedFile2 = result.files.first;
        _result2 = null;
      });

      if (kIsWeb) {
        _webFileBytes2 = result.files.first.bytes;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Add Vehicle Details',
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
              child: Padding(
                padding: EdgeInsets.all(24),
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
                        Icons.directions_car,
                        color: Color(0xFFF57C00),
                        size: 40,
                      ),
                    ),
                    SizedBox(height: 20),

                    Text(
                      'Add Your Vehicle',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Model Field
                    TextField(
                      controller: model,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Vehicle Model',
                        hintText: 'Enter model (e.g., Toyota, Honda)',
                        prefixIcon: Icon(
                          Icons.model_training,
                          color: Color(0xFFF57C00),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Seats Field
                    TextField(
                      controller: no_of_seat,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Number of Seats',
                        hintText: 'Enter seat count',
                        prefixIcon: Icon(
                          Icons.event_seat,
                          color: Color(0xFFF57C00),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Image Upload Section
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
                          Text(
                            'Upload Documents',
                            style: TextStyle(
                              color: Colors.orange[300],
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),

                          // Vehicle Photo Button
                          _buildFileUploadButton(
                            label: "Upload Vehicle Photo",
                            isSelected: _selectedFile != null,
                            fileName: _selectedFile?.name,
                            onPressed: _pickFile,
                          ),
                          SizedBox(height: 15),

                          // RC Document Button
                          _buildFileUploadButton(
                            label: "Upload RC Document",
                            isSelected: _selectedFile1 != null,
                            fileName: _selectedFile1?.name,
                            onPressed: _pickFile1,
                          ),
                          SizedBox(height: 15),

                          // License Button
                          _buildFileUploadButton(
                            label: "Upload License",
                            isSelected: _selectedFile2 != null,
                            fileName: _selectedFile2?.name,
                            onPressed: _pickFile2,
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
                        onPressed: () async {
                          if (_selectedFile == null ||
                              _selectedFile1 == null ||
                              _selectedFile2 == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please upload all required files'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          SharedPreferences sh = await SharedPreferences.getInstance();

                          // =====================================================
                          // 🌐 SERVER REQUEST (POST to Django)
                          // =====================================================
                          var request = http.MultipartRequest(
                              'POST',
                              Uri.parse('${sh.getString('ip')}/add_vehicle')
                          );

                          // 🔹 Normal Form Data
                          request.fields['model'] = model.text;
                          request.fields['no_of_seat'] = no_of_seat.text;
                          request.fields['did'] = sh.getString('did').toString();

                          // 🔹 File Upload Part
                          if (kIsWeb) {
                            request.files.add(http.MultipartFile.fromBytes(
                              'image',
                              _webFileBytes!,
                              filename: _selectedFile!.name,
                            ));
                          } else {
                            request.files.add(await http.MultipartFile.fromPath(
                              'image',
                              _selectedFile!.path!,
                            ));
                          }
                          if (kIsWeb) {
                            request.files.add(http.MultipartFile.fromBytes(
                              'rc',
                              _webFileBytes1!,
                              filename: _selectedFile1!.name,
                            ));
                          } else {
                            request.files.add(await http.MultipartFile.fromPath(
                              'rc',
                              _selectedFile1!.path!,
                            ));
                          }
                          if (kIsWeb) {
                            request.files.add(http.MultipartFile.fromBytes(
                              'license',
                              _webFileBytes2!,
                              filename: _selectedFile2!.name,
                            ));
                          } else {
                            request.files.add(await http.MultipartFile.fromPath(
                              'license',
                              _selectedFile2!.path!,
                            ));
                          }
                          // =====================================================
                          // 🌐 END SERVER UPLOAD SECTION
                          // =====================================================

                          var response = await request.send();

                          if (response.statusCode == 200) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Vehicle added successfully!'),
                                backgroundColor: Color(0xFFF57C00),
                              ),
                            );
                          }

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => drhome())
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'ADD VEHICLE',
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
                            MaterialPageRoute(builder: (context) => drhome()),
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
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(
              isSelected ? Icons.check_circle : Icons.upload_file,
              color: Colors.white,
            ),
            label: Text(
              label,
              style: TextStyle(color: Colors.white),
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
          if (isSelected)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFFF57C00).withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.insert_drive_file,
                    size: 16,
                    color: Color(0xFFF57C00),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      fileName ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}