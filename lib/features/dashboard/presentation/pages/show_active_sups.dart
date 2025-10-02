import 'package:flutter/material.dart';

class ShowActiveSups extends StatelessWidget {
  const ShowActiveSups({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Active Subscriptions')),
      body: const Center(child: Text('Show Active Subscriptions')),
    );
  }
}
