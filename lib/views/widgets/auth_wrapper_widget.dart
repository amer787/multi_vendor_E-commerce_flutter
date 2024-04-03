import 'package:first_store_nodejs_flutter/views/screens/MainScreen.dart';
import 'package:first_store_nodejs_flutter/views/screens/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewModel/auth_view_model.dart';
import '../screens/login_registerScreens/login_screen.dart';

class AuthWrapper extends StatelessWidget {
   const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    
    final authViewModel = Provider.of<AuthViewModel>(context);

    // Check if the user is loaded 
    if (authViewModel.user != null) {
      // User is logged in
      return Scaffold(
        body: Stack(
          children: [
            DrawerScreen(),
            const MainScreen(),
          ],
        ),
      ) ;
    } else {
      // User is not logged in
      return LoginScreen();
    }
  }
}