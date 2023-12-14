import 'dart:async';
import 'package:employee_management/Screens/Company_account.dart';
import 'package:employee_management/auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  final String registeredMobileNumber;

  OTPScreen({
    required this.verificationId,
    required this.registeredMobileNumber,
  });

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController _otpController = TextEditingController();
  bool _verifying = false;
  int _resendTimeout = 60;
  late Timer _resendTimer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _onKeyTap(String value) {
    if (_otpController.text.length < 6) {
      setState(() {
        _otpController.text = _otpController.text + value;
      });
    }
  }

  void _onBackspacePress() {
    if (_otpController.text.isNotEmpty) {
      setState(() {
        _otpController.text =
            _otpController.text.substring(0, _otpController.text.length - 1);
      });
    }
  }

  Future<void> _verifyOTP() async {
    try {
      setState(() {
        _verifying = true;
      });

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _otpController.text,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      print('Verification successful!');

      // Remove all previous routes and push CompanyAccountScreen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => SignUpPage(),
        ),
        (route) => false,
      );
    } catch (e) {
      print('Error verifying OTP: $e');
    } finally {
      setState(() {
        _verifying = false;
      });
    }
  }

  void _startResendTimer() {
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendTimeout > 0) {
          _resendTimeout--;
        }
      });
    });
  }

  void _resendOTP() async {
    if (_resendTimeout > 0) {
      return;
    }

    print('Resending OTP...');

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.registeredMobileNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          print('Auto verification completed');
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          print(
              'Code sent to ${widget.registeredMobileNumber}. Verification ID: $verificationId');
          setState(() {
            _resendTimeout = 60; // Reset to 60 seconds
          });
          _startResendTimer();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('Auto retrieval timeout. Verification ID: $verificationId');
        },
      );
    } catch (e) {
      print('Error resending OTP: $e');
    }
  }

  Widget _buildCustomKeyboard() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildKeyboardKey('1'),
            _buildKeyboardKey('2'),
            _buildKeyboardKey('3'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildKeyboardKey('4'),
            _buildKeyboardKey('5'),
            _buildKeyboardKey('6'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildKeyboardKey('7'),
            _buildKeyboardKey('8'),
            _buildKeyboardKey('9'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(width: 60, height: 50),
            _buildKeyboardKey('0'),
            _buildBackspaceKey(),
          ],
        ),
      ],
    );
  }

  Widget _buildKeyboardKey(String value) {
    return ElevatedButton(
      onPressed: () => _onKeyTap(value),
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(100, 240, 202, 89),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildBackspaceKey() {
    return ElevatedButton(
      onPressed: _onBackspacePress,
      style: ElevatedButton.styleFrom(
        primary: const Color.fromARGB(100, 240, 202, 89),
      ),
      child: Icon(
        Icons.backspace,
        color: Colors.black,
        size: 17,
      ),
    );
  }

  Widget _buildOtpBoxes() {
    List<Widget> boxes = [];

    for (int i = 0; i < 6; i++) {
      boxes.add(
        Container(
          width: 40,
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(
            i < _otpController.text.length ? _otpController.text[i] : '',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: boxes,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
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
                          Icons.lock,
                          size: 50,
                          color: Color.fromARGB(255, 121, 91, 3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  RegisteredMobileText(widget.registeredMobileNumber),
                  SizedBox(height: 40),
                  _buildOtpBoxes(),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: _verifying ? null : _verifyOTP,
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 121, 91, 3),
                ),
                child: _verifying
                    ? CircularProgressIndicator()
                    : Text(
                        'Verify OTP',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              child: SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CountdownText(_resendTimeout),
                    ElevatedButton(
                      onPressed: _resendTimeout > 0 ? null : _resendOTP,
                      style: ElevatedButton.styleFrom(
                        primary: _resendTimeout > 0
                            ? const Color.fromARGB(100, 240, 202, 89)
                            : const Color.fromARGB(255, 121, 91, 3),
                        padding: EdgeInsets.zero, // Remove default padding
                        minimumSize:
                            Size(110, 40), // Remove default minimumSize
                      ),
                      child: Text(
                        'Resend OTP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildCustomKeyboard(),
          ],
        ),
      ),
    );
  }
}

class RegisteredMobileText extends StatelessWidget {
  final String registeredMobileNumber;

  RegisteredMobileText(this.registeredMobileNumber);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Enter the OTP sent to your registered mobile number $registeredMobileNumber',
      style: TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    );
  }
}

class CountdownText extends StatelessWidget {
  final int seconds;

  CountdownText(this.seconds);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Resend OTP in $seconds seconds',
      style: TextStyle(fontSize: 16),
    );
  }
}
