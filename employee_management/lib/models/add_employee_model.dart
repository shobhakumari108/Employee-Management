class Employee {
  String? sId;
  String? FirstName; // Update field name
  String? LastName;  // Update field name
  String? Email;     // Update field name
  String? PhoneNumber;  // Update field name
  String? ProfilePicture;  // Update field name
  String? jobType;
  String? joiningDate;
  String? companyName;

  Employee({
    this.sId,
    this.FirstName,
    this.LastName,
    this.Email,
    this.PhoneNumber,
    this.ProfilePicture,
    this.jobType,
    this.joiningDate,
    this.companyName,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    FirstName = json['FirstName'];
    LastName = json['LastName'];
    Email = json['Email'];
    PhoneNumber = json['PhoneNumber'];
    ProfilePicture = json['ProfilePicture'];
    jobType = json['jobType'];
    joiningDate = json['joiningDate'];
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['FirstName'] = FirstName;
    data['LastName'] = LastName;
    data['Email'] = Email;
    data['PhoneNumber'] = PhoneNumber;
    data['ProfilePicture'] = ProfilePicture;
    data['jobType'] = jobType;
    data['joiningDate'] = joiningDate;
    data['companyName'] = companyName;
    return data;
  }
}
