import 'package:flutter/material.dart';

class ShowExpierdSupds extends StatelessWidget {
  const ShowExpierdSupds({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expired Subscriptions')),
      body: const Center(child: Text('Show Expired Subscriptions')),
    );
  }
}
