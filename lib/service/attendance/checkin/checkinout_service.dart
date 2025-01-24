import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resturant/api/api.dart';
import 'package:resturant/bloc/auth/auth_bloc.dart';
import 'package:resturant/models/attendance/checkin_checkout/checkin/check_in_out_model.dart';

class CheckInService {
  static const String baseUrl = Api.baseUrl;
  final AuthBloc  authBloc;

  CheckInService({required this.authBloc});

  Future<CheckInResponseModel> checkIn(CheckInRequestModel request) async {
    final token = await authBloc.getKey();
    final url = Uri.parse('${baseUrl}attendance/attendance/checkin/checkout/');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json",
      'Authorization': 'Token $token'
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return CheckInResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to check in: ${response.body}");
    }
  }
}
