// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:employee_management/Screens/Employee_screen.dart';
import 'package:employee_management/Screens/employee_profile_screen.dart';
import 'package:employee_management/service/add_employee_service.dart';
import 'package:employee_management/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:employee_management/models/add_employee_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

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

  String? _selectedPhoto; // Added variable for the selected photo

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

    // Set the selected photo
    _selectedPhoto = widget.employee.ProfilePicture;
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
      ProfilePicture: _selectedPhoto ?? widget.employee.ProfilePicture,
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
            employee: updatedEmployee,
          ),
        ),
        (route) => false,
      );
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

  // Function to pick an image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        // Crop the selected image
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path!,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9,
          ],
        );

        if (croppedFile != null) {
          setState(() {
            _selectedPhoto = croppedFile.path;
          });
        }
      }
    } on Exception catch (e) {
      // Handle exceptions, e.g., if the user denies camera or gallery access
      print('Error picking image: $e');
      Fluttertoast.showToast(msg: 'Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:const Text('Edit Employee Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Photo selection
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading:const Icon(Icons.camera),
                              title:const Text('Take a photo'),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.camera);
                              },
                            ),
                            ListTile(
                              leading:const Icon(Icons.photo),
                              title:const Text('Choose from gallery'),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.gallery);
                              },
                            ),
                            if (_selectedPhoto != null &&
                                _selectedPhoto!.isNotEmpty)
                              ListTile(
                                leading:const Icon(Icons.delete),
                                title:const Text('Remove photo'),
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _selectedPhoto = null;
                                  });
                                },
                              ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(60),
                          image: _selectedPhoto != null &&
                                  _selectedPhoto!.isNotEmpty
                              ? DecorationImage(
                                  image: FileImage(File(_selectedPhoto!)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _selectedPhoto == null || _selectedPhoto!.isEmpty
                            ? Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Colors.grey[600],
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
               const SizedBox(height: 20),
                // Other text fields
               const Text(
                  "Company name",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              const  SizedBox(
                  height: 10,
                ),
                buildTextFieldWithIcon(
                  controller: _companyNameController,
                  hintText: 'Company name',
                  icon: Icons.work,
                ),
              const  SizedBox(height: 20),
              const  Text(
                  "Enter first name",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              const  SizedBox(
                  height: 10,
                ),
                buildTextFieldWithIcon(
                  controller: _firstNameController,
                  hintText: 'Enter first name',
                  icon: Icons.person,
                ),
                SizedBox(height: 20),
              const  Text(
                  "Last name",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
               const SizedBox(
                  height: 10,
                ),
                buildTextFieldWithIcon(
                  controller: _lastNameController,
                  hintText: 'Enter last name',
                  icon: Icons.person,
                ),
               const SizedBox(height: 20),
               const Text(
                  "Email",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              const  SizedBox(
                  height: 10,
                ),
                buildTextFieldWithIcon(
                  controller: _emailController,
                  hintText: 'Enter email',
                  icon: Icons.email,
                ),
               const SizedBox(height: 20),
               const Text(
                  "Phone number",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
               const SizedBox(
                  height: 10,
                ),
                buildTextFieldWithIcon(
                  controller: _phoneController,
                  hintText: 'Enter phone number',
                  icon: Icons.phone,
                ),
               const SizedBox(height: 20),
              const  Text(
                  "Job type",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              const  SizedBox(
                  height: 10,
                ),
                buildTextFieldWithIcon(
                  controller: _jobTypeController,
                  hintText: 'Job type',
                  icon: Icons.work,
                ),
              const  SizedBox(height: 20),
              const  Text(
                  "Joining Date",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              const  SizedBox(
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
                              icon:const Icon(Icons.date_range),
                              onPressed: _selectDate,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const  SizedBox(height: 20),
                // Save button
                SizedBox(
                  width: size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _updateEmployeeProfile,
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 121, 91, 3),
                    ),
                    child:const Text(
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
