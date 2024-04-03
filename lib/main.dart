import 'package:first_store_nodejs_flutter/viewModel/admin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repository/services/api_products.dart';
import 'viewModel/auth_view_model.dart';
import 'viewModel/product_mobile_view_model.dart';
import 'viewModel/user_view_model.dart';
import 'views/widgets/auth_wrapper_widget.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

@override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AdminViewModel()),
         ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => ProductMobileViewModel(productRepo: ApiProducts()) ),
        
      ],
      child: MaterialApp(
        title: 'First Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          
          ),
        home:  const AuthWrapper(),
      ),
    );
      
  }
}