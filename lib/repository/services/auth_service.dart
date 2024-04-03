import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/user_model.dart';

class AuthService {
  final String _baseUrl = "http://localhost:4000/api/auth";

   Future<UserModel?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return UserModel.fromJson(responseData['user']);
      } else {
        final responseData = jsonDecode(response.body);
        // Check if errors are sent as an array and join them, or default to a generic message
        final errorMessage = responseData['errors'] is List
            ? responseData['errors'].join('\n')
            : responseData['message'] ?? 'An error occurred during login.';
        throw Exception(errorMessage);
      }
    } on http.ClientException {
      throw Exception('Network error: Failed to login.');
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }


  
Future<UserModel?> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        final responseData = jsonDecode(response.body);
        // Check if errors are sent as an array and join them, or default to a generic message
        final errorMessage = responseData['errors'] is List
            ? responseData['errors'].join('\n')
            : responseData['message'] ?? 'An error occurred during registration.';
        throw Exception(errorMessage);
      }
    } on http.ClientException {
      throw Exception('Network error: Failed to register.');
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

}
