
import 'package:flutter/material.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Payment Method',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text('Credit Card'),
            onTap: () {
              Navigator.pop(context); // Close the modal
              _showPaymentSuccess(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text('PayPal'),
            onTap: () {
              Navigator.pop(context); // Close the modal
              _showPaymentSuccess(context);
            },
          ),ListTile(
            leading: const Icon(Icons.money),
            title: const Text('Cash'),
            onTap: () {
              Navigator.pop(context); // Close the modal
              _showPaymentSuccess(context);
            },),

        ],
      ),
    );
  }

  void _showPaymentSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Successful ✅'),
          content: const Text('Your fake payment was successful!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // go to the ProductsScreen
                Navigator.popUntil(context, ModalRoute.withName('/'));
                 // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}