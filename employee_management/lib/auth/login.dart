// user_login_screen.dart
import 'package:employee_management/Screens/home.dart';
import 'package:employee_management/auth/signup.dart';
import 'package:employee_management/service/user_login_service.dart';
import 'package:flutter/material.dart';

import 'package:employee_management/models/user_login_model.dart';

import 'package:employee_management/widgets/textfield.dart';

class UserLoginScreen extends StatefulWidget {
  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 120,
                width: 120,
                child: Material(
                  borderRadius: BorderRadius.circular(60),
                  elevation: 10,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Color.fromARGB(255, 121, 91, 3),
                  ),
                ),
              ),
            ),
            SizedBox(height: 60),
            // Add your text fields or other UI elements here
            buildTextFieldWithIcon(
              controller: _emailController,
              hintText: 'Email',
              icon: Icons.email,
            ),
            SizedBox(height: 20),
            buildTextFieldWithIcon(
              controller: _passwordController,
              hintText: 'Password',
              icon: Icons.lock,
            ),
            SizedBox(height: 60),
            SizedBox(
              width: size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  String email = _emailController.text;
                  String password = _passwordController.text;

                  UserLogin? userLogin =
                      await AuthService.login(email, password);

                  if (userLogin != null) {
                    print("Login Successful");
                    print("Email: ${email}, Password: ${password}");
                    _navigateToHomeScreen(context);
                  } else {
                    print("Login Failed");
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 121, 91, 3),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don`t have an account? ",
                  style: TextStyle(fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the next page when the text is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SignUpPage()), // Replace NextPage() with your next page widget
                    );
                  },
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 121, 91, 3),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
