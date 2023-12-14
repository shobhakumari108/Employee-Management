// auth_service.dart
import 'dart:convert';
import 'package:employee_management/models/user_login_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String apiUrl = "http://192.168.29.135:2000/app/users/login";

  static Future<UserLogin?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'Email': email, 'Password': password}),
    );

    if (response.statusCode == 200) {
      return UserLogin.fromJson(jsonDecode(response.body));
    } else {
      print("Error ${response.statusCode}: ${response.reasonPhrase}");
      print("Response Body: ${response.body}");
      return null;
    }
  }
}
