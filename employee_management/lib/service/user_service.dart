import 'dart:convert';
import 'package:employee_management/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = "http://192.168.29.135:2000/app/users/addUser";

  static Future<bool> signUp(User user) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(apiUrl));
      request.body = jsonEncode(user.toJson());
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        print(await response.stream.bytesToString());
        return true; // Signup successful
      } else {
        print(response.reasonPhrase);
        return false; // Signup failed
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  // You can add a login method here if needed
}