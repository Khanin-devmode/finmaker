import 'package:finmaker/features/clients/data/client_cubit.dart';
import 'package:finmaker/features/clients/data/client_model.dart';
import 'package:finmaker/features/common/widgets/confirm_delete_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ClientCard extends StatelessWidget {
  final Client client;

  const ClientCard({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/client-detail/${client.uid}');
      },
      child: Card(
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
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      final isConfirm = await confirmDeleteDialog(
                        context,
                        title: 'Confirm delete this client?',
                      );
                      if (isConfirm == true && context.mounted) {
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
      ),
    );
  }
}
