import 'package:flutter/material.dart';
import 'package:online_payment/screen/alipay/alipay_screen.dart';
import 'package:online_payment/screen/paypal/paypal_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Online Payment')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Open AliPay
            GestureDetector(
              onTap: () {
                // Handle tap event for "Open Setting"
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AlipayScreen()),
                );
              },
              child: Card(
                color: Colors.cyan,
                margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('AliPay', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            //Open Paypal
            GestureDetector(
              onTap: () {
                // Handle tap event for "Open Setting"
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaypalScreen()),
                );
              },
              child: Card(
                color: Colors.cyan,
                margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Paypal', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
