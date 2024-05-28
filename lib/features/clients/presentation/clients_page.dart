import 'package:finmaker/features/auth/data/auth_cubit.dart';
import 'package:finmaker/features/auth/data/auth_state.dart';
import 'package:finmaker/features/clients/data/client_model.dart';
import 'package:finmaker/features/clients/data/client_state.dart';
import 'package:finmaker/features/clients/data/client_cubit.dart';
import 'package:finmaker/features/clients/presentation/add_client_dialog.dart';
import 'package:finmaker/features/common/widgets/side_bar.dart';
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
    super.initState();
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthAuthenticated) {
      context.read<ClientCubit>().listenToClients(authState.user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go('/');
        }
      },
      child: Scaffold(
        body: Row(
          children: [
            const SideBar(),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Center(
                      child: SizedBox(
                        width: 600,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text('Client'),
                              IconButton(
                                  onPressed: () {
                                    newClientDialog(context);
                                  },
                                  icon: const Icon(Icons.add))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 600,
                        child: BlocBuilder<ClientCubit, ClientState>(
                          builder: (context, state) {
                            if (state is ClientLoaded) {
                              return ListView.builder(
                                itemCount: state.clients.length,
                                itemBuilder: (context, index) {
                                  final client = state.clients[index];
                                  return ClientCard(client: client);
                                },
                              );
                            } else if (state is ClientError) {
                              return Center(child: Text(state.message));
                            } else {
                              return const Center(
                                child: Text('Got no client state'),
                              );
                            }
                          },
                        ),
                      ),
                    ),
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

class ClientCard extends StatelessWidget {
  final Client client;

  const ClientCard({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  client.firstName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    final isConfirm =
                        await showDeleteConfirmationDialog(context, client);
                    if (isConfirm != null && isConfirm) {
                      context
                          .read<ClientCubit>()
                          .deleteClient(client.uid as String);
                    }
                  },
                )
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              'id: ${client.uid}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Phone: ',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool?> showDeleteConfirmationDialog(
    BuildContext context, Client client) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Client'),
        content: Text('Are you sure you want to delete this client?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Return false
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Return true
            },
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}
