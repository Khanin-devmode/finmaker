import 'package:finmaker/features/common/widgets/confirm_delete_diaglog.dart';
import 'package:finmaker/features/policies/data/policy_cubit.dart';
import 'package:finmaker/features/policies/data/policy_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PolicyCard extends StatelessWidget {
  final Policy policy;

  const PolicyCard({super.key, required this.policy});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  policy.policyName,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () async {
                      final isConfirm = await confirmDeleteDialog(
                        context,
                        title: 'Confirm delete this policy?',
                      );
                      if (isConfirm == true && context.mounted) {
                        context
                            .read<PolicyCubit>()
                            .deletePolicy(policy.clientId, policy.id as String);
                      }
                    },
                    icon: const Icon(Icons.delete_forever_outlined))
              ],
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
    );
  }
}
