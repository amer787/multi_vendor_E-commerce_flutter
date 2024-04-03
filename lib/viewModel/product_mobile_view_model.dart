import 'dart:async';
import 'package:first_store_nodejs_flutter/models/product_mobile.dart';
import 'package:flutter/material.dart';

import '../repository/product_repo.dart';


class ProductMobileViewModel extends ChangeNotifier{
  late ProductRepo productRepo;
  ProductMobileViewModel({required this.productRepo});

 final List<ProductMobile> _products = [];

//  bool _isLoading = false;
  String? _errorMessage;

  List<ProductMobile>? get products {
    return _products;
  
  }
 
  
  
 // bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  

  
  
  Future<List<ProductMobile>> getAllProducts() async {
  List? list = await productRepo.getAllProducts();
  _products.clear();
  List<ProductMobile> products = list!.map((e) => ProductMobile.fromJson(e)).toList();
  
  _products.addAll(products);
  notifyListeners();
  return products; 
}

  //! get products category phones
  Future<void> getProductsCategoryPhones() async {
    if(_products.isNotEmpty){
    List? list = await productRepo.getProductsCategoryPhones();
    // clear the list before adding new products
    _products.clear();
    _products.addAll(list!.map((e) => ProductMobile.fromJson(e)).toList());
    notifyListeners();
    print("products Phones $_products");
  }else {
    print("products are empty");
  }

  }

  //! get products category tablets
  Future<void> getProductsCategoryTablets() async {
    if(_products.isNotEmpty){
    List? list = await productRepo.getProductsCategoryTablets();
    // clear the list before adding new products
    _products.clear();
    _products.addAll(list!.map((e) => ProductMobile.fromJson(e)).toList());
    notifyListeners();
    print("products are $_products");
  } else {
    print("products are empty");
  }
  }

  //! get products category laptops
  Future<void> getProductsCategoryLaptops() async {
    if(_products.isNotEmpty){
    List? list = await productRepo.getProductsCategoryLaptops();
    // clear the list before adding new products
    _products.clear();
    _products.addAll(list!.map((e) => ProductMobile.fromJson(e)).toList());
    notifyListeners();
    print("products are $_products");
  }
  else {
    print("products are empty");
  }
  }


  Future<void> postProduct(ProductMobile productMobile ) async {
    await productRepo.postProduct(productMobile);
    refresh();
  }
  
  Future<void> updateProduct(String id, ProductMobile productMobile) async {
    await productRepo.updateProduct(id, productMobile);
    refresh();
  }


  Future<void> deleteProduct(String id,String token) async {
    await productRepo.deleteProduct(id, token);
    refresh();
  }
    
  

 refresh(){
  _products.clear();
  getAllProducts();
}
}