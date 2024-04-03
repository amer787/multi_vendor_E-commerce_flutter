import 'package:http/http.dart' as http;
import 'dart:convert';


class AdminService {
  final String _baseUrl = "http://localhost:4000/api/admin";



/************************************** 
 * @desc    Get All Users Profiles
 * @route   /api/admin/profile
 * @method  GET
 * @access  private (only admin)
 ***************************************/
     
    Future<List>? getAllUsersProfile(String token) async {
     List? body;
    try {
      http.Response response = await http.get(
        Uri.parse('$_baseUrl/profile/users'),
        headers: {
          'Authorization': 'Bearer $token',
    }
      );
      if (response.statusCode == 200) {
        body = jsonDecode(response.body);
        
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
    return body!;
    }

/************************************** 
 * @desc    Get All trusted User Profiles
 * @route   /api/admin/profile/userTrust
 * @method  GET
 * @access  private (only admin)
 ***************************************/ 
    Future<List>? getAllTrustedUserProfile(String token) async {
     List? body;
    try {
      http.Response response = await http.get(
        Uri.parse('$_baseUrl/profile/usersTrust'),
        headers: {
          'Authorization': 'Bearer $token',
    }
      );
      if (response.statusCode == 200) {
        body = jsonDecode(response.body);
        
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
    return body!;
    }

/************************************** 
 * @desc    Get All Admin Profiles
 * @route   /api/admin/profile/admin
 * @method  GET
 * @access  private (only admin)
 ***************************************/

    Future<List>? getAllAdminsProfile(String token) async {
     List? body;
    try {
      http.Response response = await http.get(
        Uri.parse('$_baseUrl/profile/admins'),
        headers: {
          'Authorization': 'Bearer $token',
    }
      );
      if (response.statusCode == 200) {
        body = jsonDecode(response.body);
        
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
    return body!;
    }

   



}