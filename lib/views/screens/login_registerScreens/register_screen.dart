import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/auth_view_model.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            SvgPicture.asset(
              'assets/Signup-.svg',
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20),
            Text(
              'Signup',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    controller: _nameController,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'E-Mail',
                      border: OutlineInputBorder(),
                    ),
                    controller: _emailController,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Create password',
                      border: OutlineInputBorder(),
                    ),
                    controller: _passwordController,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      border: OutlineInputBorder(),
                    ),
                    controller: _confirmPasswordController,
                  ),
                  SizedBox(height: 30),
         ElevatedButton(
              onPressed: () async {
                if (_passwordController.text != _confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords do not match")));
                  return;
                }
                bool success = await authViewModel.register(
                  _nameController.text,
                  _emailController.text,
                  _passwordController.text,
                );
                if (!success && authViewModel.errorMessage != null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Registration Error"),
                        content: Text(authViewModel.errorMessage!),
                        actions: <Widget>[
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else if (success) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
              child: Text('Signup'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('OR'),
            SizedBox(height: 20),
            socialMediaIcons(),
            alreadyHaveAnAccount(context),
          ],
        ),
      ),
    );
  }

  Widget socialMediaIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(FontAwesome5.facebook),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(FontAwesome5.google),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(FontAwesome5.apple),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget alreadyHaveAnAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Already have an account?'),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: Text('Login'),
        ),
      ],
    );
  }
}
