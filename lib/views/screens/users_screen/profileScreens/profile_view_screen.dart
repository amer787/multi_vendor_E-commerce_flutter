// ProfileViewScreen.dart
import 'package:card_swiper/card_swiper.dart';
import 'package:first_store_nodejs_flutter/views/screens/users_screen/user_screens/user_products_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../viewModel/auth_view_model.dart';
import '../../../../viewModel/user_view_model.dart';
import 'profile_edit_screen.dart';


class ProfileViewScreen extends StatefulWidget {
   ProfileViewScreen({super.key });

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {

  Future? _fetchUserProfile;



  @override
  void initState() {
    super.initState();
    final AuthViewModel authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    var userId =  authViewModel.user!.id;
  final userProfiles =  Provider.of<UserViewModel>(context, listen: false);
    _fetchUserProfile =  userProfiles.getUserProfile(userId!);
  }
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
         
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
               builder: (context) => ProfileEditScreen(
               id: authViewModel.user!.id,
               token:authViewModel.user!.token,
              ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: height * 0.15,
                width: width * 0.25,
                child: Stack(fit: StackFit.expand,
                children: [
                  if (authViewModel.user!.profilePicture?.url != null)
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(authViewModel.user!.profilePicture!.url!),
                    ),
                  if (authViewModel.user!.profilePicture?.url == null)
                    CircleAvatar(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const Image(
                          fit: BoxFit.cover,
                          image: NetworkImage('https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset('assets/Verified_1.svg', height: 20, width: 20,),
                      ),
                    )
                ],),
              ),
            ),
            const SizedBox(height: 10,),
            
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(children: [
                if (authViewModel.user!.isAdmin == false)
               Text('Hi ${authViewModel.user!.name} 👋 ',
               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                if (authViewModel.user!.isAdmin == true)
                Text('Hi Admin ${authViewModel.user!.name} 👋 ',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ] 
              )
              ),
            ),
             SizedBox(height: 3,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              // user bio
              child: Column(
                children: [
                  if (authViewModel.user!.bio != null)
                  Text(authViewModel.user!.bio!,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  if (authViewModel.user!.bio == null)
                  const Text('No bio yet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ],
              ),
              ),
              ),
              const SizedBox(height: 10,),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                height: height * 0.6,
                width: width * 0.9,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 200),
                      child: Text('My products', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                    Center(
                     child: _fetchUserProfile == null
                      ? CircularProgressIndicator()
                      : SingleChildScrollView(
                    child:  FutureBuilder(
                      future: _fetchUserProfile,
                      builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Assuming your UserViewModel is correctly set up to provide a user's products
                      return Consumer<UserViewModel>(
                        builder: (context, model, child) {
                          return SizedBox(
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
                          );
                        },
                      );
                    }
                    },
                    ),
                    ),
                    ),
                  ],
                ),
                ),
              ),
              ],
        ),
      ),
    );
  }
}

    