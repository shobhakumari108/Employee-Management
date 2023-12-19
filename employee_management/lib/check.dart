import 'package:flutter/material.dart';

class Attendance {
  final String id;
  final String employeeId;
  final DateTime clockInDateTime;
  final DateTime clockOutDateTime;
  final List<Map<String, dynamic>> geolocationTracking;
  String status;
  final String photo;

  Attendance({
    required this.id,
    required this.employeeId,
    required this.clockInDateTime,
    required this.clockOutDateTime,
    required this.geolocationTracking,
    required this.status,
    required this.photo,
  });
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AttendanceScreen(),
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Attendance> attendanceList = [
    Attendance(
      id: '1',
      employeeId: 'E001',
      clockInDateTime: DateTime.parse('2023-12-25T08:00:00.000Z'),
      clockOutDateTime: DateTime.parse('2023-12-25T17:00:00.000Z'),
      geolocationTracking: [
        {
          "location": {"type": "Point", "coordinates": [-122.4194, 37.7749]},
          "timestamp": "2023-12-25T08:00:00.000Z",
          "_id": "657c0f6218ad11e2cb61e143"
        }
      ],
      status: 'Present',
      photo: 'photo_url_here',
    ),
    Attendance(
      id: '2',
      employeeId: 'E002',
      clockInDateTime: DateTime.parse('2023-12-25T08:00:00.000Z'),
      clockOutDateTime: DateTime.parse('2023-12-25T17:00:00.000Z'),
      geolocationTracking: [
        {
          "location": {"type": "Point", "coordinates": [-122.4194, 37.7749]},
          "timestamp": "2023-12-25T08:00:00.000Z",
          "_id": "657c106518ad11e2cb61e157"
        }
      ],
      status: 'Present',
      photo: 'photo_url_here',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance App'),
      ),
      body: ListView.builder(
        itemCount: attendanceList.length,
        itemBuilder: (context, index) {
          final attendance = attendanceList[index];

          return ListTile(
            title: Text('Employee ID: ${attendance.employeeId}'),
            subtitle: Text('Clock In: ${attendance.clockInDateTime}'),
            trailing: DropdownButton<String>(
              value: attendance.status,
              onChanged: (String? newValue) {
                setState(() {
                  attendance.status = newValue!;
                });
              },
              items: <String>['Present', 'Absent', 'Leave']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}




// import 'dart:convert';
// import 'package:employee_management/models/add_employee_model.dart';
// import 'package:http/http.dart' as http;

// class EmployeeService {
//   static const String baseUrl = "http://127.0.0.1:2000/app/employee";
//   static const String getEmployeeUrl = "$baseUrl/getEmployee";
//   static const String addEmployeeUrl = "$baseUrl/addEmployee";

//   static Future<List<Employee>> getEmployees() async {
//     try {
//       final response = await http.get(Uri.parse(getEmployeeUrl));

//       if (response.statusCode == 200) {
//         final dynamic responseData = jsonDecode(response.body);

//         // Check if the response data is not null and is a Map
//         if (responseData != null && responseData is Map<String, dynamic>) {
//           final List<dynamic>? data = responseData['data'];

//           // Check if 'data' key exists and is not null
//           if (data != null) {
//             return data.map((e) => Employee.fromJson(e)).toList();
//           } else {
//             throw Exception(
//                 'Invalid response format: Missing or null "data" key');
//           }
//         } else {
//           throw Exception(
//               'Invalid response format: Expected a Map, but got ${responseData.runtimeType}');
//         }
//       } else {
//         throw Exception('Failed to load employees: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       // Print or log the error
//       print("Error in getEmployees: $e");
//       throw e; // Re-throw the error to propagate it to the calling code
//     }
//   }

//   static Future<bool> addEmployee(Employee employee) async {
//     try {
//       var headers = {'Content-Type': 'application/json'};
//       var response = await http.post(
//         Uri.parse(addEmployeeUrl),
//         headers: headers,
//         body: jsonEncode(employee.toJson()),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         print(response.body);
//         return true;
//       } else {
//         print(response.reasonPhrase);
//         return false;
//       }
//     } catch (e) {
//       // Print or log the error
//       print("Error in addEmployee: $e");
//       throw e; // Re-throw the error to propagate it to the calling code
//     }
//   }

//   static Future<bool> updateEmployee(Employee employee) async {
//     try {
//       // Construct the dynamic URL for updating a specific employee
//       String updateEmployeeUrl = "$baseUrl/updateEmployee/${employee.sId}";

//       var headers = {'Content-Type': 'application/json'};
//       var response = await http.put(
//         Uri.parse(updateEmployeeUrl),
//         headers: headers,
//         body: jsonEncode(employee.toJson()),
//       );

//       if (response.statusCode == 200) {
//         print(response.body);

//         print("Prfile updated");
//         return true;
//       } else {
//         print(response.reasonPhrase);
//         return false;
//       }
//     } catch (e) {
//       // Print or log the error
//       print("Error in updateEmployee: $e");
//       throw e; // Re-throw the error to propagate it to the calling code
//     }
//   }

//   // You can add more methods for different API operations as needed
// }
