import 'package:finmaker/features/clients/data/client_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> newClientDialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AddClientDialog();
    },
  );
}

class AddClientDialog extends StatelessWidget {
  AddClientDialog({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();
  final currentYear = DateTime.now().year + 543;

  @override
  Widget build(
    BuildContext context,
  ) {
    return AlertDialog(
      title: const Text('New Client Form'),
      content: BlocBuilder<ClientFormCubit, NewClientFormFields>(
          builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: state.firstName,
                decoration: const InputDecoration(
                  labelText: 'Firstname',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: state.lastName,
                decoration: const InputDecoration(
                  labelText: 'Lastname',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: state.nickName,
                decoration: const InputDecoration(
                  labelText: 'Nickname',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: state.birthDay,
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
                      controller: state.birthMonth,
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
                      controller: state.birthYear,
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
              TextFormField(
                controller: state.age,
                decoration: const InputDecoration(
                  labelText: 'อายุ',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(2)
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (int.parse(value) > 99 || int.parse(value) < 1) {
                    return 'Please enter date range between 1-99';
                  }
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
        );
      }),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Reset Form'),
          onPressed: () {
            // Navigator.of(context).pop();
            context.read<ClientFormCubit>().resetForm();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Add'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {}
          },
        ),
      ],
    );
  }
}
