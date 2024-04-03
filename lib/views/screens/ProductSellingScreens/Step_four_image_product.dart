import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../models/product_mobile.dart';
import '../../../viewModel/auth_view_model.dart';
import '../../../viewModel/product_mobile_view_model.dart';
import '../../widgets/auth_wrapper_widget.dart';


class ImageProductScreen extends StatefulWidget {
  // Replace with the actual types of these variables
  final String? deviceTypes;
  final String? brand;
  final String? modelDevice;
  final String? description;
  final String? price;
  final String? capacity;
  final String? color;
  final String? batteryHealth;

  ImageProductScreen({
    Key? key,
    this.deviceTypes,
    this.brand,
    this.modelDevice,
    this.description,
    this.price,
    this.capacity,
    this.color,
    this.batteryHealth,
  }) : super(key: key);

  @override
  _ImageProductScreenState createState() => _ImageProductScreenState();
}

class _ImageProductScreenState extends State<ImageProductScreen> {
  
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles;

  Future<void> _pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        _imageFiles = selectedImages;
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
        final productViewModel = Provider.of<ProductMobileViewModel>(context, listen: false);
    final AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);
    final String userID = authViewModel.user!.id!;
    return Scaffold(
      appBar: AppBar(
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(

              'Upload/take Photos of your device',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Minimum: 2 photos taken from all sides and in high quality',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 5, 
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: _pickImages,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _imageFiles != null && index < _imageFiles!.length
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(_imageFiles![index].path),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: ()async{
                  if (_imageFiles != null && _imageFiles!.isNotEmpty) {
                    // Convert XFiles to your ProductPicture model
                    List<ProductPicture> productPictures = _imageFiles!.map((file) =>
                        ProductPicture(img: Img(url: file.path, publicId: ''))).toList();
                    // Call the API to create the product - this is a pseudo-code example
                    await productViewModel.postProduct(
                      ProductMobile(
                        deviceType: widget.deviceTypes,
                        brand: widget.brand,
                        modelDevice: widget.modelDevice,
                        description: widget.description,
                        price: int.parse(widget.price!),
                        capacity: widget.capacity,
                        color: widget.color,
                        batteryHealth: int.parse(widget.batteryHealth!),
                        isFeatured: false,
                        createdBy: CreatedBy(id: userID), // Replace with actual user ID
                        productPictures: productPictures,
                      ),
                    ).then((value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  AuthWrapper()),
                    ));
                  } else {
                    print('Please select at least one image for the product.');
                  }
                },
                child: Text('Submit Product'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Make sure to define the ViewModel and necessary model classes as per your application architecture.
