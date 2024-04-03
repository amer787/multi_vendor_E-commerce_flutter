import 'package:flutter/material.dart';

class ProductScreenOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Screen One'),
        centerTitle: true,
      ),
body: GridView.builder(
  padding: const EdgeInsets.all(10.0),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, 
    crossAxisSpacing: 10.0,
    mainAxisSpacing: 10.0,
    childAspectRatio: 0.8, 
  ),
  itemCount: 20, 
  itemBuilder: (ctx, i) => Card(
    child: Column(
      children: <Widget>[
        Image.network('Product Image URL Here'), 
        Text('Product Title Here'), 
        Text('Product Price Here'), 
        
      ],
    ),
  ),
),
    );
  }
}
