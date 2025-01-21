import 'dart:io';
import 'dart:convert';
import 'package:resturant/api/api.dart';
import 'package:http/http.dart' as http;

class UserImageService {
  final String baseUrl = Api.baseUrl;

  Future<String> uploadImages(File profileImage, File citizenshipImage) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse('${baseUrl}auth/userimage'));

      request.files.add(await http.MultipartFile.fromPath('profile_image', profileImage.path));
      request.files.add(await http.MultipartFile.fromPath('citizenship_image', citizenshipImage.path));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data["message"] ?? "Images uploaded successfully.";
      } else {
        throw Exception("Failed to upload images. Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error uploading images: $e");
    }
  }
}