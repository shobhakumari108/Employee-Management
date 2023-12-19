import 'dart:convert';
import 'dart:io';

import 'package:employee_management/service/At_employee_medle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:employee_management/models/add_employee_model.dart';
import 'package:employee_management/Screens/at_employee_list_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class MarkAttendanceScreen extends StatefulWidget {
  final Employee employee;

  const MarkAttendanceScreen({Key? key, required this.employee})
      : super(key: key);

  @override
  _MarkAttendanceScreenState createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  String attendanceStatus = 'Present';
  Position? currentLocation;
  DateTime selectedDate = DateTime.now();
  String? _selectedPhoto;
  AttendanceData? _attendanceData;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        currentLocation = position;
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        print("Location permissions are still denied.");
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
      setState(() {
        currentLocation = position;
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _submitAttendance() async {
  try {
    // Ensure that _selectedPhoto is not null before proceeding
    if (_selectedPhoto == null) {
      Fluttertoast.showToast(msg: 'Please select a photo.');
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.29.135:2000/app/attendence/addAttendence'),
    );

    request.fields.addAll({
      "employeeId": widget.employee.sId!,
      "clockInDateTime": selectedDate.toUtc().toIso8601String(),
      "clockOutDateTime": selectedDate.toUtc().toIso8601String(),
      "geolocationTracking":
          "${currentLocation?.latitude},${currentLocation?.longitude}",
      "status": attendanceStatus.toLowerCase(),
      "attendenceDate": selectedDate.toUtc().toIso8601String(),
    });

    // Add the photo as a file
    request.files.add(await http.MultipartFile.fromPath(
      'photo',
      _selectedPhoto!,
    ));

    // Print the data being sent to the server
    print('Data to be sent to the server: ${request.fields}');
    print('Selected Photo: $_selectedPhoto');
    print('Current Location: ${currentLocation?.latitude}, ${currentLocation?.longitude}');

    var response = await request.send();

    if (response.statusCode == 201) {
      print('Attendance submitted successfully!');
      Fluttertoast.showToast(msg: 'Attendance submitted successfully!');
    } else {
      print(
          'Failed to submit attendance. Status code: ${response.statusCode} ${response.reasonPhrase} ');
      Fluttertoast.showToast(
        msg: 'Failed to submit attendance. Please try again.',
      );
    }
  } catch (e) {
    print('Error submitting attendance: $e');
    Fluttertoast.showToast(
      msg: 'Error submitting attendance. Please try again.$e',
    );
  }
}


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
      print('Error picking image: $e');
      Fluttertoast.showToast(msg: 'Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Mark Attendance'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => AtEmployeeScreen(),
              ),
              (route) => false,
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text(
                    'Select Date',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Selected Date: ${selectedDate.toLocal()}',
                  style: TextStyle(fontSize: 16),
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(widget.employee.ProfilePicture ?? ''),
                    ),
                    title: Text(
                        '${widget.employee.FirstName} ${widget.employee.LastName}'),
                    subtitle: Text('Email: ${widget.employee.Email}'),
                    trailing: Text(
                      attendanceStatus,
                      style: TextStyle(
                        color: attendanceStatus == 'Present'
                            ? Colors.green
                            : attendanceStatus == 'Absent'
                                ? Colors.red
                                : Colors.cyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Attendance Status:',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width / 4,
                      child: ElevatedButton(
                        onPressed: () {
                          _updateAttendanceStatus('Present');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          primary: attendanceStatus == 'Present'
                              ? Colors.green
                              : Colors.white,
                        ),
                        child: Text(
                          'Present',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width / 4,
                      child: ElevatedButton(
                        onPressed: () {
                          _updateAttendanceStatus('Absent');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          primary: attendanceStatus == 'Absent'
                              ? Colors.red
                              : Colors.white,
                        ),
                        child: Text(
                          'Absent',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width / 4,
                      child: ElevatedButton(
                        onPressed: () {
                          _updateAttendanceStatus('Leave');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          primary: attendanceStatus == 'Leave'
                              ? Colors.cyan
                              : Colors.white,
                        ),
                        child: Text(
                          'Leave',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 170,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (currentLocation != null)
                            Container(
                              width: size.width / 2 - 30,
                              height: 100,
                              decoration: BoxDecoration(),
                              child: Center(
                                child: Text(
                                  'Current Location: ${currentLocation!.latitude}, ${currentLocation!.longitude}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ElevatedButton(
                            onPressed: () {
                              getCurrentPosition();
                            },
                            style: ElevatedButton.styleFrom(),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.black87,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 170,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_selectedPhoto != null)
                            Image.file(
                              File(_selectedPhoto!),
                              width: size.width / 2 - 30,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ElevatedButton(
                            onPressed: () {
                              _pickImage(ImageSource.camera);
                            },
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.black87,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 200),
                SizedBox(
                  width: size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _submitAttendance();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 121, 91, 3),
                    ),
                    child: Text(
                      'Submit Attendance',
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

  void _updateAttendanceStatus(String status) {
    setState(() {
      attendanceStatus = status;
    });
  }
}
