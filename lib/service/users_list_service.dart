import 'package:http/http.dart' as http;
import 'package:resturant/api/api.dart';
import 'package:resturant/models/user_list_model.dart';

class UserService {
  final String baseUrl = '${Api.baseUrl}auth/users/';

  Future<List<UsersList>> fetchUsers() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return usersListFromJson(response.body);
    } else {
      throw Exception('Failed to load users: ${response.reasonPhrase}');
    }
  }
}
