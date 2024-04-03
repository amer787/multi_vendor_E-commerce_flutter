import 'package:first_store_nodejs_flutter/viewModel/admin_view_model.dart';
import 'package:first_store_nodejs_flutter/viewModel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_registerScreens/login_screen.dart';
import '../users_screen/user_screens/user_product_screen.dart';


class TrustedUserDashboardScreen extends StatefulWidget {
  const TrustedUserDashboardScreen({super.key});

  @override
  State<TrustedUserDashboardScreen> createState() => _TrustedUserDashboardScreenState();
}


class _TrustedUserDashboardScreenState extends State<TrustedUserDashboardScreen> {
  Future? _fetchtrustedUsers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final adminViewModel = Provider.of<AdminViewModel>(context, listen: false);
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    // fetch all users profile 
    _fetchtrustedUsers = adminViewModel.getAllTrustedUserProfile(authViewModel.user!.token!);
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text("Trusted User Dashboard"),
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
      // ElevatedButton: button to get getAllUsersProfile FututreBuilder to get the all user from the server
      body:  FutureBuilder(
        future: _fetchtrustedUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<AdminViewModel>(
              builder: (context, model, child) {
                return ListView.builder(
                  itemCount: model.users!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(model.users![index].name!),
                      subtitle: Text(model.users![index].email!),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(model.users![index].profilePicture!.url!),
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
                        } ,
                    );
                  },
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}