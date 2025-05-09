import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:resturant/api/api.dart';
import 'package:resturant/models/employee/user_list_model.dart';

class UserService {
  final String baseUrl = '${Api.baseUrl}auth/users/';

  Future<List<UsersList>> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((user) => UsersList.fromJson(user)).toList();
      } else {
        throw Exception('Failed to load users: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }
}

class UserEditService {
  final String baseUrl = '${Api.baseUrl}auth/users/';

  Future<UsersList> fetchUser(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$id/'),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return UsersList.fromJson(jsonData);
      } else {
        throw Exception('Failed to load user: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }

  Future<http.Response> updateUser(UsersList updatedUser) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl${updatedUser.id}/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedUser.toJson()),
      );
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to update user: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }



 Future<String> uploadProfilePicture(int userId, XFile profilePicture) async {
      final uri = Uri.parse('$baseUrl$userId/');
      final request = http.MultipartRequest('PATCH', uri)
        ..fields['userId'] = userId.toString()
        ..files.add(await http.MultipartFile.fromPath(
          'image',
          profilePicture.path,
        ));

      final response = await request.send();
        print(response.statusCode);
        print(response.reasonPhrase);
        print(response.stream.bytesToString());
      if (response.statusCode == 200) {
        return 'Image uploaded successfully';
      } else {
        throw Exception('Failed to upload profile picture: ${response.reasonPhrase}');
      }
  }

  Future<String> uploadCitizenshipImage(int userId, XFile citizenshipImage) async {
    try {
      final uri = Uri.parse('$baseUrl$userId/');
      final request = http.MultipartRequest('PATCH', uri)
        ..fields['userId'] = userId.toString()
        ..files.add(await http.MultipartFile.fromPath(
          'citizenship_image',
          citizenshipImage.path,
        ));

      final response = await request.send();
        print(response.statusCode);
        print(response.reasonPhrase);
        print(response.stream.bytesToString());
      if (response.statusCode == 200) {
        return 'Citizenship image uploaded successfully';
      } else {
        throw Exception('Failed to upload citizenship image: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error uploading citizenship image: $e');
    }
  }
}

