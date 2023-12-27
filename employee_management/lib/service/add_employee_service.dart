import 'dart:convert';
import 'dart:io';
import 'package:employee_management/models/add_employee_model.dart';
import 'package:http/http.dart' as http;

class EmployeeService {
  static const String baseUrl = "http://192.168.29.135:2000/app/employee";
  static const String getEmployeeUrl = "$baseUrl/getEmployee";
  static const String addEmployeeUrl = "$baseUrl/addEmployee";
  static const String getEmployeeByIdUrl = "$baseUrl/getEmployeeById";

  static Future<List<Employee>> getEmployees() async {
    try {
      final response = await http.get(Uri.parse(getEmployeeUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);

        if (responseData != null && responseData is Map<String, dynamic>) {
          final List<dynamic>? data = responseData['data'];

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
      print("Error in getEmployees: $e");
      throw e;
    }
  }

  static Future<bool> addEmployee(Employee employee) async {
  try {
    


// Validate phone number
if (employee.PhoneNumber != null &&
    employee.PhoneNumber!.isNotEmpty &&
    !RegExp(r'^[0-9]{10}$').hasMatch(employee.PhoneNumber!)) {
  throw Exception('Invalid phone number format');
}

    // Validate email
    if (employee.Email != null &&
        employee.Email!.isNotEmpty &&
        !RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
            .hasMatch(employee.Email!)) {
      throw Exception('Invalid email format');
    }

    // Create the HTTP request
    var request = http.MultipartRequest('POST', Uri.parse(addEmployeeUrl))
      ..fields['FirstName'] = employee.FirstName ?? ''
      ..fields['LastName'] = employee.LastName ?? ''
      ..fields['Email'] = employee.Email ?? ''
      ..fields['PhoneNumber'] = employee.PhoneNumber ?? ''
      ..fields['jobType'] = employee.jobType ?? ''
      ..fields['companyName'] = employee.companyName ?? ''
      ..fields['joiningDate'] = employee.joiningDate ?? '';

    // Add profile picture if available
    if (employee.ProfilePicture != null &&
        employee.ProfilePicture!.isNotEmpty) {
      var file = File(employee.ProfilePicture!);
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();

      var multipartFile = http.MultipartFile('ProfilePicture', stream, length,
          filename: file.path.split("/").last);

      request.files.add(multipartFile);
    }

    // Send the HTTP request
    var response = await http.Response.fromStream(await request.send());

    // Check the response status
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  } catch (e) {
    print("Error in addEmployee: $e");
    throw e;
  }
}


  static Future<bool> updateEmployee(Employee employee) async {
    try {
      String updateEmployeeUrl = "$baseUrl/updateEmployee/${employee.sId}";

      var request = http.MultipartRequest('PUT', Uri.parse(updateEmployeeUrl))
        ..fields['FirstName'] = employee.FirstName ?? ''
        ..fields['LastName'] = employee.LastName ?? ''
        ..fields['Email'] = employee.Email ?? ''
        ..fields['PhoneNumber'] = employee.PhoneNumber ?? ''
        ..fields['jobType'] = employee.jobType ?? ''
        ..fields['companyName'] = employee.companyName ?? ''
        ..fields['joiningDate'] = employee.joiningDate ?? '';

      if (employee.ProfilePicture != null &&
          employee.ProfilePicture!.isNotEmpty) {
        var file = File(employee.ProfilePicture!);
        var stream = http.ByteStream(file.openRead());
        var length = await file.length();

        var multipartFile = http.MultipartFile('ProfilePicture', stream, length,
            filename: file.path.split("/").last);

        request.files.add(multipartFile);
      }

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print(response.body);
        print("Profile updated");
        return true;
      } else {
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      print("Error in updateEmployee: $e");
      throw e;
    }
  }

  static Future<Employee?> getEmployeeById(Employee employee) async {
    try {
      String getEmployeeUrl = "$getEmployeeByIdUrl/${employee.sId}";

      final response = await http.get(Uri.parse(getEmployeeUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);

        if (responseData != null && responseData is Map<String, dynamic>) {
          final Map<String, dynamic>? data = responseData['data'];

          if (data != null) {
            return Employee.fromJson(data);
          } else {
            throw Exception(
                'Invalid response format: Missing or null "data" key');
          }
        } else {
          throw Exception(
              'Invalid response format: Expected a Map, but got ${responseData.runtimeType}');
        }
      } else {
        print('Failed to load employee: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Error in getEmployeeById: $e');
      return null;
    }
  }
}
