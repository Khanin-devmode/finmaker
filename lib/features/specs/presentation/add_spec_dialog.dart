import 'package:finmaker/features/policies/data/active_policy_cubit.dart';
import 'package:finmaker/features/policies/data/policy_model.dart';
import 'package:finmaker/features/specs/data/spec_cubit.dart';
import 'package:finmaker/features/specs/data/spec_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> newSpecDialog(BuildContext context, String activeSpecCode) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AddSpecDialog(
        activeSpecCode: activeSpecCode,
      );
    },
  );
}

class AddSpecDialog extends StatelessWidget {
  AddSpecDialog({super.key, required this.activeSpecCode});

  final String activeSpecCode;

  final _formKey = GlobalKey<FormState>();
  final currentYear = DateTime.now().year + 543;

  @override
  Widget build(
    BuildContext context,
  ) {
    return AlertDialog(
      content: DefaultTabController(
        length: 3,
        child: SizedBox(
          width: 400,
          height: 600,
          child: Column(
            children: [
              const TabBar(tabs: [
                Tab(
                  text: 'one-time',
                ),
                Tab(
                  text: 'period',
                ),
                Tab(
                  text: 'custom',
                )
              ]),
              BlocBuilder<ActivePolicyCubit, Policy?>(
                  builder: (context, state) {
                final activePolicy = state as Policy;
                return Expanded(
                  child: TabBarView(children: [
                    OneTimeSpecForm(
                      activeSpecCode: activeSpecCode,
                      activePolicy: activePolicy,
                    ),
                    const Center(
                      child: Text('period'),
                    ),
                    const Center(
                      child: Text('custom'),
                    ),
                  ]),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class OneTimeSpecForm extends StatefulWidget {
  const OneTimeSpecForm(
      {super.key, required this.activeSpecCode, required this.activePolicy});

  final Policy activePolicy;
  final String activeSpecCode;

  @override
  State<OneTimeSpecForm> createState() => _OneTimeSpecFormState();
}

class _OneTimeSpecFormState extends State<OneTimeSpecForm> {
  final _amountController = TextEditingController();
  final _periodController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isExpenseValue = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //Amount
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Amount'),
            ),
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a number';
              }
              return null;
            },
          ),
          //Period
          TextFormField(
            controller: _periodController,
            decoration: const InputDecoration(
              label: Text('End of Policy Year'),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a number';
              }
              final int? num = int.tryParse(value);
              if (num == null) {
                return 'Please enter a valid number';
              }
              if (num < 0 || num > 100) {
                return 'Add number between 0-100';
              }
              return null;
            },
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ประเภท:',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text('รายจ่าย'),
                      value: true,
                      groupValue: _isExpenseValue,
                      onChanged: (bool? value) {
                        setState(() {
                          _isExpenseValue = value as bool;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text('รายรับ/ผลประโยชน์'),
                      value: false,
                      groupValue: _isExpenseValue,
                      onChanged: (bool? value) {
                        setState(() {
                          _isExpenseValue = value as bool;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              const SizedBox(width: 8),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final double amount =
                          double.tryParse(_amountController.text) ?? 0.0;
                      final int contractYears =
                          int.tryParse(_periodController.text) ?? 0;
                      final int contractMonths = contractYears * 12;

                      final spec = OneTimeSpec(
                        specGroupCode: widget.activeSpecCode,
                        isExpense: _isExpenseValue,
                        contractMonths: contractMonths,
                        amount: amount,
                      );
                      context.read<SpecCubit>().addSpec(
                            widget.activePolicy.clientId,
                            widget.activePolicy.id as String,
                            spec,
                          );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add Spec'))
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _amountController.dispose();
    _periodController.dispose();
    super.dispose();
  }
}
