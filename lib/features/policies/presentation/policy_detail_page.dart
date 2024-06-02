import 'package:finmaker/features/common/widgets/side_bar.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                    child: Text(widget.policyId),
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
