import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resturant/api/api.dart';
import 'package:resturant/models/contact/create_contact_model.dart';

class ContactService {
  final String baseUrl = Api.baseUrl;


  Future<CreateContactResponseModel> createContact(
      CreateContactModel contact) async {
    final response = await http.post(
      Uri.parse('${baseUrl}contact/create'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(contact.toJson()),
    );

    if (response.statusCode == 201) {
      return CreateContactResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create contact');
    }
  }
}
