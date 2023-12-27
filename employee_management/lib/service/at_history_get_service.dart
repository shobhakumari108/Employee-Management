import 'dart:convert';
import 'package:employee_management/models/at_get_history.dart';
import 'package:http/http.dart' as http;
 // Replace with the actual file name

class AttendanceService {
  final String apiUrl = 'http://192.168.29.135:2000/app/attendence/getAttendence';

  Future<List<GetAttendanceData>> getAttendanceRecords() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200 || response.statusCode == 201) {
      
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((record) => GetAttendanceData.fromJson(record)).toList();
    } else {
      throw Exception('Failed to load attendance records');
    }
  }
}
