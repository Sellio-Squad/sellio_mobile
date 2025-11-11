import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_management/route/routing.dart';
import 'cubits/form/create_account_form_cubit.dart';
import 'cubits/form/create_account_form_state.dart';

class CreateAccountListeners extends StatelessWidget {
  final Widget child;

  const CreateAccountListeners({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateAccountFormCubit, CreateAccountFormState>(
          listener: _onFormStateChanged,
        ),
      ],
      child: child,
    );
  }

  void _onFormStateChanged(BuildContext context, CreateAccountFormState state) {
    if (state is CreateAccountFormSuccess) {
      context.navigator.pushSignupOtp(
        SignupOtpArgs(
          phoneNumber: state.phoneNumber,
        ),
      );
    } else if (state is CreateAccountFormError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}