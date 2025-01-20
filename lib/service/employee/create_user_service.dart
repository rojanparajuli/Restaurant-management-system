import 'dart:convert';
import 'package:resturant/api/api.dart';
import 'package:resturant/models/employee/add_employee_model.dart';
import 'package:http/http.dart' as http;

class AddEmployeeService {
  final String baseUrl = Api.baseUrl;

  Future<AddEmployeeResponseModel> createUsersList(
      AddEmployeeRequestModel request) async {
    print('Requested to create employee...');

    try {
      final Uri url = Uri.parse('${baseUrl}auth/register/');
      print('Making POST request to: $url');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(request.toJson()),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        return AddEmployeeResponseModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to create employee. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while creating employee: $e');
      rethrow;
    }
  }
}
