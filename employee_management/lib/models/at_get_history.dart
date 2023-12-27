class GetAttendanceData {
  String? sId;
  EmployeeID? employeeID;
  String? clockInDateTime;
  String? geolocationTracking;
  String? status;
  String? photo;
  String? attendenceDate;

  GetAttendanceData(
      {this.sId,
      this.employeeID,
      this.clockInDateTime,
      this.geolocationTracking,
      this.status,
      this.photo,
      this.attendenceDate});

  GetAttendanceData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    employeeID = json['EmployeeID'] != null
        ? new EmployeeID.fromJson(json['EmployeeID'])
        : null;
    clockInDateTime = json['ClockInDateTime'];
    geolocationTracking = json['GeolocationTracking'];
    status = json['Status'];
    photo = json['Photo'];
    attendenceDate = json['attendenceDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.employeeID != null) {
      data['EmployeeID'] = this.employeeID!.toJson();
    }
    data['ClockInDateTime'] = this.clockInDateTime;
    data['GeolocationTracking'] = this.geolocationTracking;
    data['Status'] = this.status;
    data['Photo'] = this.photo;
    data['attendenceDate'] = this.attendenceDate;
    return data;
  }
}

class EmployeeID {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? profilePicture;
  String? jobType;
  String? joiningDate;
  String? companyName;

  EmployeeID(
      {this.sId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.profilePicture,
      this.jobType,
      this.joiningDate,
      this.companyName});

  EmployeeID.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
    phoneNumber = json['PhoneNumber'];
    profilePicture = json['ProfilePicture'];
    jobType = json['jobType'];
    joiningDate = json['joiningDate'];
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['Email'] = this.email;
    data['PhoneNumber'] = this.phoneNumber;
    data['ProfilePicture'] = this.profilePicture;
    data['jobType'] = this.jobType;
    data['joiningDate'] = this.joiningDate;
    data['companyName'] = this.companyName;
    return data;
  }
}
