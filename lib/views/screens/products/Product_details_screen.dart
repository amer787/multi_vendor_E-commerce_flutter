import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../../../models/product_mobile.dart';
import '../payment_method_widget.dart';
import '../users_screen/user_screens/user_product_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
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

  const ProductDetailsScreen({
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
    return Scaffold(
      extendBody: false,
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
                  BuyNowButton(price: price),
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
          Expanded(flex: 2, child: Text('$title:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text(value, style: TextStyle(fontSize: 16))),
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
