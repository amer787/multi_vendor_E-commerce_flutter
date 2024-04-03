import 'package:first_store_nodejs_flutter/viewModel/auth_view_model.dart';
import 'package:first_store_nodejs_flutter/views/widgets/auth_wrapper_widget.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:provider/provider.dart';
import '../../../models/product_mobile.dart';
import '../../../viewModel/product_mobile_view_model.dart';
import '../payment_method_widget.dart';
import '../users_screen/user_screens/user_product_screen.dart';




class ProductDetailsDashboardScreen extends StatelessWidget {
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

  const ProductDetailsDashboardScreen({
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Swiper(
                itemCount: productPictures.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    productPictures[index].img!.url!,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                  );
                },
                pagination: const SwiperPagination(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:  const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailSection(title: 'Device Type', value: deviceType),
                  DetailSection(title: 'Brand', value: brand),
                  DetailSection(title: 'Model', value: modelDevice),
                  DetailSection(title: 'Price', value: '\$${price}'),
                  DetailSection(title: 'Capacity', value: capacity),
                  DetailSection(title: 'Color', value: color),
                  DetailSection(title: 'Battery Health', value: '$batteryHealth%'),
                  const SizedBox(height: 10),
                  const Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(description, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  GestureDetector(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 16, color: Colors.black), // Default text style
                        children: <TextSpan>[
                          const TextSpan(text: 'Sold by: '),
                          TextSpan(
                            text: '${createdBy?.name ?? 'Unknown'}',
                            style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold), // Apply color to name
                          ),
                        ],
                      ),
                    ),
                    onTap:  () {
                          // navigate to the user profile
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfileView(
                              id: createdBy!.id!,
                              
                            ),
                          ),
                        );
                        },
                  ),
                   SizedBox(height: 10),
                    // bottom delete product ElevatedButton
                  ElevatedButton(
                    //  Color red for the delete button
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.red,
                    ),
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
                    child: const Text('Delete Product'),
                  ),
SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: BuyNowButton(price: price),
                  ),
                 
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class DetailSection extends StatelessWidget {
  final String title;
  final String value;

  const DetailSection({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text('$title:', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}

class BuyNowButton extends StatelessWidget {
  final String price;

  const BuyNowButton({Key? key, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return const PaymentMethodWidget();
          },
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.green,
      ),
       child: Column(
    children: [
      Text('Buy Now'),
      Text(' \$ $price'),
    ],
  ),
    );
  }
}
