//  file_names step three product_sale_details_screen.dart
import 'package:first_store_nodejs_flutter/views/screens/ProductSellingScreens/Step_four_image_product.dart';
import 'package:flutter/material.dart';



class ProductSaleDetailsScreen extends StatefulWidget {
  const ProductSaleDetailsScreen({super.key, this.deviceTypes, this.brand});

  final String? deviceTypes ;
  final String? brand;
  @override
  State<ProductSaleDetailsScreen> createState() => _ProductSaleDetailsScreenState();
}

class _ProductSaleDetailsScreenState extends State<ProductSaleDetailsScreen> {
  String selectedCapacity = '';

  final List<String> capacities = ['128 GB', '256 GB', '512 GB', '1 TB'];

  final _formKey = GlobalKey<FormState>();


  
  // description
  TextEditingController descriptionController = TextEditingController();
  // price
  TextEditingController priceController = TextEditingController();
  // modelDevice
  TextEditingController modelDeviceController = TextEditingController();
  // color 
  TextEditingController colorController = TextEditingController();
  // batteryHealth
  TextEditingController batteryHealthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body:  Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children:[
            TextFormField(
              controller: modelDeviceController,
              decoration: InputDecoration(
                labelText: 'Model ${widget.deviceTypes}',
                hintText: 'Enter the model of your ${widget.deviceTypes}',
                ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a model';
                }
                return null;
              },
            ),
           
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price',
              hintText: 'Enter the price of your ${widget.deviceTypes}'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a price';
                }
                return null;
              },
            ),
          
           
            TextFormField(
              controller: colorController,
              decoration: InputDecoration(labelText: 'Color',
              hintText: 'Enter the color of your ${widget.deviceTypes}'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a color';
                }
                return null;
              },
            ),
            Text(
              'Select a Capacity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: capacities.map((capacity) => ChoiceChip(
                label: Text(capacity),
                selected: selectedCapacity == capacity,
                onSelected: (bool selected) {
                  setState(() {
                    selectedCapacity = capacity;
                  });
                },
              )).toList(),
            ),
            TextFormField(
              controller: batteryHealthController,
              decoration: InputDecoration(
                labelText: 'Battery Health',
                hintText: 'Enter the battery health of your ${widget.deviceTypes}',),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a battery health ${widget.deviceTypes}';
                }
                return null;
              },
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description',
              hintText: 'Enter the description of your ${widget.deviceTypes}'
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Navigate to the next screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageProductScreen(
                        deviceTypes: widget.deviceTypes,
                        brand: widget.brand,
                        modelDevice: modelDeviceController.text,
                        description: descriptionController.text,
                        price: priceController.text,
                        capacity: selectedCapacity,
                        color: colorController.text,
                        batteryHealth: batteryHealthController.text,
                      ),
                    ),
                  );
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}