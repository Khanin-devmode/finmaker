import 'package:finmaker/features/auth/data/auth_cubit.dart';
import 'package:finmaker/features/auth/data/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FinMaker',
                      style:
                          TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthInitial || state is AuthLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is AuthAuthenticated) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Welcome, ${state.email}'),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<AuthCubit>().signOut();
                                  },
                                  child: const Text('Sign Out'),
                                ),
                              ],
                            ),
                          );
                        } else if (state is AuthUnauthenticated) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextField(
                                  controller: _emailController,
                                  decoration:
                                      const InputDecoration(labelText: 'Email'),
                                ),
                                TextField(
                                    controller: _passwordController,
                                    decoration: const InputDecoration(
                                        labelText: 'Password'),
                                    obscureText: true),
                                ElevatedButton(
                                  onPressed: () {
                                    final email = _emailController.text;
                                    final password = _passwordController.text;
                                    context
                                        .read<AuthCubit>()
                                        .signIn(email, password);
                                  },
                                  child: const Text('Sign In'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                      listener: (context, state) {
                        if (state is AuthAuthenticated) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Welcome ${state.email}'),
                            ),
                          );
                        } else if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: ${state.message}'),
                            ),
                          );
                        }
                      },
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
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Login'),
                          )
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
