import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resturant/api/api.dart';
import 'package:resturant/models/auth/change_password_model.dart';

class ChangePasswordService {
  ChangePasswordService();
  final String apiUrl = Api.baseUrl;

  Future<ChangePasswordResponseModel> changePassword(
      ChangePasswordRequestModel request) async {
    final response = await http.post(
      Uri.parse('${apiUrl}change-password/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );
  print ( response.body);
  print(response.statusCode);

    if (response.statusCode == 200) {
      return ChangePasswordResponseModel.fromJson(json.decode(response.body));
    } else {
      return ChangePasswordResponseModel(
        error: 'Failed to change password. Please try again.',
      );
    }
  }
}
