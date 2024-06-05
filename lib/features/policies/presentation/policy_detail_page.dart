import 'package:finmaker/features/clients/data/active_client_cubit.dart';
import 'package:finmaker/features/clients/data/client_model.dart';
import 'package:finmaker/features/common/widgets/side_bar.dart';
import 'package:finmaker/features/policies/data/active_policy_cubit.dart';
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
  String? selectedSpecKey;

  @override
  void initState() {
    super.initState();
    final state = context.read<PolicyCubit>().state;
    if (state is PolicyLoaded) {
      final selectedPolicy =
          state.policies.firstWhere((policy) => policy.id == widget.policyId);

      context.read<ActivePolicyCubit>().selectPolicy(selectedPolicy);
    }
    context.read<SpecCubit>().listenToSpecs(widget.clientId, widget.policyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ActivePolicyCubit, Policy?>(
          builder: (context, policyState) {
        return Row(
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
                      child: Text(policyState!.id as String),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
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
                        builder: (context, specState) {
                          if (specState is SpecLoaded) {
                            // return ListView.builder(
                            //   itemCount: state.policies.length,
                            //   itemBuilder: (context, index) {
                            //     final policy = state.policies[index];
                            //     return PolicySpecCard(policy: policy);
                            //   },
                            // );
                            return Column(
                              children: [
                                for (var specGroupKey
                                    in policyState.specGroupKeys)
                                  Text(specGroupKey),
                                Row(
                                  children: [
                                    const Expanded(child: Divider()),
                                    BlocBuilder<ActiveClientCubit, Client?>(
                                        builder: (context, state) {
                                      final keys =
                                          state!.specGroupsConfig.keys.toList();
                                      selectedSpecKey ??= keys.first;
                                      return DropdownButton(
                                          value: selectedSpecKey,
                                          items: state.specGroupsConfig.entries
                                              .map(
                                                (entry) => DropdownMenuItem(
                                                  value: entry.key,
                                                  child: Text(entry.value),
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
                                      onPressed: () {
                                        List currentSpecGroups =
                                            policyState.specGroupKeys;
                                        if (!currentSpecGroups
                                            .contains(selectedSpecKey)) {
                                          List<String> newList = [
                                            ...policyState.specGroupKeys,
                                            selectedSpecKey as String
                                          ];
                                          context
                                              .read<ActivePolicyCubit>()
                                              .updatePolicy(newList);
                                        }
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                    const Expanded(child: Divider())
                                  ],
                                )
                              ],
                            );
                          } else if (specState is SpecError) {
                            return Center(child: Text(specState.message));
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
        );
      }),
    );
  }
}
