import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final kLoginButtonStyle = const ButtonStyle(
    fixedSize: WidgetStatePropertyAll(
      Size(200, 40),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        child: Row(
          children: [
            const Expanded(
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
            const VerticalDivider(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Login'),
                  Form(
                    child: SizedBox(
                      width: 360,
                      child: Column(
                        children: [
                          TextFormField(),
                          TextFormField(),
                          const SizedBox(height: 20),
                          ElevatedButton(onPressed: () {}, child: Text('Login'))
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    indent: 40,
                    endIndent: 40,
                    height: 80,
                  ),
                  ElevatedButton(
                    style: kLoginButtonStyle,
                    onPressed: () {},
                    child: const Text('Apple'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: kLoginButtonStyle,
                    onPressed: () {},
                    child: const Text('Facebook'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: kLoginButtonStyle,
                    onPressed: () {},
                    child: const Text('Google'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
