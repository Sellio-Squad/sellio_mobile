import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/category_repository.dart';
import '../../../domain/repository/store_repository.dart';
import 'cubit/create_store_cubit.dart';
import 'cubit/create_store_state.dart';
import 'widget/create_store_body.dart';
import 'widget/create_store_listeners.dart';

class CreateStoreScreen extends StatelessWidget {
  const CreateStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateStoreCubit(
        storeRepository: context.read<StoreRepository>(),
        countryRepository: context.read<CountryRepository>(),
        categoryRepository: context.read<CategoryRepository>(),
        imagePickerService: context.read<ImagePickerService>(),
      )..loadInitialData(),
      child: const _CreateStoreScreenContent(),
    );
  }
}

class _CreateStoreScreenContent extends StatelessWidget {
  const _CreateStoreScreenContent();

  @override
  Widget build(BuildContext context) {
    return CreateStoreListeners(
      child: BlocBuilder<CreateStoreCubit, CreateStoreState>(
        builder: (context, state) {
          final isSubmitting = state is CreateStoreSubmitting;

          return Stack(
            children: [
              GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: const AuthBackgroundWrapper(
                  showLogo: true,
                  showCloseButton: false,
                  child: CreateStoreBody(),
                ),
              ),
              if (isSubmitting)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
