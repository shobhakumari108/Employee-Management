import 'package:employee_management/Screens/Employee_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee management System'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 121, 91, 3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Your Subtitle',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('App Lock'),
              onTap: () {
                // Handle the app lock action
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Rate the App'),
              onTap: () {
                // Handle the rating action
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share with Friends'),
              onTap: () {
                // Handle the sharing action
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmployeeScreen(),
                          ),
                        );
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(30),
                        elevation: 5,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              // color: Colors.cyan,
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(100, 240, 202, 89),
                                  radius: 20,
                                  child: Icon(
                                    Icons.person,
                                    color: Color.fromARGB(255, 121, 91, 3),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Employee',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(30),
                      elevation: 5,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          // color: Colors.cyan,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(100, 240, 202, 89),
                                radius: 20,
                                child: Icon(
                                  Icons.person_search,
                                  color: Color.fromARGB(255, 121, 91, 3),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Mark',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Attendance",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
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
