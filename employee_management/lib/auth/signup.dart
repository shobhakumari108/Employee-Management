import 'package:employee_management/auth/login.dart';
import 'package:employee_management/models/user_model.dart';
import 'package:employee_management/service/user_service.dart';
import 'package:employee_management/widgets/textfield.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Sign Up'),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                Center(
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: Material(
                      borderRadius: BorderRadius.circular(60),
                      elevation: 10,
                      child: Icon(
                        Icons.person,
                        size: 50, // Adjust the icon size as needed
                        color: Color.fromARGB(
                            255, 121, 91, 3), // Set the icon color as needed
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                buildTextFieldWithIcon(
                  controller: _controllerFirstName,
                  hintText: 'First Name',
                  icon: Icons.person_add,
                ),
                SizedBox(height: 20),
                buildTextFiel
                  controller: _controllerLastName,
                  hintText: 'Last Name',
                  icon: Icons.person,
                ),
                SizedBox(height: 20),
                buildTextFieldWithIcon(
                  controller: _controllerEmail,
                  hintText: 'Email',
                  icon: Icons.email,
                ),
                SizedBox(height: 20),
                buildTextFieldWithIcon(
                  controller: _controllerPassword,
                  hintText: 'Password',
                  icon: Icons.lock,
                ),
                SizedBox(height: 60),
                SizedBox(
                    width: size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        User user = User(
                          firstName: _controllerFirstName.text,
                          lastName: _controllerLastName.text,
                          email: _controllerEmail.text,
                          password: _controllerPassword.text,
                        );

                        print("User Data: ${user.toJson()}");

                        // Call the ApiService to sign up the user
                        bool signUpSuccess = await ApiService.signUp(user);

                        if (signUpSuccess) {
                          // Navigate to the login screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserLoginScreen()),
                          );
                        } else {
                          // Handle sign-up failure
                          print("Sign-up failed");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 121, 91, 3),
                      ),
                      child: Text(
                        'Signup',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the next page when the text is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserLoginScreen()), // Replace NextPage() with your next page widget
                        );
                      },
                      child: Text(
                        'Login',
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
        ),
      ),
    );
  }
}
