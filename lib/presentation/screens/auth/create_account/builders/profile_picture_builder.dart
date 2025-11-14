import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/form/create_account_form_cubit.dart';
import '../cubits/form/create_account_form_state.dart';
import '../widgets/profile_picture_picker.dart';

Widget buildProfilePictureSection(BuildContext context) {
  return BlocBuilder<CreateAccountFormCubit, CreateAccountFormState>(
    builder: (context, state) {
      if (state is! CreateAccountFormChanged) {
        return const SizedBox.shrink();
      }

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 24),
        child: ProfilePicturePickerWidget(
          selectedImage: state.selectedProfileImage,
          onImageSelected: (image) {
            context.read<CreateAccountFormCubit>().updateProfileImage(image);
          },
        ),
      );
    },
  );
}
