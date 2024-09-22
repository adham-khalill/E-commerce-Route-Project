import 'package:flutter/material.dart';
import 'Api/ApiManger.dart';
import 'jsonFiles/Request/SignUpRequest.dart';

class RegisterScreen extends StatefulWidget {
  static const String registerScreenRoute = '/register';  // Define route name

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isVisible = false; // For password visibility toggle

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();  // Add a global key for the form

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      _showLoadingDialog();  // Show loading dialog

      final signUpRequest = SignUpRequest(
        name: fullNameController.text,
        email: emailController.text,
        password: passwordController.text,
        rePassword: rePasswordController.text,
        phone: mobileNumberController.text,
      );

      final response = await ApiManager.signUp(signUpRequest);

      Navigator.of(context).pop();  // Close the loading dialog

      if (response != null && response.message == 'success') {
        _showSnackBar('Registration successful!', Colors.green);
        // Navigate to the next screen or home page
      } else {
        _showSnackBar(response?.message ?? 'Registration failed. Please try again.', Colors.red);
      }
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dialog from being dismissed
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Signing up..."),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSnackBar(String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,  // Attach the form key
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50), // Extra space at the top

                  // The Route logo at the top
                  Text(
                    'Route',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),

                  // Full Name Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Full Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: fullNameController, // Attach controller
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'enter your full name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Mobile Number Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Mobile Number',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: mobileNumberController, // Attach controller
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'enter your mobile no.',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      if (!RegExp(r'^(00201|\+201|01)[0-2,5]{1}[0-9]{8}$').hasMatch(value)) {
                        return 'Please enter a valid 10-digit mobile number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // E-mail address Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'E-mail address',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: emailController, // Attach controller
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'enter your email address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Password Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: passwordController, // Attach controller
                    obscureText: !isVisible,  // Toggle obscureText based on visibility
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'enter your password',
                      suffixIcon: InkWell(
                        onTap: () => setState(() => isVisible = !isVisible),  // Toggle visibility
                        child: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,  // Toggle icon based on visibility
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  // Re-enter Password Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Re-enter Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: rePasswordController, // Attach controller
                    obscureText: !isVisible,  // Toggle obscureText based on visibility
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 're-enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please re-enter your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  // Sign up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _registerUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF003366), // Same blue color
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFF003366), // Background blue color
    );
  }
}
