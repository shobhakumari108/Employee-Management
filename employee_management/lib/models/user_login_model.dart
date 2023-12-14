class UserLogin {
  String? email;
  String? password;
  String? sId;

  UserLogin({this.email, this.password, this.sId});

  UserLogin.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      email = json['Email'];
      password = json['Password'];
      sId = json['_id'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Email'] = email;
    data['Password'] = password;
    data['_id'] = sId;
    return data;
  }
}