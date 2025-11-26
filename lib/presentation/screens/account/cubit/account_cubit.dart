import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellio_mobile/domain/repositories/user_repository.dart';
import 'package:sellio_mobile/presentation/screens/account/cubit/account_state.dart';

import '../../../../core/error/result.dart';

class AccountCubit extends Cubit<AccountState> {
  final UserRepository _repository;

  AccountCubit(this._repository) : super(const AccountInitial());

  Future<void> loadAccountDetails() async {
    emit(const AccountLoading());
    final result = await _repository.getUserProfile();
    if (result is Success) {
      emit(AccountLoaded(
          firstName: result.data.firstName,
          lastName: result.data.lastName,
          email: result.data.email,
        imagePath: result.data.avatarUrl,
        notificationsEnabled: true,
      )
      );
    } else {
      final errorMessage = _extractErrorMessage([result]);
      emit(AccountError(message: errorMessage));
    }
  }

  void toggleNotifications(bool enabled) {
    if (state is AccountLoaded) {
      final currentState = state as AccountLoaded;
      emit(currentState.copyWith(notificationsEnabled: enabled));

      // _repository.updateNotificationSettings(enabled);
    }
  }

  Future<void> updateProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      emit(const AccountLoading());

      final uploadResult = await _repository.uploadProfilePhoto(pickedFile.path);
      if (uploadResult is Success) {
        final updateResult = await _repository.updateUserProfile(avatarUrl: uploadResult.data);

        if (updateResult is Success) {
          emit(AccountLoaded(
            firstName: updateResult.data.firstName,
            lastName: updateResult.data.lastName,
            email: updateResult.data.email,
            imagePath: updateResult.data.avatarUrl,
          ));

        } else {
          final errorMessage = _extractErrorMessage([updateResult]);
          emit(AccountError(message: errorMessage));
        }
      } else {
        final errorMessage = _extractErrorMessage([uploadResult]);
        emit(AccountError(message: errorMessage));
        // emit(AvatarNotUploaded());
      }
    }

  }

  String _extractErrorMessage(List<Result> results) {
    for (final r in results) {
      if (r is ResultFailure) {
        return r.failure.message;
      }
    }
    return 'Something went wrong';
  }

}
