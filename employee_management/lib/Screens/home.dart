
import 'package:employee_management/Screens/SettingsScreen.dart';
import 'package:employee_management/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SalaryScreen(),
    SupportScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Color.fromARGB(255, 121, 91, 3),
        unselectedItemColor: Colors.black,
        elevation: 5,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              // color: _currentIndex == 0 ? Colors.red : Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            // backgroundColor: Colors.cyan,
            icon: Icon(
              Icons.attach_money,
              // color: _currentIndex == 1 ? Colors.red : Colors.black,
            ),
            label: 'Salary',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.headset_mic,
              // color: _currentIndex == 2 ? Colors.red : Colors.black,
            ),
            label: 'Support',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              // color: _currentIndex == 3 ? Colors.red : Colors.black,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Home Screen'),
//     );
//   }
// }

class SalaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Salary Screen'),
    );
  }
}

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Support Screen'),
    );
  }
}

// class SettingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Settings Screen'),
//     );
//   }
// }
