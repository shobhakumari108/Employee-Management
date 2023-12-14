class User {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? sId;

  User({this.firstName, this.lastName, this.email, this.password, this.sId});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
    password = json['Password'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['Email'] = email;
    data['Password'] = password;
    data['_id'] = sId;
    return data;
  }
}
