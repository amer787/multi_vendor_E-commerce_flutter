

import 'package:first_store_nodejs_flutter/viewModel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../viewModel/admin_view_model.dart';
import '../login_registerScreens/login_screen.dart';
import '../users_screen/user_screens/user_product_screen.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}
class _UserDashboardScreenState extends State<UserDashboardScreen> {
Future? _fetchUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final adminViewModel = Provider.of<AdminViewModel>(context, listen: false);
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    // fetch all users profile 
    _fetchUser = adminViewModel.getAllUsersProfile(authViewModel.user!.token!);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('user_data');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body:  FutureBuilder(
        future: _fetchUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<AdminViewModel>(
              builder: (context, model, child) {
                return InkWell(
                  child: ListView.builder(
                    itemCount: model.users!.length,
                    itemBuilder:
                   (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(model.users![index].profilePicture!.url!),
                      ),
                      title: Text(model.users![index].name!),
                      subtitle: Text(model.users![index].email!),
                      // button to delete user
                      trailing: ElevatedButton(
                        onPressed: () {
                          
                        },
                        child: Text('Delete' ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfileView(
                              id: model.users![index].id!
                              
                            ),
                          ),
                        );
                      },
                    );
                  },
                  
                  ),

                 
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}