import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller/core/localization/l10n/localization_service.dart';
import 'package:seller/core/navigate/navigation_extensions.dart';

import '../cubit/create_store_cubit.dart';
import '../cubit/create_store_state.dart';

class CreateStoreListeners extends StatelessWidget {
  final Widget child;

  const CreateStoreListeners({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateStoreCubit, CreateStoreState>(
      listener: (context, state) {
        if (state is CreateStoreSuccess) {
          _handleSuccess(context);
        } else if (state is CreateStoreFailure) {
          _handleError(context, state);
        }
      },
      child: child,
    );
  }

  void _handleSuccess(BuildContext context) {
    SnackBarHelper.showSuccess(
      context,
      context.local.store_created_successfully,
      title: context.local.success,
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      if (context.mounted) {
        context.navigator.goToDashboard();
      }
    });
  }

  void _handleError(BuildContext context, CreateStoreFailure state) {
    SnackBarHelper.showError(
      context,
      state.errorMessage,
      title: context.local.error,
    );
  }
}
