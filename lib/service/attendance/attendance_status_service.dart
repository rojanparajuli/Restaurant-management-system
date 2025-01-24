import 'dart:convert';
import 'package:resturant/api/api.dart';
import 'package:resturant/bloc/auth/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:resturant/models/attendance/attendance_status_model.dart';

class AttendanceStatusService {
  final String baseurl = Api.baseUrl;
  final AuthBloc authBloc;

  AttendanceStatusService({required this.authBloc});

  Future<AttendanceStatusGetModel?> getAttendanceStatus() async {
    try {
      final token = await authBloc.getKey();

      
      final response = await http.get(
        Uri.parse('${baseurl}attendance/attendance/status/'),
        headers: {
          'Authorization': 'Token $token', 
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return AttendanceStatusGetModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print('An error occurred: $e');
      return null;
    }
  }
}
