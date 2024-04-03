import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:card_swiper/card_swiper.dart';
import '../../../../viewModel/user_view_model.dart';
import 'user_products_details_screen.dart';

class UserProfileView extends StatefulWidget {
  final String id;
  UserProfileView({Key? key, required this.id}) : super(key: key);

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  Future? _fetchUserProfile;

  @override
  void initState() {
    super.initState();
    final userProfiles = Provider.of<UserViewModel>(context, listen: false);
    _fetchUserProfile = userProfiles.getUserProfile(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _fetchUserProfile,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Assuming your UserViewModel is correctly set up to provide a user's details
                  return Consumer<UserViewModel>(
                    builder: (context, model, child) {
                      if (model.user != null) {
                        return Column(
                          children: [
                            Center(
                              child: SizedBox(
                                height: height * 0.15,
                                width: width * 0.25,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(model.user!.profilePicture!.url!),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        // if trsuted user show a check icon else show a lock icon
                                        child: model.user!.trustedUser!
                                            ?  Image.asset('assets/verify.png', height: 20, width: 20)
                                            :  Image.asset('assets/notVerify.png', height: 20, width: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Add other UI components from the second design as needed
                            Text(model.user!.name!),
                            Text(model.user!.email!),
                            Text(model.user!.bio!),
                            // Additional user info and products list as in the second design
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 50, top: 10),
                                  alignment: Alignment.centerLeft,
                                  child:  const Text("Products for sale : ",
                                      style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                height: height * 0.35, 
                                width: width * 0.9,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: model.user!.products!.length,
                                  itemBuilder: (context, index) {
                                    var product = model.user!.products![index];
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Card(
                                        child: SizedBox(
                                          height: height * 0.3,
                                          width: width * 0.5,
                                          child: GestureDetector(
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: height * 0.2 ,
                                                  width: width * 0.5,
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
                                                     pagination: const SwiperPagination(),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                      Text(' ${product.modelDevice}'
                                      , style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                      SizedBox(height: 2),
                                      Text('${product.brand}'),
                                      Text('Price: \$${product.price}'),
                                              ],
                                            ),
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => UserProductDetailsScreen(
                                                  id: product.id!,
                                                   deviceType: product.deviceType!,
                                                    brand: product.brand!,
                                                     modelDevice: product.modelDevice!,
                                                      price: product.price.toString(), 
                                                      description: product.description!,
                                                       productPictures: product.productPictures!, 
                                                       capacity: product.capacity!, 
                                                       color: product.color!,
                                                        batteryHealth: product.batteryHealth.toString(),
                                                        createdBy: product.createdBy, 
                                                ),
                                          ),
                                        ),
                                      ),
                                      ) ,
                                    ),
                                    ); },
                                ),
                                                          ),
                              ],
                            )
                          ],
                        );
                      } else {
                        return const Text("No user found");
                      }
                    },
                  );
                }
              },
            ),
            // Further content as needed
          ],
        ),
      ),
    );
  }
}
