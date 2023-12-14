
import 'package:employee_management/Screens/signup_screen.dart';
import 'package:flutter/material.dart';

class CompanyAccountScreen extends StatefulWidget {
  const CompanyAccountScreen({super.key});

  @override
  State<CompanyAccountScreen> createState() => _CompanyAccountScreenState();
}

class _CompanyAccountScreenState extends State<CompanyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 28),
            Text(
              "Employee Management System",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 80),
            Material(
              elevation: 5,
              child: Container(
                width: size.width,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Selfie Attendance",
                        style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.w800,
                        ),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Color.fromARGB(100, 240, 202, 89),
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Color.fromARGB(255, 121, 91, 3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Material(
              elevation: 5,
              child: Container(
                width: size.width,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "GPS Attendance",
                        style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.w800,
                        ),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Color.fromARGB(100, 240, 202, 89),
                        child: Icon(
                          Icons.location_on,
                          size: 20,
                          color: Color.fromARGB(255, 121, 91, 3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Material(
              elevation: 5,
              child: Container(
                width: size.width,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Block Fake Attendance",
                        style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.w800,
                        ),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Color.fromARGB(100, 240, 202, 89),
                        child: Icon(
                          Icons.do_not_disturb,
                          size: 20,
                          color: Color.fromARGB(255, 121, 91, 3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Material(
              elevation: 5,
              child: Container(
                width: size.width,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Manage Leave",
                        style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.w800,
                        ),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Color.fromARGB(100, 240, 202, 89),
                        child: Icon(
                          Icons.date_range,
                          size: 20,
                          color: Color.fromARGB(255, 121, 91, 3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 180),
            SizedBox(
                width: size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 121, 91, 3),
                  ),
                  child: Text(
                    'Create Company Account',
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
            Text(
              'Join Existing Company',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ]),
        ),
      )),
    );
  }
}
