import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

Future<void> newSpecDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AddSpecDialog();
    },
  );
}

class AddSpecDialog extends StatelessWidget {
  AddSpecDialog({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();
  final currentYear = DateTime.now().year + 543;

  @override
  Widget build(
    BuildContext context,
  ) {
    return const AlertDialog(
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
              Expanded(
                child: TabBarView(children: [
                  OneTimeSpecForm(),
                  const Center(
                    child: Text('period'),
                  ),
                  const Center(
                    child: Text('custom'),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OneTimeSpecForm extends StatefulWidget {
  const OneTimeSpecForm({super.key});

  @override
  State<OneTimeSpecForm> createState() => _OneTimeSpecFormState();
}

class _OneTimeSpecFormState extends State<OneTimeSpecForm> {
  final _amountController = TextEditingController();
  final _periodController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isExpense = false;

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
            decoration: InputDecoration(label: Text('End of Policy Year')),
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
          Row(
            children: [
              Checkbox(
                value: isExpense,
                onChanged: (value) {
                  setState(() {
                    isExpense = value as bool;
                  });
                },
              ),
              Text('Is an expense')
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
                    _formKey.currentState!.validate();
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