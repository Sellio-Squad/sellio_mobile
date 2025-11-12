import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/form/create_account_form_cubit.dart';

void handleCreateAccountSubmit(BuildContext context) {
  context.read<CreateAccountFormCubit>().submitForm();
}