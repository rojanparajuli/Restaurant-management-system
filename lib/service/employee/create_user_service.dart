import 'dart:convert';

import 'package:resturant/api/api.dart';
import 'package:resturant/models/employee/add_employee_model.dart';
import 'package:http/http.dart' as http;

class CreateUserService {
  final String baseUrl = Api.baseUrl;

  Future<AddEmployeeResponseModel> createUsersList(AddEmployeeRequestModel request)async{
    final response =  await http.post(
      Uri(path: '${baseUrl}auth/regester/'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      return AddEmployeeResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }
}