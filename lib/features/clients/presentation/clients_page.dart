import 'package:finmaker/features/auth/data/auth_cubit.dart';
import 'package:finmaker/features/auth/data/auth_state.dart';
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
                  Row(
                    children: [
                      const Text('Client'),
                      IconButton(
                          onPressed: () {
                            newClientDialog(context);
                          },
                          icon: Icon(Icons.add))
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<ClientCubit, ClientState>(
                      builder: (context, state) {
                        if (state is ClientLoaded) {
                          return ListView.builder(
                            itemCount: state.clients.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(state.clients[index].firstName),
                              );
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
