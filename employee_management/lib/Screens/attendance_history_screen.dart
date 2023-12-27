import 'package:employee_management/models/at_get_history.dart';
import 'package:employee_management/service/at_history_get_service.dart';
import 'package:flutter/material.dart';

class AttendanceHistoryList extends StatefulWidget {
  @override
  _AttendanceHistoryListState createState() => _AttendanceHistoryListState();
}

class _AttendanceHistoryListState extends State<AttendanceHistoryList> {
  final AttendanceService _attendanceService = AttendanceService();
  late List<GetAttendanceData> _attendanceRecords;

  @override
  void initState() {
    super.initState();
    _loadAttendanceRecords();
  }

  Future<void> _loadAttendanceRecords() async {
    try {
      // Show circular progress indicator while waiting for data
      setState(() {
        _attendanceRecords = [];
      });

      final records = await _attendanceService.getAttendanceRecords();
      setState(() {
        _attendanceRecords = records;
      });
    } catch (e) {
      print('Error loading attendance records: $e');
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'leave':
        return Colors.cyan;
      default:
        return Colors
            .black; // Add a default color or choose one based on your design
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Records'),
      ),
      body: _attendanceRecords != null
          ? ListView.builder(
              itemCount: _attendanceRecords.length,
              itemBuilder: (context, index) {
                final record = _attendanceRecords[index];
                final employee = record.employeeID;

                return ListTile(
                  title: Text(
                    '${employee?.firstName} ${employee?.lastName}',
                    // style: TextStyle(),
                  ),
                  subtitle: Text(
                    employee?.email ?? '',
                    // style: TextStyle(),
                  ),
                  trailing: Text(
                    record.status ?? '',
                    style: TextStyle(
                      color: getStatusColor(record.status ?? ''),
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(employee?.profilePicture ?? ''),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
