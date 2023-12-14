// // employee_service.dart
// import 'dart:convert';

// import 'package:employee_management/models/add_employee_model.dart';
// import 'package:http/http.dart' as http;

// class EmployeeService {
//   static const String addEmployeeUrl =
//       "http://192.168.29.135:2000/app/employee/addEmployee";

//   static Future<bool> addEmployee(Employee employee) async {
//     var headers = {'Content-Type': 'application/json'};
//     var request = http.Request('POST', Uri.parse(addEmployeeUrl));
//     request.body = jsonEncode(employee.toJson());
//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//       return true;
//     } else {
//       print(response.reasonPhrase);
//       return false;
//     }
//   }
// }

import 'dart:convert';
import 'package:employee_management/models/add_employee_model.dart';
import 'package:http/http.dart' as http;

class EmployeeService {
  static const String getEmployeeUrl =
      "http://192.168.29.135:2000/app/employee/getEmployee";
  static const String addEmployeeUrl =
      "http://192.168.29.135:2000/app/employee/addEmployee";

  static Future<List<Employee>> getEmployees() async {
    try {
      final response = await http.get(Uri.parse(getEmployeeUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);

        // Check if the response data is not null and is a Map
        if (responseData != null && responseData is Map<String, dynamic>) {
          final List<dynamic>? data = responseData['data'];

          // Check if 'data' key exists and is not null
          if (data != null) {
            return data.map((e) => Employee.fromJson(e)).toList();
          } else {
            throw Exception(
                'Invalid response format: Missing or null "data" key');
          }
        } else {
          throw Exception(
              'Invalid response format: Expected a Map, but got ${responseData.runtimeType}');
        }
      } else {
        throw Exception('Failed to load employees: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Print or log the error
      print("Error in getEmployees: $e");
      throw e; // Re-throw the error to propagate it to the calling code
    }
  }

  static Future<bool> addEmployee(Employee employee) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(addEmployeeUrl));
    request.body = jsonEncode(employee.toJson());
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}
