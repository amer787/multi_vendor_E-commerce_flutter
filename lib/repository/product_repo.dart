import 'package:first_store_nodejs_flutter/models/product_mobile.dart';

abstract class ProductRepo {
  // Get products
  Future<List>? getAllProducts();
 // Future<List<Product>>? getAllProducts();

 // Get product category phones 
  Future<List>? getProductsCategoryPhones();

  // Get product category tablets 
  Future<List>? getProductsCategoryTablets();

  //Get product category laptops
  Future<List>? getProductsCategoryLaptops();


  // post product
  Future<void>? postProduct(ProductMobile productMobile);
 // Future<Product>? postProduct(Product product);

 // patch product
  Future<void>? updateProduct(String id,ProductMobile productMobile);

  // delete product
  Future<void>? deleteProduct(String id,String token);

}

