import 'package:finmaker/features/auth/data/auth_cubit.dart';
import 'package:finmaker/features/auth/data/auth_state.dart';
import 'package:finmaker/features/clients/presentation/add_client_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            context.go('/');
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Add Client'),
                onPressed: () {
                  newClientDialogBuilder(context);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.read<AuthCubit>().signOut(),
                child: const Text('sign out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
