import 'package:http/http.dart' as http;
import 'package:resturant/api/api.dart';
import 'package:resturant/bloc/auth/auth_bloc.dart';

class DeleteUserService {
  final String baseUrl = Api.baseUrl;
  final AuthBloc authBloc;
  DeleteUserService({required this.authBloc});

  Future<String> deleteUser(int id) async {
    final token = await authBloc.getKey();
    print('token is $token');
    try {
      final response =
          await http.delete(Uri.parse('${baseUrl}auth/users/$id/'), headers: {
        'Authorization': 'token $token',
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 204) {
        return 'User deleted successfully';
      } else {
        return 'Failed to delete user: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Error occurred while deleting user: $e';
    }
  }
}
