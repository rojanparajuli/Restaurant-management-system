import 'dart:convert';
import 'dart:io';
import 'package:resturant/api/api.dart';
import 'package:resturant/models/employee/add_employee_model.dart';
import 'package:http/http.dart' as http;

class AddEmployeeService {
  final String baseUrl = Api.baseUrl;

  Future<AddEmployeeResponseModel> createUsersList(
      AddEmployeeRequestModel model, File profilePicture, File citizenImage) async {
    print('Requested to create employee...');
      final Uri url = Uri.parse('${baseUrl}auth/register/');


    try {

      // form data

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
       final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath(
      'image', // field name should match the API's expected field name
      profilePicture.path,
    ));
    request.files.add(await http.MultipartFile.fromPath(
      'citizenship_image', // field name should match the API's expected field name
      citizenImage.path,
    ));
    request.fields.addAll(formData);
    request.headers.addAll({
      "Content-Type": "multipart/form-data", // Ensure proper encoding
    });

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

