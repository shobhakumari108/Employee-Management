class AttendanceData {
  String? employeeID;
  String? clockInDateTime;
  String? clockOutDateTime;
  String? geolocationTracking;
  String? status;
  String? photo;
  String? attendenceDate;

  AttendanceData(
      {this.employeeID,
      this.clockInDateTime,
      this.clockOutDateTime,
      this.geolocationTracking,
      this.status,
      this.photo,
      this.attendenceDate});

  AttendanceData.fromJson(Map<String, dynamic> json) {
    employeeID = json['EmployeeID'];
    clockInDateTime = json['ClockInDateTime'];
    clockOutDateTime = json['ClockOutDateTime'];
    geolocationTracking = json['GeolocationTracking'];
    status = json['Status'];
    photo = json['Photo'];
    attendenceDate = json['attendenceDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeID'] = this.employeeID;
    data['ClockInDateTime'] = this.clockInDateTime;
    data['ClockOutDateTime'] = this.clockOutDateTime;
    data['GeolocationTracking'] = this.geolocationTracking;
    data['Status'] = this.status;
    data['Photo'] = this.photo;
    data['attendenceDate'] = this.attendenceDate;
    return data;
  }
}
