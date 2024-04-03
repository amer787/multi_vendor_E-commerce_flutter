import 'package:first_store_nodejs_flutter/viewModel/auth_view_model.dart';
import 'package:first_store_nodejs_flutter/views/screens/products/FavoriteProduct.dart';
import 'package:first_store_nodejs_flutter/views/screens/users_screen/profileScreens/profile_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'admin_screen/dashboard_screen.dart';


class DrawerScreen extends StatefulWidget {
   DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  

  @override
  Widget build(BuildContext context) {
     final AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);
    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding:  EdgeInsets.only(top: 50,left: 40,bottom: 70),
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
          Row(
            children: [
              if (authViewModel.user!.profilePicture?.url != null)
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(authViewModel.user!.profilePicture!.url!),
                ), 
          if (authViewModel.user == null)    CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const Image(
                     fit: BoxFit.cover  ,
                    image: NetworkImage('https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                  ),
              ),
              ),
              SizedBox(width: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (authViewModel.user != null&& authViewModel.user!.isAdmin == false)    Text('Hi ${authViewModel.user!.name} 👋 ',
                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  if (authViewModel.user!.isAdmin == true)  Text('Hi Admin ${authViewModel.user!.name} 👋 ',
                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                if (authViewModel.user == null)  const Text('User Name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                ],
              )
            ],
          ),
          SizedBox(height: 10,),
          InkWell(
            child: const Row(
              children: [
                Icon(Icons.person_sharp, size: 35,),
                SizedBox(width: 10,),
                Text('Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ],
            ),
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileViewScreen()));
            },
          ),
          SizedBox(height: 20,),
          GestureDetector(
            child: Row(
              children: [
                Icon(Icons.favorite, size: 30,),
                SizedBox(width: 10,),
                Text('Favorites', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ],
            ),
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteProductScreen()));
            },
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Icon(Icons.settings, size: 30,),
              SizedBox(width: 10,),
              Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ],
          ),
         
          SizedBox(height: 20,),
          GestureDetector(
            child: Row(
              children: [
                Icon(Icons.exit_to_app, size: 30,),
                SizedBox(width: 10,),
                Text('Log Out', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ],
            ),
            onTap: () {
              authViewModel.logout();
            },
          ),
          SizedBox(height: 20,),
              Container(
                child: authViewModel.user!.isAdmin! ? Row(
                            children: [
                Icon(Icons.admin_panel_settings_sharp, size: 30,color: Colors.blue[500],),
                SizedBox(width: 10,),
                
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Text('Admin Panel', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.blueAccent),),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    
                     Navigator.push(context, MaterialPageRoute(builder: (context) =>  DashboardScreen()));
                  },
                ),
                            ],
                          ) : Container(),
              ),
          ],
       

        ),



        
        ),
    );
  }
}