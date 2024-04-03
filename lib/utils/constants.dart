// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
String baseApiUrl = "http://localhost:4000/api";
String urlProducts = "http://localhost:4000/api/products";
String urlProductsCategoryPhones = "http://localhost:4000/api/products?deviceType=mobile";
String urlProductsCategoryLaptops = "http://localhost:4000/api/products?deviceType=laptop";
String urlProductsCategoryTablets = "http://localhost:4000/api/products?deviceType=tablet";
String urlUsers = "http://localhost:4000/api/users";
String urlAuth = "http://localhost:4000/api/auth";
String urlRegister = "http://localhost:4000/api/auth/register";
String urlLogin = "http://localhost:4000/api/auth/login";


int SUCCESS_CODE = 200;
int CREATED_CODE = 201;
int UPDATED_CODE = 204;
int DELETED_CODE = 204;
int BAD_REQUEST_CODE = 400;
int UNAUTHORIZED_CODE = 401;
int FORBIDDEN_CODE = 403;
int NOT_FOUND_CODE = 404;



checkDebug(var data){
  if (kDebugMode) {
    print(data);
  }
}
