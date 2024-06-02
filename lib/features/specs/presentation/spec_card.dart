import 'package:finmaker/features/policies/data/policy_model.dart';
import 'package:flutter/material.dart';

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
