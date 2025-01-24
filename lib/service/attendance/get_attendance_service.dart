import 'dart:convert';

import 'package:resturant/api/api.dart';
import 'package:resturant/bloc/auth/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:resturant/models/attendance/attendance_list_model.dart';

class GetAttendanceService {
  final String baseUrl = Api.baseUrl;
  final AuthBloc authBloc;

  GetAttendanceService({required this.authBloc});

  Future<AttendanceListModel?> getAttendance() async {
    final token = await authBloc.getKey();
    // if (token == null || token.isEmpty) {
    //   return 'Error: Invalid or missing token';
    // }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/attendance/attendance/'),
        headers: {
          'Authorization': 'token $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AttendanceListModel.fromJson(data);
        
      } else {
        return null;
      }
    } catch (e) {
      print('An error occurred: $e');
      return null;
    }
  }
}
