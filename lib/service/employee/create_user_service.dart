import 'dart:convert';
import 'dart:io';
import 'package:resturant/api/api.dart';
import 'package:resturant/bloc/auth/auth_bloc.dart';
import 'package:resturant/models/employee/add_employee_model.dart';
import 'package:http/http.dart' as http;

class AddEmployeeService {
  final AuthBloc authBloc;

  AddEmployeeService({required this.authBloc});

  final String baseUrl = Api.baseUrl;

  Future<AddEmployeeResponseModel> createUsersList(
      AddEmployeeRequestModel model,
      File profilePicture,
      File citizenImage) async {
    print('Requested to create employee...');

    final token = await authBloc.getKey();

    final Uri url = Uri.parse('${baseUrl}auth/register/');

    try {
      final formData = {
        'username': model.username ?? '',
        'email': model.email ?? '',
        'password': model.password ?? '',
        'role': model.role ?? '',
        'fullname': model.fullname ?? '',
        'gender': model.gender ?? '',
        'phone_number': model.phonenumber ?? '',
        'emergency_contact': model.emergencycontact ?? '',
        'address': model.address ?? '',
        'permanent_address': model.permanentAddress ?? '',
        'marital_status': model.maritalStatus ?? '',
        'religion': model.religion ?? '',
        'father_name': model.fatherName ?? '',
        'dateofbirth': model.dateofbirth ?? '',
        'pan_card': model.pancard ?? '',
        'citizenship': model.citizenship ?? '',
        'employee_type': model.employeeType ?? '',
        'bank_name': model.bankName ?? '',
        'bank_account_number': model.bankaccountnumber ?? '',
        'blood_group': model.bloodgroup ?? '',
        'branch': model.branch ?? '',
      };

      final request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          "Authorization": "token $token",
          "Content-Type": "multipart/form-data",
        })
        ..fields.addAll(formData)
        ..files.add(await http.MultipartFile.fromPath(
          'image',
          profilePicture.path,
        ))
        ..files.add(await http.MultipartFile.fromPath(
          'citizenship_image',
          citizenImage.path,
        ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

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
