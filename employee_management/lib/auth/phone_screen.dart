
import 'package:employee_management/auth/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var phone = "";
  String? validationError;

  Future<void> _authenticateUser() async {
    if (phone.isEmpty) {
      setState(() {
        validationError = "Please enter a valid phone number.";
      });
      return;
    }

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          print('Auto verification completed');
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          print('Code sent to $phone. Verification ID: $verificationId');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                verificationId: verificationId,
                registeredMobileNumber: phone, // Pass the registered mobile number
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('Auto retrieval timeout. Verification ID: $verificationId');
        },
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
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
                          Icons.phone_android,
                          size: 50,
                          color: Color.fromARGB(255, 121, 91, 3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Enter your Mobile number",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "We will send OTP on this mobile number",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: size.width,
                    height: 70,
                    child: IntlPhoneField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        // errorText: validationError,
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        setState(() {
                          this.phone = phone.completeNumber;
                          validationError = null; // Clear validation error on change
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8, // Adjust the space between the phone field and the error text
                  ),
                  if (validationError != null)
                    Text(
                      validationError!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  SizedBox(
                    height: 140,
                  ),
                  InkWell(
                    onTap: _authenticateUser,
                    child: Container(
                      width: size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 121, 91, 3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
