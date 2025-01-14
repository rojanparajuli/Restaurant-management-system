import 'package:http/http.dart' as http;
import 'package:resturant/api/api.dart';
import 'dart:convert';

import 'package:resturant/models/auth_model.dart';

class AuthService {

  Future<LoginResponseModel?> login(LoginRequestModel request) async {
    final response = await http.post(
      Uri.parse('${Api.baseUrl}auth/login/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    }
    return null;
  }

  Future<ForgetPasswordResponseModel?> forgetPassword(
      ForgetPasswordRequestModel request) async {
    final response = await http.post(
      Uri.parse('${Api.baseUrl}auth/forget-password/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return ForgetPasswordResponseModel.fromJson(json.decode(response.body));
    }
    return null;
  }
}

