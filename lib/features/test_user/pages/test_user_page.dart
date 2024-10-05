import 'package:flutter/material.dart';

class TestUserPage extends StatelessWidget {
const TestUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TestUser Page')),
      body: const Center(
        child: Text('Welcome to the TestUser page!'),
      ),
    );
  }
}
