// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rickshaw_ride/login.dart';
// import 'package:rickshaw_ride/user/chat_with_driver.dart' hide login;
// import 'package:shared_preferences/shared_preferences.dart';
// void main(){
//   runApp(change_password());
// }
// class change_password extends StatelessWidget {
//   const change_password ({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: change_passwordsub(),);
//   }
// }
//
// class change_passwordsub extends StatefulWidget {
//   const change_passwordsub({Key? key}) : super(key: key);
//
//   @override
//   State<change_passwordsub> createState() => change_passwordsubstate();
// }
//
// class change_passwordsubstate extends State<change_passwordsub> {
//   final current_password=TextEditingController();
//   final new_password=TextEditingController();
//   final confirm_password=TextEditingController();
//   final formkey=GlobalKey<FormState>();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Scaffold(
//       body: Form(key: formkey,child: Center(child: Column(
//         children: [
//           SizedBox(height: 10,),
//
//
//           SizedBox(width: 400,child:
//           TextFormField(validator: (value){
//             if(value == null || value.isEmpty){
//               return 'Required';
//             }return null;
//           },
//             controller: current_password,
//             decoration: InputDecoration(labelText: "Current_password"),
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
//             controller: new_password,
//             decoration: InputDecoration(labelText: "New_password"),
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
//             controller: confirm_password,
//             decoration: InputDecoration(labelText: "Confirm_password"),
//           ),),
//           SizedBox(height: 10,),
//           ElevatedButton(onPressed: () async {
//             SharedPreferences sh = await SharedPreferences.getInstance();
//             if(new_password.text!=confirm_password.text){
//               showDialog(context: context, builder: (context)=>AlertDialog(
//                 title: Text('password'),
//                 content: Text('password mismatch'),
//                 actions: [
//                   TextButton(onPressed: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>change_password()));
//                   }, child: Text('ok'))
//                 ],
//               ));
//             }
//             if(current_password.text!=sh.getString('password').toString()){
//               showDialog(context: context, builder: (context)=>AlertDialog(
//                 title: Text('password'),
//                 content: Text('invalid password'),
//                 actions: [
//                   TextButton(onPressed: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>change_password()));
//                   }, child: Text('ok'))
//                 ],
//               ));
//             }
//             var data =
//             await http.post(Uri.parse(sh.getString("ip").toString()+"/driver_change_password"),
//                 body: {
//                   'new_password':new_password.text,
//                   'did':sh.getString('did').toString()
//                 }
//             );
//
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginApp()));
//           }, child: Text("Submit"))
//         ],
//       ))),
//
//
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickshaw_ride/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Add this import for back navigation
import 'package:rickshaw_ride/driver/drhome.dart';

void main() {
  runApp(change_password());
}

class change_password extends StatelessWidget {
  const change_password({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFE65100), // Dark orange
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFE65100),
          secondary: Colors.orange[300]!,
          surface: Colors.grey[900]!,
        ),
        fontFamily: 'Roboto',
      ),
      home: const change_passwordsub(),
    );
  }
}

class change_passwordsub extends StatefulWidget {
  const change_passwordsub({super.key});

  @override
  State<change_passwordsub> createState() => change_passwordsubstate();
}

class change_passwordsubstate extends State<change_passwordsub>
    with SingleTickerProviderStateMixin {
  final current_password = TextEditingController();
  final new_password = TextEditingController();
  final confirm_password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    // Start animation after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!formkey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    SharedPreferences sh = await SharedPreferences.getInstance();

    // Validate passwords
    if (new_password.text != confirm_password.text) {
      _showErrorDialog('Password Mismatch',
          'New password and confirm password do not match.');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (current_password.text != sh.getString('password').toString()) {
      _showErrorDialog('Invalid Password', 'Current password is incorrect.');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      var response = await http.post(
        Uri.parse("${sh.getString("ip")}/driver_change_password"),
        body: {
          'new_password': new_password.text,
          'did': sh.getString('did').toString()
        },
      );

      if (response.statusCode == 200) {
        _showSuccessDialog();
      } else {
        _showErrorDialog('Server Error',
            'Failed to update password. Please try again.');
      }
    } catch (e) {
      _showErrorDialog(
          'Network Error', 'Please check your internet connection.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(
          CurvedAnimation(
            parent: ModalRoute.of(context)!.animation!,
            curve: Curves.easeOutBack,
          ),
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.grey[900],
          title: Text(
            title,
            style: const TextStyle(
              color: Color(0xFFE65100),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFFE65100),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(
          CurvedAnimation(
            parent: ModalRoute.of(context)!.animation!,
            curve: Curves.easeOutBack,
          ),
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.grey[900],
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Color(0xFFE65100), size: 28),
              SizedBox(width: 12),
              Text(
                'Success!',
                style: TextStyle(
                  color: Color(0xFFE65100),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          content: const Text(
            'Password changed successfully. Please login again with your new password.',
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                    const LoginApp(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: const Text(
                'CONTINUE TO LOGIN',
                style: TextStyle(
                  color: Color(0xFFE65100),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: child,
            ),
          );
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header Section
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.grey[900]!,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 20,
                        top: 20,
                        child: IconButton(
                          onPressed: () {
                            // Changed from Navigator.pop(context) to navigate to drhome()
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => drhome()),
                            );
                          },
                          icon: const Icon(Icons.arrow_back,
                              color: Color(0xFFE65100), size: 28),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE65100).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(45),
                                border: Border.all(
                                    color: const Color(0xFFE65100), width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    const Color(0xFFE65100).withValues(alpha: 0.3),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.lock_reset,
                                size: 50,
                                color: Color(0xFFE65100),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Change Password',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE65100),
                                fontFamily: 'Roboto',
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Secure your account with a new password',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.orange[300],
                                fontFamily: 'Roboto',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Form Section
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      color: Colors.grey[900],
                      shadowColor: const Color(0xFFE65100).withValues(alpha: 0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Form(
                          key: formkey,
                          child: Column(
                            children: [
                              // Current Password Field
                              _buildPasswordField(
                                controller: current_password,
                                label: 'Current Password',
                                hint: 'Enter your current password',
                                showPassword: _showCurrentPassword,
                                onToggleVisibility: () {
                                  setState(() {
                                    _showCurrentPassword =
                                    !_showCurrentPassword;
                                  });
                                },
                                icon: Icons.lock_outline,
                              ),
                              const SizedBox(height: 25),

                              // New Password Field
                              _buildPasswordField(
                                controller: new_password,
                                label: 'New Password',
                                hint: 'Enter your new password',
                                showPassword: _showNewPassword,
                                onToggleVisibility: () {
                                  setState(() {
                                    _showNewPassword = !_showNewPassword;
                                  });
                                },
                                icon: Icons.lock_open,
                              ),
                              const SizedBox(height: 25),

                              // Confirm Password Field
                              _buildPasswordField(
                                controller: confirm_password,
                                label: 'Confirm New Password',
                                hint: 'Re-enter your new password',
                                showPassword: _showConfirmPassword,
                                onToggleVisibility: () {
                                  setState(() {
                                    _showConfirmPassword =
                                    !_showConfirmPassword;
                                  });
                                },
                                icon: Icons.lock_reset,
                              ),
                              const SizedBox(height: 30),

                              // Password Requirements
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: const Color(0xFFE65100)
                                          .withValues(alpha: 0.3)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Password Requirements:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFE65100),
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    _buildPasswordRequirement(
                                      condition: new_password.text.length >= 8,
                                      text: 'At least 8 characters',
                                    ),
                                    const SizedBox(height: 4),
                                    _buildPasswordRequirement(
                                      condition: RegExp(r'[A-Z]')
                                          .hasMatch(new_password.text),
                                      text: 'One uppercase letter',
                                    ),
                                    const SizedBox(height: 4),
                                    _buildPasswordRequirement(
                                      condition: RegExp(r'[0-9]')
                                          .hasMatch(new_password.text),
                                      text: 'One number',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),

                              // Submit Button
                              SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _submitForm,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFE65100),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 5,
                                    shadowColor: const Color(0xFFE65100)
                                        .withValues(alpha: 0.4),
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                      AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                      : const Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.lock_reset, size: 20),
                                      SizedBox(width: 10),
                                      Text(
                                        "UPDATE PASSWORD",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Cancel Button - Updated to navigate to drhome()
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => drhome()),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFFE65100),
                                    side: const BorderSide(
                                        color: Color(0xFFE65100)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: const Text(
                                    "CANCEL",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Roboto',
                                    ),
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

                // Footer
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: const Color(0xFFE65100), width: 2),
                        ),
                        child: const Icon(
                          Icons.security,
                          size: 30,
                          color: Color(0xFFE65100),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Your security is our priority",
                        style: TextStyle(
                          color: Colors.orange[300],
                          fontSize: 14,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Rickshaw Ride Security © 2024",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordRequirement(
      {required bool condition, required String text}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: condition ? const Color(0xFFE65100) : Colors.grey[700],
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: condition ? const Color(0xFFE65100) : Colors.grey[700],
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool showPassword,
    required VoidCallback onToggleVisibility,
    required IconData icon,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE65100).withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: !showPassword,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Roboto',
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.grey[600],
          ),
          labelStyle: const TextStyle(
            fontFamily: 'Roboto',
            color: Color(0xFFE65100),
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE65100).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFE65100),
            ),
          ),
          suffixIcon: IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                showPassword ? Icons.visibility : Icons.visibility_off,
                color: const Color(0xFFE65100),
                key: ValueKey<bool>(showPassword),
              ),
            ),
            onPressed: onToggleVisibility,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey[800]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey[800]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
            const BorderSide(color: Color(0xFFE65100), width: 2),
          ),
          filled: true,
          fillColor: Colors.black.withValues(alpha: 0.7),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if (label.contains('New') && value.length < 8) {
            return 'Password must be at least 8 characters';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }
}