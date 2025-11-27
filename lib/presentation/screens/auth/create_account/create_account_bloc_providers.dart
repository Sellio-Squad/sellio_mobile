import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/injection_container.dart';
import 'cubits/form/create_account_form_cubit.dart';

class CreateAccountBlocProviders extends StatelessWidget {
  final Widget child;

  const CreateAccountBlocProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<CreateAccountFormCubit>(),
        ),
      ],
      child: child,
    );
  }
}
