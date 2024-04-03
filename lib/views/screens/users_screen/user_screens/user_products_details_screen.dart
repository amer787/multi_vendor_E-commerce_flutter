import 'package:first_store_nodejs_flutter/viewModel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:provider/provider.dart';
import '../../../../models/product_mobile.dart';
import '../../../../viewModel/product_mobile_view_model.dart';
import '../../../widgets/auth_wrapper_widget.dart';
import '../../payment_method_widget.dart';


class UserProductDetailsScreen extends StatelessWidget {
  final String id;
  final CreatedBy? createdBy;
  final String deviceType;
  final String brand;
  final String modelDevice;
  final String price;
  final String description;
  final String capacity; 
  final String color; 
  final String batteryHealth; 
  final List<ProductPicture> productPictures; 

  const UserProductDetailsScreen({
    Key? key,
    required this.id,
    required this.deviceType,
    required this.brand,
    required this.modelDevice,
    required this.price,
    required this.description,
    required this.productPictures,
    required this.capacity, 
    required this.color, 
    required this.batteryHealth, 
     this.createdBy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('$brand $modelDevice'),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            SizedBox(
              height: 500,
              child: Stack(
                children:[ Swiper(
                  itemCount: productPictures.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      productPictures[index].img!.url!,
                    
                      fit: BoxFit.cover,
                    );
                  },
                  pagination: const SwiperPagination(),
                ),
                Positioned( 
                   top: 0,
                   right: 0,
                   child: 
                     authViewModel.user!.id == createdBy!.id ?
                      IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                     onPressed: () {
                     showDialog(
                      context: context,
                       builder: (context) {
                         return AlertDialog(
                           title: const Text('Delete Product'),
                            content: const Text('Are you sure you want to delete this product?'),
                             actions: [
                               TextButton(
                                 onPressed: () {
                                    Navigator.pop(context);
                                     },
                                    child: const Text('No'),
                           ),
                             TextButton(
                             onPressed: () {
                          final productMobileViewModel = Provider.of<ProductMobileViewModel>(context, listen: false);
                                  productMobileViewModel.deleteProduct(id, authViewModel.user!.token!);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthWrapper() ));
                   },
                    child: const Text('Yes'),
                      ),
                        ],
               );
                    },
                    );
                   },
                  ) : SizedBox(height: 0,width: 0,), 
                  ),
                ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  Text(
                    'Device Type: $deviceType',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Brand: $brand',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Model: $modelDevice',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Price: $price',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Capacity: $capacity',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Color: $color',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Battery Health: $batteryHealth',
                    style: TextStyle(fontSize: 16),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Description: ',
                      style: TextStyle(fontSize: 18,color: Colors.black),
                      children: [
                        TextSpan(
                          text: description,
                          style: TextStyle(fontSize: 16,color: Colors.black),

                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const PaymentMethodWidget();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: Colors.green, // Text color
                ),
                child: Column(
                  children: [
                    Text('Buy Now'),
                    Text(' \$ $price'),
                  ],
                ),
              ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

