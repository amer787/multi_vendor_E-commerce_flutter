import 'package:card_swiper/card_swiper.dart';
import 'package:first_store_nodejs_flutter/views/screens/products/Laptop_screen.dart';
import 'package:first_store_nodejs_flutter/views/screens/products/Phones_screen.dart';
import 'package:first_store_nodejs_flutter/views/screens/products/Tablet_screen.dart';
import 'package:first_store_nodejs_flutter/views/screens/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewModel/product_mobile_view_model.dart';
import 'ProductSellingScreens/Step_one_deviseType_screen.dart';
import 'products/Product_details_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future? _fetchProductsFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final productMobileViewModel = Provider.of<ProductMobileViewModel>(context, listen: false);
    _fetchProductsFuture = productMobileViewModel.getAllProducts();


  }
  double xOffset = 0;
  double yOffset = 0;
   
   bool isDrawerOpen = false;


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
      ..scale(isDrawerOpen ? 0.85 : 1.00)
      ..rotateZ(isDrawerOpen ? -50 : 0),
      duration:  Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0)
      ),
      child: SingleChildScrollView(

        child: Column(
          children: [
             SizedBox(height: height * 0.05,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isDrawerOpen ? GestureDetector(
                    child: const Icon(Icons.arrow_back_ios),
                    onTap: () {
                      setState(() {
                        xOffset = 0;
                        yOffset = 0;
                        isDrawerOpen = false;
                      });
                    },
                    ) :
                   GestureDetector(
                    child: const Icon(Icons.menu),
                    onTap: () {
                      setState(() {
                       xOffset = 290;
                        yOffset = 80;
                        isDrawerOpen = true;
                      });
                    },
                    ),
                    
                     GestureDetector(
                        child: const Icon(Icons.add_box_rounded,),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>   DeviseTypeScreen() ));
                        },
                      ),
                    
                    ],
              ),
            ),
            SizedBox(height: height * 0.001,),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Categories", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                      Text("See all", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02,),
                Container(
                  height: height * 0.04,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                       // all products 
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Text("All", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen()));
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Text("Phones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PhonesScreen()));
                        },
                      ),
                      SizedBox(width: 20,),
                      GestureDetector(
                        child: Container(
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Text("Laptops", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LaptopScreen()));
                        },
                      ),
                      SizedBox(width: 20,),
                      GestureDetector(
                        child: Container(
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Text("Tablets", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TabletScreen()));
                        },
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
            SizedBox(height: height * 0.02,),
             
            
             // Use FutureBuilder to handle asynchronous loading of products
FutureBuilder(
  future: _fetchProductsFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else {
      // Check if snapshot.data is not null and cast it to the expected type if necessary
      var data = snapshot.data;
      print('Data received: $data'); // Debugging line
      if (data != null && data.isNotEmpty) {
        return Consumer<ProductMobileViewModel>(
          builder: (context, model, child) {
            return Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
             
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 2,
                         crossAxisSpacing: 8,
                         mainAxisSpacing: 8,
                         mainAxisExtent: 300,
                         childAspectRatio: 0.7,
                      ),
                      itemCount: model.products!.length,
                      itemBuilder: (context, productIndex) {
                        final product = model.products![productIndex];
                        return SizedBox(
                          height: 200,
                          child: Card(
                            color: Colors.white,
                            child: InkWell(
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: height * 0.2,
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
                                      itemWidth: 300.0,
                                      itemHeight: 300.0,
                                      layout: SwiperLayout.STACK,
                                      pagination: const SwiperPagination(),
                                      // control: const SwiperControl(),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(' ${model.products![productIndex].modelDevice}'
                                  , style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                  Text('${model.products![productIndex].brand}'),
                                  Text('Price: \$${model.products![productIndex].price}'),
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        return const Center(child: Text("No data"));
      }
    }
  },
),

],
        ),
      )
    );
  }
}