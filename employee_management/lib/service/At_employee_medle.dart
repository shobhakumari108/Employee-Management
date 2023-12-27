class AttendanceData {
  String? clockInDateTime;
  String? geolocationTracking;
  String? status;
  String? photo;
  String? attendenceDate;
  String? sId;

  AttendanceData(
      {this.clockInDateTime,
      this.geolocationTracking,
      this.status,
      this.photo,
      this.attendenceDate,
      this.sId});

  AttendanceData.fromJson(Map<String, dynamic> json) {
    clockInDateTime = json['ClockInDateTime'];
    geolocationTracking = json['GeolocationTracking'];
    status = json['Status'];
    photo = json['Photo'];
    attendenceDate = json['attendenceDate'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClockInDateTime'] = this.clockInDateTime;
    data['GeolocationTracking'] = this.geolocationTracking;
    data['Status'] = this.status;
    data['Photo'] = this.photo;
    data['attendenceDate'] = this.attendenceDate;
    data['_id'] = this.sId;
    return data;
  }
}
