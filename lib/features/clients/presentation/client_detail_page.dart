import 'package:finmaker/features/common/widgets/side_bar.dart';
import 'package:finmaker/features/policies/data/policy_cubit.dart';
import 'package:finmaker/features/policies/data/policy_state.dart';
import 'package:finmaker/features/policies/presentation/add_policy_dialog.dart';
import 'package:finmaker/features/policies/presentation/policy_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientDetailPage extends StatefulWidget {
  const ClientDetailPage({super.key, required this.clientId});

  final String clientId;

  @override
  State<ClientDetailPage> createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<PolicyCubit>().listenToPolicies(widget.clientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                SideBar(
                  actionWidgets: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left_sharp),
                      onPressed: () {
                        // context.go('/clients');
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Text(widget.clientId),
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(
            indent: 24,
            endIndent: 24,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('Policies'),
                      IconButton(
                        onPressed: () {
                          newPolicyDialogBuilder(
                              context: context, clientId: widget.clientId);
                        },
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<PolicyCubit, PolicyState>(
                      builder: (context, state) {
                        if (state is PolicyLoaded) {
                          return ListView.builder(
                            itemCount: state.policies.length,
                            itemBuilder: (context, index) {
                              final policy = state.policies[index];
                              return PolicyCard(policy: policy);
                              // return Text(policy.id!);
                            },
                          );
                        } else if (state is PolicyError) {
                          return Center(child: Text(state.message));
                        } else {
                          return const Center(
                            child: Text('Got no client state'),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
