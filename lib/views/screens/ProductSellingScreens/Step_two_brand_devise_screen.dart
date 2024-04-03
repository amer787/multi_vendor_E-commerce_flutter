//  file_names step two brand_devise_screen.dart
import 'package:first_store_nodejs_flutter/views/screens/ProductSellingScreens/Step_three_product_sale_details_screen.dart';
import 'package:flutter/material.dart';


class BrandDeviseScreen extends StatefulWidget {
  
  const BrandDeviseScreen({super.key,this.deviceTypes, });
  // ignore: prefer_typing_uninitialized_variables
 final deviceTypes;
 

  @override
  State<BrandDeviseScreen> createState() => _BrandDeviseScreenState();
}

class _BrandDeviseScreenState extends State<BrandDeviseScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> brands = ['Apple', 'Samsung'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Brand ${widget.deviceTypes}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductSaleDetailsScreen(deviceTypes:widget.deviceTypes , brand: brands[0], ) ),
              );
            },
            child:  Card(
              child: Column(
                children: [
                  Image.asset('assets/logoApple.png', height: 120),
                  Text('Apple'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductSaleDetailsScreen(deviceTypes: widget.deviceTypes, brand: brands[1]) ),
              );
            },
            child:Card(
              child: Column(
                children: [
                  Image.asset('assets/logoSamsung.png', height: 120),
                  Text('Samsung'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}