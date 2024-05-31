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
  const PolicyDetailPage({super.key, required this.policyId});

  final String policyId;

  @override
  State<PolicyDetailPage> createState() => _PolicyDetailPageState();
}

class _PolicyDetailPageState extends State<PolicyDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PolicyCubit>().listenToPolicies(widget.policyId);
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
                          return const SizedBox();
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

class PolicySpecCard extends StatelessWidget {
  final Policy policy;

  const PolicySpecCard({super.key, required this.policy});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                policy.policyName,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                policy.policyNumber,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Policy ID: ${policy.id}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
