// ignore_for_file: must_be_immutable

import 'package:first_store_nodejs_flutter/views/screens/products/Product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:card_swiper/card_swiper.dart';
import '../../../models/product_mobile.dart';
import '../../../viewModel/product_mobile_view_model.dart';

class ProductsScreen extends StatefulWidget {
  final String? id;
  final String? deviceType;
  final String? brand;
  final String? modelDevice;
  final String? price;
  final String? description;
  final String? capacity; 
  final String? color; 
  final String? batteryHealth; 
  final List<ProductPicture>? productPictures; 
  


   ProductsScreen({super.key,
  this.deviceType,
   this.id,
    this.brand,
    this.modelDevice,
    this.price,
    this.description,
    this.productPictures,
    this.capacity,
    this.color,
    this.batteryHealth,

});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  Future? _fetchProductsFuture;
   @override
  void initState() {
    super.initState();
    final productMobileViewModel = Provider.of<ProductMobileViewModel>(context, listen: false);
    _fetchProductsFuture = productMobileViewModel.getAllProducts();
  }
  @override
  Widget build(BuildContext context) {
    // 
 
    return FutureBuilder(
      future: _fetchProductsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<ProductMobileViewModel>(
            builder: (context, model, child) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Products"),
                ),
               
                body: GridView.builder(
                  
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,),
                  itemCount: model.products!.length,
                  itemBuilder: (context, productIndex) {
                     final product = model.products![productIndex];
                    return SizedBox(
                      height: 200,
                      child: Card(
                        color: Colors.grey[70],
                        child: SingleChildScrollView(
                          child: InkWell(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 150,
                                  child: Swiper(
                                    itemCount: product.productPictures!.length,
                                    itemBuilder: (BuildContext context, int imageIndex) {
                                      return Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          product.productPictures![imageIndex].img!.url!,
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                      borderRadius: BorderRadius.circular(20),
                                  
                                                    ),
                                                  );
                                      
                                    },
                                      viewportFraction: 0.8,
                                      scale: 0.9,
                                    pagination: const SwiperPagination(),
                                   // control: const SwiperControl(),
                                  ),
                                ),
                                      
                                Text(model.products![productIndex].modelDevice!),
                               
                                Text(model.products![productIndex].price.toString()),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                    deviceType: model.products![productIndex].deviceType!,
                                    description: model.products![productIndex].description!,
                                    brand: model.products![productIndex].brand!,
                                    modelDevice: model.products![productIndex].modelDevice!,
                                    price: model.products![productIndex].price.toString(),
                                    capacity: model.products![productIndex].capacity!,
                                    color: model.products![productIndex].color!,
                                    batteryHealth: model.products![productIndex].batteryHealth!.toString(),
                                    id: model.products![productIndex].id.toString(),
                                    createdBy: model.products![productIndex].createdBy!,
                                    productPictures: model.products![productIndex].productPictures!,
                                ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
