
import 'package:employee_management/Screens/home.dart';
import 'package:employee_management/auth/login.dart';
import 'package:employee_management/auth/login_screen.dart';
import 'package:employee_management/auth/otp_screen.dart';
import 'package:employee_management/auth/signup.dart';
import 'package:employee_management/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home:LoginScreen(),
      // home: SignUpPage(),
      // home:UserLoginScreen(),
      home:MyHomePage(),
      // home:OTPScreen(verificationId: '', registeredMobileNumber: '',),
  
// http://localhost:2000/app/users/addUser
    );
  }
}






 

// await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );