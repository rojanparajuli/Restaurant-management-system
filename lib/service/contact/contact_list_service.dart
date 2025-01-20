import 'dart:convert';

import 'package:resturant/api/api.dart';
import 'package:resturant/models/contact/contact_list_model.dart';
import 'package:http/http.dart' as http;

class ContactListService {
  final String baseUrl = Api.baseUrl;

Future<List<ContactListModel>> getContactList() async {
  try {
    final response = await http.get(Uri.parse('${baseUrl}contact/list'));
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ContactListModel.fromJson(json)).toList();
    } else {
      print('Error: Failed to load contacts with status code ${response.statusCode}');
      throw Exception('Failed to load contacts');
    }
  } catch (e) {
    print('Exception: $e');
    rethrow;
  }
}
}