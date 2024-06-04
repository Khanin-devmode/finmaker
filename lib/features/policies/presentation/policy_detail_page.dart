import 'package:finmaker/features/auth/data/auth_cubit.dart';
import 'package:finmaker/features/auth/data/auth_state.dart';
import 'package:finmaker/features/clients/data/active_client_cubit.dart';
import 'package:finmaker/features/clients/data/client_model.dart';
import 'package:finmaker/features/common/widgets/side_bar.dart';
import 'package:finmaker/features/policies/data/policy_cubit.dart';
import 'package:finmaker/features/policies/data/policy_model.dart';
import 'package:finmaker/features/policies/data/policy_state.dart';
import 'package:finmaker/features/policies/presentation/add_policy_dialog.dart';
import 'package:finmaker/features/specs/data/spec_cubit.dart';
import 'package:finmaker/features/specs/data/spec_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PolicyDetailPage extends StatefulWidget {
  const PolicyDetailPage(
      {super.key, required this.clientId, required this.policyId});

  final String policyId;
  final String clientId;

  @override
  State<PolicyDetailPage> createState() => _PolicyDetailPageState();
}

class _PolicyDetailPageState extends State<PolicyDetailPage> {
  late Policy selectedPolicy;
  String? selectedSpecKey;

  @override
  void initState() {
    super.initState();
    final state = context.read<PolicyCubit>().state;
    if (state is PolicyLoaded) {
      selectedPolicy =
          state.policies.firstWhere((policy) => policy.id == widget.policyId);
    }
    context.read<SpecCubit>().listenToSpecs(widget.clientId, widget.policyId);
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
                    child: Text(selectedPolicy.id as String),
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
                              context: context, clientId: widget.policyId);
                        },
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<SpecCubit, SpecState>(
                      builder: (context, state) {
                        if (state is SpecLoaded) {
                          // return ListView.builder(
                          //   itemCount: state.policies.length,
                          //   itemBuilder: (context, index) {
                          //     final policy = state.policies[index];
                          //     return PolicySpecCard(policy: policy);
                          //   },
                          // );
                          return Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(child: Divider()),
                                  // DropdownButton(items: items, onChanged: onChanged)
                                  BlocBuilder<ActiveClientCubit, Client?>(
                                      builder: (context, state) {
                                    final keys =
                                        state!.specGroupsConfig.keys.toList();
                                    // return (Text(keys.toString()));
                                    return DropdownButton(
                                        value: selectedSpecKey ?? keys.first,
                                        items: state.specGroupsConfig.keys
                                            .map(
                                              (key) => DropdownMenuItem(
                                                value: key,
                                                child: Text(key),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (newKey) {
                                          setState(() {
                                            selectedSpecKey = newKey;
                                            print(selectedSpecKey);
                                          });
                                        });
                                  }),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add),
                                  ),
                                  const Expanded(child: Divider())
                                ],
                              )
                            ],
                          );
                        } else if (state is SpecError) {
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
