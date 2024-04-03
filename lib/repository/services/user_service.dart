
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../models/user_model.dart';
import 'dart:convert';

class UserService {
  final String _baseUrl = "http://localhost:4000/api/users";

   Future getUserProfile(String userId,) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/profile/$userId'),
        headers: {
          
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'data': UserModel.fromJson(data)};
      } else {
        final errorData = json.decode(response.body);
        return {'success': false, 'message': errorData['message'] ?? 'Unknown error occurred.'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to connect to the server.'};
    }
  }

  Future<Map<String, dynamic>> updateUserProfile(String userId, Map<String, dynamic> userData, String token) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/profile/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        // Assuming the backend returns the updated user data on successful update
        final data = json.decode(response.body);
        return {'success': true, 'data': data, 'message': 'Profile updated successfully'};
      } else {
        // Handle different status codes or backend-specific error messages
        final errorData = json.decode(response.body);
        return {'success': false, 'message': errorData['message'] ?? 'Unknown error occurred.'};
      }
    } catch (e) {
      // Handle any exceptions thrown during the request
      return {'success': false, 'message': 'Failed to connect to the server.'};
    }
  }

  Future<Map<String, dynamic>> uploadProfilePicture(String userId, File image, String token) async {
    try {
      var uri = Uri.parse('$_baseUrl/profile/$userId/profile-photo-upload');
      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(await http.MultipartFile.fromPath('image', image.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'message': 'Profile picture updated successfully', 'data': data};
      } else {
        final errorData = json.decode(response.body);
        return {'success': false, 'message': errorData['message'] ?? 'Failed to update profile picture.'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to connect to the server.'};
    }
  }
}