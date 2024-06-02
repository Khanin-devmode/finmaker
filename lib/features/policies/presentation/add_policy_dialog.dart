import 'package:finmaker/features/policies/data/policy_cubit.dart';
import 'package:finmaker/features/policies/data/policy_form_cubit.dart';
import 'package:finmaker/features/policies/data/policy_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> newPolicyDialogBuilder(
    {required BuildContext context, required String clientId}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AddPolicyDialog(clientId: clientId);
    },
  );
}

class AddPolicyDialog extends StatefulWidget {
  const AddPolicyDialog({super.key, required this.clientId});

  final String clientId;

  @override
  State<AddPolicyDialog> createState() => _AddPolicyDialogState();
}

class _AddPolicyDialogState extends State<AddPolicyDialog> {
  final _policyFormKey = GlobalKey<FormState>();
  final currentYear = DateTime.now().year + 543;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PolicyFormCubit, NewPolicyForms>(
        builder: (context, state) {
      return AlertDialog(
        title: const Text('New Policy Form'),
        content: Form(
          key: _policyFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: state.company,
                decoration: const InputDecoration(
                  labelText: 'Policy Company',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: state.name,
                decoration: const InputDecoration(
                  labelText: 'Policy Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: state.number,
                decoration: const InputDecoration(
                  labelText: 'Policy Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const Text('วันที่เริ่มสัญญา'),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: state.startDay,
                      decoration: const InputDecoration(
                        labelText: 'วัน',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(2)
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (int.parse(value) > 31 || int.parse(value) < 1) {
                          return 'Please enter date range between 1-31';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: TextFormField(
                      controller: state.startMonth,
                      decoration: const InputDecoration(
                        labelText: 'เดือน',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(2)
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (int.parse(value) > 12 || int.parse(value) < 1) {
                          return 'Please enter month range between 1-12';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: TextFormField(
                      controller: state.startYear,
                      decoration: const InputDecoration(
                        labelText: 'ปี(พ.ศ.)',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(4)
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (int.parse(value) > currentYear ||
                            int.parse(value) < 2455) {
                          return 'Please enter date range between 2455 - $currentYear';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const Text('วันสิ้นสุดสัญญา'),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: state.endDay,
                      decoration: const InputDecoration(
                        labelText: 'วัน',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(2)
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (int.parse(value) > 31 || int.parse(value) < 1) {
                          return 'Please enter date range between 1-31';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: TextFormField(
                      controller: state.endMonth,
                      decoration: const InputDecoration(
                        labelText: 'เดือน',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(2)
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (int.parse(value) > 12 || int.parse(value) < 1) {
                          return 'Please enter month range between 1-12';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: TextFormField(
                      controller: state.endYear,
                      decoration: const InputDecoration(
                        labelText: 'ปี(พ.ศ.)',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(4)
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (int.parse(value) < 2455) {
                          return 'Please enter date range greater than 2455';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: state.coverage,
                decoration: const InputDecoration(
                  labelText: 'ความคุ้มครอง',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  // if (int.parse(value) > 99 || int.parse(value) < 1) {
                  //   return 'Please enter date range between 1-99';
                  // }
                  return null;
                },
              ),
              TextFormField(
                controller: state.cost,
                decoration: const InputDecoration(
                  labelText: 'เบี้ยประกัน',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  // if (int.parse(value) > 99 || int.parse(value) < 1) {
                  //   return 'Please enter date range between 1-99';
                  // }
                  return null;
                },
              ),
              // DropdownButtonFormField(
              //   items: MartialStatus.values.map((MartialStatus martialStatus) {
              //     return DropdownMenuItem<MartialStatus>(
              //       value: martialStatus,
              //       child: Text(martialStatus.name),
              //     );
              //   }).toList(),
              //   onChanged: (value) {

              //   },
              // )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Reset Form'),
            onPressed: () {
              context.read<PolicyFormCubit>().resetForm();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Add'),
            onPressed: () async {
              if (_policyFormKey.currentState!.validate()) {
                // policyService
                //     .addPolicy(newPolicyForm.toPolicyObj(), selectedClient)
                //     .then((value) {
                //   ref
                //       .read(newPolicyFormProvider.notifier)
                //       .update((state) => NewPolicyForms());
                //   Navigator.pop(context);
                // });

                await context.read<PolicyCubit>().addPolicy(widget.clientId,
                    state.toPolicyObj(clienId: widget.clientId));
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    });
  }
}
