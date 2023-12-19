import 'package:employee_management/Screens/Employee_screen.dart';
import 'package:employee_management/Screens/employee_profile_screen.dart';
import 'package:employee_management/service/add_employee_service.dart';
import 'package:employee_management/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:employee_management/models/add_employee_model.dart';

class EmployeeEditScreen extends StatefulWidget {
  final Employee employee;

  const EmployeeEditScreen({Key? key, required this.employee})
      : super(key: key);

  @override
  _EmployeeEditScreenState createState() => _EmployeeEditScreenState();
}

class _EmployeeEditScreenState extends State<EmployeeEditScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _jobTypeController = TextEditingController();
  TextEditingController _joiningDateController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();

    // Initialize the text controllers with existing values
    _firstNameController.text = widget.employee.FirstName ?? '';
    _lastNameController.text = widget.employee.LastName ?? '';
    _emailController.text = widget.employee.Email ?? '';
    _phoneController.text = widget.employee.PhoneNumber ?? '';
    _jobTypeController.text = widget.employee.jobType ?? '';
    _joiningDateController.text = widget.employee.joiningDate ?? '';
    _companyNameController.text = widget.employee.companyName ?? '';
  }

  Future<void> _updateEmployeeProfile() async {
    // Create an Employee object with updated values
    Employee updatedEmployee = Employee(
      sId: widget.employee.sId,
      FirstName: _firstNameController.text,
      LastName: _lastNameController.text,
      Email: _emailController.text,
      PhoneNumber: _phoneController.text,
      jobType: _jobTypeController.text,
      joiningDate: _joiningDateController.text,
      companyName: _companyNameController.text,
    );

    // Call the service to update the employee
    bool success = await EmployeeService.updateEmployee(updatedEmployee);

    if (success) {
      // Show a toast and return the updated employee data
      Fluttertoast.showToast(msg: 'Profile updated');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeeProfileScreen(
              employee: updatedEmployee), // Replace with your EmployeeScreen
        ),
        (route) => false, // This makes sure to remove all previous routes
      );

      // Navigator.pop(context, updatedEmployee);
    } else {
      Fluttertoast.showToast(msg: 'Failed to update profile');
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _joiningDateController.text = _selectedDate.toIso8601String();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Employee Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextFields for editing each field
                Text(
                  "Company name",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                buildTextFieldWithIcon(
                  controller: _companyNameController,
                  hintText: 'Company name',
                  icon: Icons.work,
                ),
                SizedBox(height: 20),
                Text(
                  "Enter first name",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),

                buildTextFieldWithIcon(
                  controller: _firstNameController,
                  hintText: 'Enter first name',
                  icon: Icons.person,
                ),
                SizedBox(height: 20),
                Text(
                  "Last name",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),

                buildTextFieldWithIcon(
                  controller: _lastNameController,
                  hintText: 'Enter last name',
                  icon: Icons.person,
                ),
                SizedBox(height: 20),
                Text(
                  "Email",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),

                buildTextFieldWithIcon(
                  controller: _emailController,
                  hintText: 'Enter email',
                  icon: Icons.email,
                ),
                SizedBox(height: 20),
                Text(
                  "Phone number",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),

                buildTextFieldWithIcon(
                  controller: _phoneController,
                  hintText: 'Enter phone number',
                  icon: Icons.phone,
                ),
                SizedBox(height: 20),
                Text(
                  "Job type",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),

                buildTextFieldWithIcon(
                  controller: _jobTypeController,
                  hintText: 'Job type',
                  icon: Icons.work,
                ),
                SizedBox(height: 20),
                Text(
                  "Joining Date",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _joiningDateController,
                          decoration: InputDecoration(
                            hintText: 'Joining Date',
                            prefixIcon: IconButton(
                              icon: Icon(Icons.date_range),
                              onPressed: _selectDate,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                SizedBox(
                  width: size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _updateEmployeeProfile,
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 121, 91, 3),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
