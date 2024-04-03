
import 'package:first_store_nodejs_flutter/models/product_mobile.dart';
import 'package:first_store_nodejs_flutter/repository/product_repo.dart';
import 'package:first_store_nodejs_flutter/utils/constants.dart';
import 'package:http/http.dart'as http;
import 'package:http_parser/http_parser.dart';

import 'dart:convert';


class ApiProducts extends ProductRepo{


  //! get all products
  @override
  Future<List>? getAllProducts()async {
    List? body;
   try{
    http.Response response=await http.get(Uri.parse(urlProducts));
    if(response.statusCode==SUCCESS_CODE){
     
      body = jsonDecode(response.body);
      print("body Amer${response.body}"); 
      
    }
   }catch(e){
      checkDebug(e);
   }
    //  print(body!);
      return body!;
     
  }

  //! get products category phones
  @override
  Future<List>? getProductsCategoryPhones() async{
    List? body;
    try{
      http.Response response=await http.get(Uri.parse(urlProductsCategoryPhones));
      if(response.statusCode==SUCCESS_CODE){
        body=jsonDecode(response.body);
      }
    }catch(e){
      checkDebug(e);
    }
    return body!;
  }

  //! get products category tablets
  @override
  Future<List>? getProductsCategoryTablets() async{
    List? body;
    try{
      http.Response response=await http.get(Uri.parse(urlProductsCategoryTablets));
      if(response.statusCode==SUCCESS_CODE){
        body=jsonDecode(response.body);
      }
    }catch(e){
      checkDebug(e);
    }
    return body!;
  }

  //! get products category laptops
  @override
  Future<List>? getProductsCategoryLaptops() async{
    List? body;
    try{
      http.Response response=await http.get(Uri.parse(urlProductsCategoryLaptops));
      if(response.statusCode==SUCCESS_CODE){
        body=jsonDecode(response.body);
      }
    }catch(e){
      checkDebug(e);
    }
    return body!;
  }

  
  //! post product
  @override
   Future postProduct(ProductMobile productMobile) async {
  var uri = Uri.parse(urlProducts);
  var request = http.MultipartRequest('POST', uri);
  

  // Add text fields
  request.fields['deviceType'] = productMobile.deviceType!;
  request.fields['brand'] = productMobile.brand!;
  request.fields['modelDevice'] = productMobile.modelDevice!;
  request.fields['description'] = productMobile.description!;
  request.fields['price'] = productMobile.price.toString();
  request.fields['capacity'] = productMobile.capacity!;
  request.fields['color'] = productMobile.color!;
  request.fields['batteryHealth'] = productMobile.batteryHealth!.toString();
  request.fields['isFeatured'] = productMobile.isFeatured.toString();
  request.fields['createdBy'] =  productMobile.createdBy!.id!;


  // Handle image files
for (var image in productMobile.productPictures!) {
  var pic = await http.MultipartFile.fromPath(
    'productPictures',
    image.img!.url!,
    contentType: MediaType('image', 'jpeg'), // Set the correct MIME type here
  );
  request.files.add(pic);
}

try {
      var response = await request.send();
      final responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print('Product uploaded successfully!');
        return true; // Indicate success
      } else {
        // Error handling: parse response body for error details
        final responseData = json.decode(responseString);
        final errorMessage = responseData['message'] ?? 'Unknown error occurred';
        print('Failed to upload product: $errorMessage');
        return false; // Indicate failure
      }
    } catch (e) {
      print('Exception caught: $e');
      return false; // Indicate failure due to exception
    }
}



  //! update product
  @override
  Future<void>? updateProduct(String id, ProductMobile productMobile) async{
   
  }

  //! delete product
  @override
  Future<void>? deleteProduct(String id,String token) async{
    try{
      http.Response response=await http.delete(
      Uri.parse('$urlProducts/$id'),
       headers: {
          'Authorization': 'Bearer $token',
    });
      if(response.statusCode==DELETED_CODE){
        checkDebug("Product deleted");
      }
    }catch(e){
      checkDebug(e);
    }
  }

}