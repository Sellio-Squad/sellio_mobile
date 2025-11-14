import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/app_management/route/routing.dart';
import '../cubits/form/create_account_form_cubit.dart';

// Form submission handler
void handleCreateAccountSubmit(BuildContext context) {
  context.read<CreateAccountFormCubit>().submitForm();
}

void navigateToLogin(BuildContext context) {
  context.navigator.replaceWithLogin();
}

bool isValidEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

bool isValidPhoneNumber(String phoneNumber) {
  return phoneNumber.isNotEmpty &&
      phoneNumber.length >= 10 &&
      RegExp(r'^[0-9]+$').hasMatch(phoneNumber);
}

void unfocusAllFields(BuildContext context) {
  FocusScope.of(context).unfocus();
}