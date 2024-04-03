//  file_names step one deviseType_screen.dart 
import 'package:first_store_nodejs_flutter/views/screens/ProductSellingScreens/Step_two_brand_devise_screen.dart';
import 'package:flutter/material.dart';

class DeviseTypeScreen extends StatefulWidget {
  

  DeviseTypeScreen({Key? key, }) : super(key: key);

  @override
  State<DeviseTypeScreen> createState() => _DeviseTypeScreenState();
}

class _DeviseTypeScreenState extends State<DeviseTypeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> deviceTypes = ['Mobile', 'Tablet', 'Laptop', 'Smartwatch', 'Headphones', 'Accessories'];
    return Scaffold(
      appBar: AppBar(
         title: const Text('Select Device Type'),
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
                MaterialPageRoute(builder: (context) => BrandDeviseScreen(deviceTypes: deviceTypes[0])),
              );
            },
            child:  Card(
              child: Column(
                children: [
                  SizedBox(height: 20), // Add space between the image and the text (Mobile
                  Image.asset('assets/iphone11.png', height: 120),
                  SizedBox(height: 10),
                  Text('Mobile'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  BrandDeviseScreen(deviceTypes: deviceTypes[1])),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Image.asset('assets/tablet1.png', height: 150),
                  Text('Tablet'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BrandDeviseScreen(deviceTypes: deviceTypes[2]) ),
              );
            },
            child:  Card(
              child: Column(
                children: [
                  Image.asset('assets/laptop.png', height: 120),
                  Text('Laptop'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BrandDeviseScreen(deviceTypes: deviceTypes[3])),
              );
            },
            child:  Card(
              child: Column(
                children: [
                  SizedBox(height: 20), 
                  Image.asset('assets/watch.png', height: 100),
                  Text('Smartwatch'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BrandDeviseScreen(deviceTypes: deviceTypes[4])),
              );
            },
            child:  Card(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Image.asset('assets/headPhones.png', height: 120),
                  Text('Headphones'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BrandDeviseScreen(deviceTypes: deviceTypes[5])),
              );
            },
            child:  Card(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Image.asset('assets/accessories.png', height: 100 ),
                  Text('Accessories'),
                ],
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}