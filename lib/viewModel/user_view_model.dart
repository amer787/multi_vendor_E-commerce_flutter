import 'dart:io';
import 'package:first_store_nodejs_flutter/viewModel/auth_view_model.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repository/services/user_service.dart';


class UserViewModel with ChangeNotifier {

  final UserService _userService = UserService();
  final AuthViewModel authViewModel = AuthViewModel();
  UserModel? _user;
  bool _isLoading = false;
String? _errorMessage;


  UserModel? get user  {
    return _user;
  }
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

 


  void setLoading(bool loading) {
    _isLoading = loading;
    
  }
 

 


  Future<void> getUserProfile(String userId) async {
    setLoading(true);
    var result = await _userService.getUserProfile(userId);
    if (result['success']) {
      var userData = result['data'];
      _user = userData;
      setLoading(false);
      notifyListeners();
    } else {
      _errorMessage = result['message'];
      setLoading(false);
      notifyListeners();
    }
  }

  Future<bool> updateUserProfile(String userId, Map<String, dynamic> userData, String token) async {
  setLoading(true);
  var result = await _userService.updateUserProfile(userId, userData, token);
  if (result['success']) {
    setLoading(false);
    notifyListeners();
    return true;
  } else {
    _errorMessage = result['message'];
    setLoading(false);
    notifyListeners();
    return false;
  }
}




 Future<bool> uploadProfilePicture(String userId, File image, String token) async {
  setLoading(true);
  var result = await _userService.uploadProfilePicture(userId, image, token);
  if (result['success']) {
     var updatedData = result['data'];
    _user = UserModel.fromJson(updatedData);
    setLoading(false);
    notifyListeners();
    return true;
  } else {
    _errorMessage = result['message'];
    setLoading(false);
    notifyListeners();
    print(result['message']); // For debug purposes
    return false;
  }
}



}


