import 'package:first_store_nodejs_flutter/viewModel/admin_view_model.dart';
import 'package:first_store_nodejs_flutter/viewModel/auth_view_model.dart';
import 'package:first_store_nodejs_flutter/views/screens/admin_screen/admin_dashboard_screen.dart';
import 'package:first_store_nodejs_flutter/views/screens/admin_screen/users_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'products_dashboard_screen.dart';
import 'trusted_user_dashboard_screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen> {
 var height , width;
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final adminViewModel = Provider.of<AdminViewModel>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:  ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: height * 0.2,
            width: width,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 101, 105, 107),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Hello Admin ${authViewModel.user!.name}', style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold
                  )),
                  
                  subtitle: Text('This is the admin dashboard page',
                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold
                  )),
                  trailing:  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(authViewModel.user!.profilePicture!.url!),
                  ),
                ),
                const SizedBox( height: 30,)
              ],
          ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
          ),
          ),
          child: GridView(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.5,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserDashboardScreen()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/user.png', height: 50, width: 50),
                    Text('Manage Users', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black
                    ),
                    ),
                    Text('( ${adminViewModel.usersCount}  )', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black
                    ),
                    
                    ),
                  ],
                ),
              ),
              // ElevatedButton: to navigate to the TrustedUserDashboardScreen
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TrustedUserDashboardScreen()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/trustedUser.png', height: 50, width: 50),
                    Text('Trusted Users', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black
                    )),
                    Text('( ${adminViewModel.trustUsersCount} )', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black
                    )),
                  ],
                ),
              ),
              // ElevatedButton: to navigate to the AdminDashboardScreen
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Image.asset('assets/admin.png', height: 50, width: 50),
                    Text('Admins', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black
                    )),
                    Text('( ${adminViewModel.adminCount} )', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black
                    )),
                  ],
                ),
              ),
              // product 
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductsDashboardScreen()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/product.png', height: 50, width: 50),
                    Text('Products', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black
                    )),
                    Text('( ${adminViewModel.productsCount} )', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black
                    )),
                  ],
                ),
              ),
            ],
          ),
          ),
        ],
      ),
      );
  }
}

