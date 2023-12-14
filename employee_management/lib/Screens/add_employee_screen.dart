// import 'dart:io';
// import 'package:employee_management/models/add_employee_model.dart';
// import 'package:employee_management/service/add_employee_service.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class AddEmployeeScreen extends StatefulWidget {
//   const AddEmployeeScreen({Key? key}) : super(key: key);

//   @override
//   _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
// }

// class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
//   final TextEditingController _companyNameController = TextEditingController();
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _jobTypeController = TextEditingController();
//   final TextEditingController _joiningDateController = TextEditingController();

//   String? _selectedPhoto;

//   DateTime _selectedDate = DateTime.now();

//   final EmployeeService _employeeService = EmployeeService();

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     try {
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 100);

//       if (pickedFile != null) {
//         setState(() {
//           _selectedPhoto = pickedFile.path;
//         });
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//     }
//   }

//   Future<void> _selectDate() async {
//     try {
//       final DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: _selectedDate,
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2101),
//       );

//       if (pickedDate != null && pickedDate != _selectedDate) {
//         setState(() {
//           _selectedDate = pickedDate;
//           _joiningDateController.text = _selectedDate.toString();
//         });
//       }
//     } catch (e) {
//       print('Error selecting date: $e');
//     }
//   }

//   Future<void> _addEmployee() async {
//     try {
//       final newEmployee = Employee(
//         firstName: _firstNameController.text,
//         lastName: _lastNameController.text,
//         email: _emailController.text,
//         phoneNumber: _phoneController.text,
//         profilePicture: _selectedPhoto ?? '',
//         jobType: _jobTypeController.text,
//         joiningDate: _joiningDateController.text,
//         companyName: _companyNameController.text,
//       );

//       final addedEmployee = await EmployeeService.addEmployee(newEmployee);

//       if (addedEmployee != null) {
//         // Handle the added employee object as needed
//         print('Employee added: ${addedEmployee.toJson()}');
//       } else {
//         // Handle adding employee failure
//         print('Error adding employee');
//       }
//     } catch (e) {
//       print('Error in _addEmployee: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _companyNameController.dispose();
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _jobTypeController.dispose();
//     _joiningDateController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(25.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: _pickImage,
//                   child: Container(
//                     width: 120,
//                     height: 120,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(60),
//                       image:
//                           _selectedPhoto != null && _selectedPhoto!.isNotEmpty
//                               ? DecorationImage(
//                                   image: FileImage(File(_selectedPhoto!)),
//                                   fit: BoxFit.cover,
//                                 )
//                               : null,
//                     ),
//                     child: _selectedPhoto == null || _selectedPhoto!.isEmpty
//                         ? Center(
//                             child: Icon(
//                               Icons.add_a_photo,
//                               size: 40,
//                               color: Colors.grey[600],
//                             ),
//                           )
//                         : null,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 buildTextFieldWithIcon(
//                   controller: _companyNameController,
//                   hintText: 'Company name',
//                   icon: Icons.work,
//                 ),
//                 SizedBox(height: 20),
//                 buildTextFieldWithIcon(
//                   controller: _firstNameController,
//                   hintText: 'Enter first name',
//                   icon: Icons.person,
//                 ),
//                 SizedBox(height: 20),
//                 buildTextFieldWithIcon(
//                   controller: _lastNameController,
//                   hintText: 'Enter last name',
//                   icon: Icons.person,
//                 ),
//                 SizedBox(height: 20),
//                 buildTextFieldWithIcon(
//                   controller: _emailController,
//                   hintText: 'Enter email',
//                   icon: Icons.email,
//                 ),
//                 SizedBox(height: 20),
//                 buildTextFieldWithIcon(
//                   controller: _phoneController,
//                   hintText: 'Enter phone number',
//                   icon: Icons.phone,
//                 ),
//                 SizedBox(height: 20),
//                 buildTextFieldWithIcon(
//                   controller: _jobTypeController,
//                   hintText: 'Enter job type',
//                   icon: Icons.work,
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   height: 50,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextFormField(
//                           controller: _joiningDateController,
//                           decoration: InputDecoration(
//                             hintText: 'Joining Date',
//                             prefixIcon: IconButton(
//                               icon: Icon(Icons.date_range),
//                               onPressed: _selectDate,
//                             ),
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 SizedBox(
//                   width: size.width,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: _addEmployee,
//                     style: ElevatedButton.styleFrom(
//                       primary: const Color.fromARGB(255, 121, 91, 3),
//                     ),
//                     child: Text(
//                       'Continue',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTextFieldWithIcon({
//     required TextEditingController controller,
//     required String hintText,
//     required IconData icon,
//   }) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hintText,
//         prefixIcon: Icon(icon),
//         border: OutlineInputBorder(),
//       ),
//     );
//   }
// }
