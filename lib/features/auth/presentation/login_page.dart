import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FinMaker',
                    style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(),
          Expanded(
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
