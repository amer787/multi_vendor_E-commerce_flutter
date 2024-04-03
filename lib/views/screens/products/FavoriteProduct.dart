import 'package:flutter/material.dart';

class FavoriteProductScreen extends StatefulWidget {
  const FavoriteProductScreen({super.key});

  @override
  State<FavoriteProductScreen> createState() => _FavoriteProductScreenState();
}

class _FavoriteProductScreenState extends State<FavoriteProductScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: const Center(child: Text("Favorites") ,),
    );
  }
}