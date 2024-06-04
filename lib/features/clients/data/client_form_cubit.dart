import 'package:bloc/bloc.dart';
import 'package:finmaker/features/clients/data/client_model.dart';
import 'package:flutter/widgets.dart';

class ClientFormCubit extends Cubit<NewClientFormFields> {
  ClientFormCubit() : super(NewClientFormFields());

  void resetForm() {
    emit(NewClientFormFields());
  }
}

class NewClientFormFields {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController nickName = TextEditingController();
  TextEditingController martialStatus = TextEditingController();
  TextEditingController birthDay = TextEditingController();
  TextEditingController birthMonth = TextEditingController();
  TextEditingController birthYear = TextEditingController();

  Client toClientObj() {
    return Client(
        firstName: firstName.text,
        lastName: lastName.text,
        nickName: nickName.text,
        dateOfBirth: DateTime.utc(int.parse(birthYear.text) - 543,
            int.parse(birthMonth.text), int.parse(birthDay.text)),
        specGroupsConfig: {
          '001': 'Annual Policy Fee',
          '100': 'Death Coverage',
          '101': 'Cash Benefits',
        });
  }
}
