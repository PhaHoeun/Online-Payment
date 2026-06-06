import 'package:flutter/material.dart';

class AlipayScreen extends StatefulWidget {
  const AlipayScreen({super.key});

  @override
  State<AlipayScreen> createState() => _AlipayScreenState();
}

class _AlipayScreenState extends State<AlipayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alipay')),
      body: const Center(
        child: Text('This is the Alipay screen'),
      ),
    );
  }
}