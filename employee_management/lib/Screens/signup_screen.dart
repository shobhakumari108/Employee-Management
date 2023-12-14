import 'package:employee_management/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _employerNameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _employeeIdController = TextEditingController();
  TextEditingController _countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Sign Up'),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60),
                Center(
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: Material(
                      borderRadius: BorderRadius.circular(60),
                      elevation: 10,
                      child: Icon(
                        Icons.person,
                        size: 50, // Adjust the icon size as needed
                        color: Color.fromARGB(
                            255, 121, 91, 3), // Set the icon color as needed
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                buildTextFieldWithIcon(
                  controller: _companyNameController,
                  hintText: 'Company Name',
                  icon: Icons.business,
                ),
                SizedBox(height: 20),
                buildTextFieldWithIcon(
                  controller: _employerNameController,
                  hintText: 'Employer Name',
                  icon: Icons.person,
                ),
                SizedBox(height: 20),
                buildTextFieldWithIcon(
                  controller: _mobileNumberController,
                  hintText: 'Mobile Number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20),
                buildTextFieldWithIcon(
                  controller: _employeeIdController,
                  hintText: 'Employee ID',
                  icon: Icons.format_list_numbered,
                ),
                SizedBox(height: 20),
                buildTextFieldWithIcon(
                  controller: _countryController,
                  hintText: 'Country',
                  icon: Icons.location_on,
                ),
                SizedBox(height: 60),
                SizedBox(
                    width: size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 121, 91, 3),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildTextFieldWithIcon({
  //   required TextEditingController controller,
  //   required String hintText,
  //   required IconData icon,
  //   TextInputType? keyboardType,
  // }) {
  //   return Container(
  //     height: 50,
  //     child: TextField(
  //       controller: controller,
  //       keyboardType: keyboardType,
  //       decoration: InputDecoration(
  //         hintText: hintText,
  //         prefixIcon: Icon(icon),
  //         border: OutlineInputBorder(),
  //       ),
  //     ),
  //   );
  // }
}
