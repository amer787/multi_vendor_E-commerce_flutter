import 'package:first_store_nodejs_flutter/models/user_model.dart';
import 'package:flutter/material.dart';

import '../repository/services/admin_service.dart';

class AdminViewModel extends ChangeNotifier {
  final AdminService _adminService = AdminService();
  final List<UserModel> _users = [];

  // UsersCount 
  int _usersCount = 15;
  int get usersCount => _usersCount;

  // TrustUsersCount
  int _trustUsersCount = 2;
  int get trustUsersCount => _trustUsersCount;

  // AdminCount
  int _adminCount = 1;
  int get adminCount => _adminCount;
  
  // ProductsCount
  int _productsCount = 21;
  int get productsCount => _productsCount;
  
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;

  List<UserModel>? get users {
    return _users;
  
  }



  String get errorMessage => _errorMessage;

  void setLoading(bool loading) {
    _isLoading = loading;
   
  }

  

 

 

  Future<void> getAllUsersProfile(String token) async {
    setLoading(true);
    var result = await _adminService.getAllUsersProfile(token);
    if (result != null) {
      // Clear the list of users
      _users.clear();
      _users.addAll(result.map((e) => UserModel.fromJson(e)).toList());

      print(_users);
      setLoading(false);
      notifyListeners();
    } else {
      _errorMessage = 'Failed to load users';
      setLoading(false);
      notifyListeners();
    }
  }

    /************************************** 
 * @desc    Get All Users trust Profiles
 * @route   /api/admin/profile/userTrust
 * @method  GET
 * @access  private (only admin)
 ***************************************/ 
  Future<void> getAllTrustedUserProfile(String token) async {
    setLoading(true);
    var result = await _adminService.getAllTrustedUserProfile(token);
    if (result != null) {
      // clear the list of users
      _users.clear();
      _users.addAll(result.map((e) => UserModel.fromJson(e)).toList());

      print(_users);
      setLoading(false);
      notifyListeners();
    } else {
      _errorMessage = 'Failed to load users';
      setLoading(false);
      notifyListeners();
    }
  }

  /************************************** 
 * @desc    Get All Admin Profiles
 * @route   /api/admin/profile/admin
 * @method  GET
 * @access  private (only admin)
 ***************************************/

  Future<void> getAllAdminsProfile(String token) async {
    setLoading(true);
    var result = await _adminService.getAllAdminsProfile(token);
    if (result != null) {
      // clear the list of users
      _users.clear();
      _users.addAll(result.map((e) => UserModel.fromJson(e)).toList());

      print(_users);
      setLoading(false);
      notifyListeners();
    } else {
      _errorMessage = 'Failed to load users';
      setLoading(false);
      notifyListeners();
    }
  }
  
}
  
  


