import 'package:first_store_nodejs_flutter/views/widgets/auth_wrapper_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/auth_view_model.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    void _showLoginErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login Error"),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }

    void _login() async {
      bool success = await authViewModel.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthWrapper()),
        );
      } else {
        _showLoginErrorDialog(authViewModel.errorMessage ?? 'Login failed. Please try again.');
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),
            SvgPicture.asset('assets/login-.svg', width: 300, height: 300),
            SizedBox(height: 20),
            Text('Login', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'E-Mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                  ),
                  SizedBox(height: 20),
                  Text('OR'),
                  socialLoginButtons(),
                  registerButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget socialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.facebook),
          onPressed: () {/* Handle Facebook login */},
        ),
        IconButton(
          icon: Icon(Icons.g_mobiledata),
          onPressed: () {/* Handle Google login */},
        ),
        IconButton(
          icon: Icon(Icons.apple),
          onPressed: () {/* Handle Apple login */},
        ),
      ],
    );
  }

  Widget registerButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
      },
      child: const Text('Need an account? Signup'),
    );
  }
}
