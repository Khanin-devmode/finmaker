import 'package:finmaker/features/auth/data/auth_cubit.dart';
import 'package:finmaker/features/auth/data/auth_state.dart';
import 'package:finmaker/features/clients/data/client_state.dart';
import 'package:finmaker/features/clients/data/client_cubit.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthAuthenticated) {
      context.read<ClientCubit>().listenToClients(authState.user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthUnauthenticated) {
              context.go('/');
            }
          },
          builder: (constext, state) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<ClientCubit, ClientState>(
                        builder: (context, state) {
                      print(state);
                      if (state is ClientLoaded) {
                        return Column(
                          children: [
                            Text('Client numbers: ${state.clients.length}'),
                            Column(
                                children: state.clients
                                    .map((client) => Text(client.firstName))
                                    .toList())
                          ],
                        );
                      } else if (state is ClientError) {
                        return Text(state.message);
                      } else {
                        return const SizedBox(
                          child: Text('Got no client state'),
                        );
                      }
                    }),
                    ElevatedButton(
                      child: const Text('Add Client'),
                      onPressed: () {
                        newClientDialog(context);
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context.read<AuthCubit>().signOut(),
                      child: const Text('sign out'),
                    ),
                  ],
                ),
              )),
    );
  }
}
