// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:employee_management/service/At_employee_medle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:employee_management/models/add_employee_model.dart';
import 'package:employee_management/Screens/at_employee_list_screen.dart';
import 'package:geolocator/geolocator.dart';
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

      // Ensure that currentLocation is not null before proceeding
      if (currentLocation == null) {
        Fluttertoast.showToast(msg: 'Could not fetch current location.');
        return;
      }

      // Check if attendance has already been submitted for the selected date
      if (await _isAttendanceAlreadySubmitted()) {
        Fluttertoast.showToast(
            msg: 'Attendance already submitted for this date.');
        return;
      }

      // var headers = {
      //   'Authorization':
      //       'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im5rIiwidXNlclR5cGUiOiJlbXBsb3llZSIsImVtYWlsIjoibmtAZ21haWwuY29tIiwicGhvbmUiOjg4ODg2NzQ2NTAsImlhdCI6MTY5OTQ0NjIyOSwiZXhwIjoxNjk5NTMyNjI5fQ.KqkvY56rxPM9SxtahbaxXMvvFG6efStNfMk0A7gY_sc'
      // };
      print("=============${widget.employee.sId}");
      print(
          "============= ${currentLocation!.latitude},${currentLocation!.longitude}");
      print("=============${attendanceStatus.toLowerCase()}");
      var request = http.MultipartRequest('POST',
          Uri.parse('http://192.168.29.135:2000/app/attendence/addAttendence'));
      request.fields.addAll({
        "EmployeeID": widget.employee.sId!,
        'GeolocationTracking':
            "${currentLocation!.latitude},${currentLocation!.longitude}",
        'ClockInDateTime': selectedDate.toUtc().toIso8601String(),
        'Status': attendanceStatus,
        'attendenceDate': selectedDate.toUtc().toIso8601String()
      });

      request.files
          .add(await http.MultipartFile.fromPath('Photo', _selectedPhoto!));
      // request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(
            '================Attendance submitted successfully!=================');
        Fluttertoast.showToast(msg: 'Attendance submitted successfully!');
        print("==========================");
        print(await response.stream.bytesToString());
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AtEmployeeScreen()),
          (route) => false,
        );
      }
      //else if(response.statusCode == 400){
      //   print('++++++++++++: ${response.statusCode} ${response.reasonPhrase} ');
      //   Fluttertoast.showToast(msg: 'Attendance already submitted for this date');

      // }
      
      
       else {
        // print("========reason==============${response.reasonPhrase}====");
        // print("========reason==============${response.statusCode}====");
        print(
            '==============Failed to submit attendance. Status code==================: ${response.statusCode} ${response.reasonPhrase} ');
        Fluttertoast.showToast(
          msg: 'Failed to submit attendance. Please try again.',
        );
      }

      // var request = http.MultipartRequest(
      //   'POST',
      //   Uri.parse('http://192.168.29.135:2000/app/attendence/addAttendence'),
      // );

      // request.fields.addAll({
      //   "employeeId": widget.employee.sId!,
      //   "clockInDateTime": selectedDate.toUtc().toIso8601String(),
      //   "clockOutDateTime": selectedDate.toUtc().toIso8601String(),
      //   "geolocationTracking":
      //       "${currentLocation!.latitude},${currentLocation!.longitude}",
      //   "status": attendanceStatus.toLowerCase(),
      //   "attendenceDate": selectedDate.toUtc().toIso8601String(),
      // });

      // // Add the photo as a file
      // request.files.add(await http.MultipartFile.fromPath(
      //   'Photo',
      //   _selectedPhoto!,
      // ));

      // // Print the data being sent to the server
      // print('Data to be sent to the server: ${request.fields}');
      // print('Selected Photo: $_selectedPhoto');
      // print(
      //     'Current Location: ${currentLocation!.latitude}, ${currentLocation!.longitude}');

      // var response = await request.send();

      // // print('Response:$response._attendanceData');

      // if (response.statusCode == 201) {
      //   print('Attendance submitted successfully!');
      //   Fluttertoast.showToast(msg: 'Attendance submitted successfully!');
      // } else {
      //   print(
      //       'Failed to submit attendance. Status code: ${response.statusCode} ${response.reasonPhrase} ');
      //   Fluttertoast.showToast(
      //     msg: 'Failed to submit attendance. Please try again.',
      //   );
      // }
    } catch (e) {
      print('Error submitting attendance: $e');
      Fluttertoast.showToast(
        msg: 'Error submitting attendance. Please try again.$e',
      );
    }
  }

  Future<bool> _isAttendanceAlreadySubmitted() async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://192.168.29.135:2000/app/attendence/checkAttendance?employeeId=${widget.employee.sId}&attendenceDate=${selectedDate.toUtc().toIso8601String()}',
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body == 'true';
      } else {
        print(
            'Failed to check attendance status. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error checking attendance status: $e');
      return false;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        // Crop the selected image
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
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
        title: const Text('Mark Attendance'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const AtEmployeeScreen(),
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
                  child: const Text(
                    'Select Date',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Selected Date: ${selectedDate.toLocal()}',
                  style: const TextStyle(fontSize: 16),
                ),
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
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
                const Text(
                  'Attendance Status:',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
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
                        child: const Text(
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
                        child: const Text(
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
                        child: const Text(
                          'Leave',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                              decoration: const BoxDecoration(),
                              child: Center(
                                child: Text(
                                  'Current Location: ${currentLocation!.latitude}, ${currentLocation!.longitude}',
                                  style: const TextStyle(
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
                            child: const Icon(
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
                            child: const Icon(
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
                const SizedBox(height: 200),
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
                    child: const Text(
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
