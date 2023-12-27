import 'dart:io';
import 'package:employee_management/service/add_employee_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:employee_management/models/add_employee_model.dart';
// import 'package:employee_management/service/employee_service.dart';
import 'employee_screen.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _jobTypeController = TextEditingController();
  TextEditingController _joiningDateController = TextEditingController();

  String? _selectedPhoto;

  // Initialize date with today's date
  DateTime _selectedDate = DateTime.now();

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
        title: Text('Add Employee'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return  Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.camera),
                              title: Text('Take a photo'),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.camera);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.photo),
                              title: Text('Choose from gallery'),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(60),
                      image:
                          _selectedPhoto != null && _selectedPhoto!.isNotEmpty
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
                ),
               const SizedBox(height: 20),
                buildTextFieldWithIcon(
                  controller: _companyNameController,
                  hintText: 'Company name',
                  icon: Icons.work,
                ),
               const SizedBox(height: 20),
                buildTextFieldWithIcon(
                  controller: _firstNameController,
                  hintText: 'Enter first name',
                  icon: Icons.person,
                ),
              const  SizedBox(height: 20),
                buildTextFieldWithIcon(
                  controller: _lastNameController,
                  hintText: 'Enter last name',
                  icon: Icons.person,
                ),
               const SizedBox(height: 20),
                buildTextFieldWithIcon(
                  controller: _emailController,
                  hintText: 'Enter email',
                  icon: Icons.email,
                ),
               const SizedBox(height: 20),
                buildTextFieldWithIcon(
                  controller: _phoneController,
                  hintText: 'Enter phone number',
                  icon: Icons.phone,
                  
                ),
               const SizedBox(height: 20),
                buildTextFieldWithIcon(
                  controller: _jobTypeController,
                  hintText: 'Enter job type',
                  icon: Icons.work,
                ),
                const SizedBox(height: 20),
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
                              icon: const Icon(Icons.date_range),
                              onPressed: _selectDate,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                 const SizedBox(height: 20),
                SizedBox(
                  width: size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validate phone number
                      // Validate phone number
                      if (_phoneController.text.isNotEmpty &&
                          !RegExp(r'^[0-9]{10}$')
                              .hasMatch(_phoneController.text)) {
                        Fluttertoast.showToast(msg: 'Invalid phone number');
                        return;
                      }

                      // Validate email
                      if (_emailController.text.isNotEmpty &&
                          !RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                              .hasMatch(_emailController.text)) {
                        Fluttertoast.showToast(msg: 'Invalid email format');
                        return;
                      }

                      // Convert date to ISO 8601 format
                      String joiningDate = _selectedDate.toIso8601String();

                      final employee = Employee(
                        FirstName: _firstNameController.text,
                        LastName: _lastNameController.text,
                        Email: _emailController.text,
                        PhoneNumber: _phoneController.text,
                        jobType: _jobTypeController.text,
                        companyName: _companyNameController.text,
                        joiningDate: joiningDate,
                        ProfilePicture: _selectedPhoto ?? '',
                      );

                      print("User Data: ${employee.toJson()}");

                      // Add the employee
                      final result =
                          await EmployeeService.addEmployee(employee);

                      print("Result from addEmployee: $result");

                      if (result == true) {
                        // If the employee is added successfully
                        Fluttertoast.showToast(
                            msg: 'Employee added successfully');

                        // Navigate to EmployeeScreen and remove all previous routes
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmployeeScreen(),
                          ),
                          (route) => false,
                        );
                      } else {
                        // Handle the case where adding the employee fails
                        Fluttertoast.showToast(msg: 'Failed to add employee');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 121, 91, 3),
                    ),
                    child: const Text(
                      'Continue',
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

  Widget buildTextFieldWithIcon({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
    );
  }
}
