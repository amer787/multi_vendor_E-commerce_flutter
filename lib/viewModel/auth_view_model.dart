import 'dart:convert';

import 'package:first_store_nodejs_flutter/repository/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;
   bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;





  AuthViewModel() {
     authLoadUser();

  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // save user to shared preferences
  Future<void> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(user.toJson()));
  }

  





 

  Future<void> authLoadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user_data');
    if (userJson != null) {
      try {
      
        Map<String, dynamic> userMap = jsonDecode(userJson);
        _user = UserModel.fromJson(userMap);
        notifyListeners();
      } catch (e) {
        print("Error loading user: $e");
      }
    }
  }

 



  Future<bool> login(String email, String password) async {
    try {
      setLoading(true);
      final user =await _authService.login(email, password);
      if (user != null) {
        _user = user;
        await saveUser(user);
        _errorMessage = null; 
        setLoading(false);
        return true;
      }
    } catch (e) {
      _errorMessage = e.toString();
      setLoading(false);
    }
    notifyListeners();
    return false;
  }

 Future<bool> register(String name, String email, String password) async {
  try {
    final user = await _authService.register(name, email, password);
    if (user != null) {
      _user = user;
      await saveUser(user);
      return true;
    }
  } on Exception catch (e) {
    
    _errorMessage = e.toString();
    notifyListeners();
  }
  return false;
}

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
    _user = null;
    notifyListeners();
  }



}






