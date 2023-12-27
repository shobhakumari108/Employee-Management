// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:employee_management/Screens/Employee_screen.dart';
import 'package:employee_management/Screens/edit_employee_profile.dart';
import 'package:employee_management/models/add_employee_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EmployeeProfileScreen extends StatelessWidget {
  final Employee employee;

  const EmployeeProfileScreen({Key? key, required this.employee})
      : super(key: key);

  Future<void> _deleteProfile(BuildContext context) async {
    final url =
        'http://192.168.29.135:2000/app/employee/deteteEmployee/${employee.sId}';

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Profile deleted');
        print("deleted");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeScreen(),
          ),
          (route) => false,
        );
      } else {
        print('Failed to delete profile. Status code: ${response.statusCode}');
        Fluttertoast.showToast(msg: 'Failed to delete profile');
      }
    } catch (error) {
      print('Error deleting profile: $error');
      Fluttertoast.showToast(msg: 'Error deleting profile');
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text('Confirm Delete'),
          content:const Text('Are you sure you want to delete this profile?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteProfile(context);
              },
              child:const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileCard(String title, String value) {
    return Card(
      elevation: 4,
      margin:const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            // color: Colors.blue,
          ),
        ),
        subtitle: Text(
          value,
          style:const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Profile'),
        leading: IconButton(
          icon:const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => EmployeeScreen(),
              ),
              (route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon:const CircleAvatar(
              // backgroundColor: const Color.fromARGB(100, 240, 202, 89),
              child: Icon(
                Icons.edit,
                color: Color.fromARGB(255, 121, 91, 3),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployeeEditScreen(employee: employee),
                ),
              );
            },
          ),
          IconButton(
            icon: const CircleAvatar(
              // backgroundColor:const Color.fromARGB(100, 240, 202, 89) ,
              child: Icon(
                Icons.delete,
                color: Color.fromARGB(255, 121, 91, 3),
              ),
            ),
            onPressed: () {
              _showDeleteConfirmation(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(employee.ProfilePicture ?? ''),
              ),
            ),
           const SizedBox(height: 20),
            _buildProfileCard(
              'Name',
              '${employee.FirstName} ${employee.LastName}',
            ),
            _buildProfileCard('Email', '${employee.Email}'),
            _buildProfileCard('Phone Number', '${employee.PhoneNumber}'),
            _buildProfileCard('Job Type', '${employee.jobType}'),
            _buildProfileCard('Joining Date', '${employee.joiningDate}'),
            _buildProfileCard(
              'Company Name',
              '${employee.companyName}',
            ),
          ],
        ),
      ),
    );
  }
}
