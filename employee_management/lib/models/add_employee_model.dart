class Employee {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? profilePicture;
  String? jobType;
  String? joiningDate;
  String? companyName;

  Employee(
      {this.sId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.profilePicture,
      this.jobType,
      this.joiningDate,
      this.companyName});

  Employee.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['Email'] = email;
    data['PhoneNumber'] = phoneNumber;
    data['ProfilePicture'] = profilePicture;
    data['jobType'] = jobType;
    data['joiningDate'] = joiningDate;
    data['companyName'] = companyName;
    return data;
  }
}
