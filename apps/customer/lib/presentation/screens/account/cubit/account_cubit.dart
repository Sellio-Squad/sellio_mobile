import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellio_mobile/domain/repositories/user_repository.dart';
import 'package:sellio_mobile/presentation/cubits/auth/authentication_cubit.dart';
import 'package:sellio_mobile/presentation/screens/account/cubit/account_state.dart';

import '../../../../core/error/result.dart';

class AccountCubit extends Cubit<AccountState> {
  final UserRepository _repository;
  final AuthenticationCubit _authenticationCubit;
  late final StreamSubscription _authenticationSubscription;

  AccountCubit(
      this._repository,
      this._authenticationCubit,
      ) : super(const AccountInitial()) {
    _authenticationSubscription = _authenticationCubit.stream.listen(_onAuthStateChanged);
    _onAuthStateChanged(_authenticationCubit.state);
  }

  void _onAuthStateChanged(AuthenticationState authState) {
    if (authState is LoggedIn) {
      emit(AccountLoaded(
        fullName: authState.user.fullName,
        imagePath: authState.user.avatarUrl,
        notificationsEnabled: true,
      ));
    }
    else if (authState is Guest) {
      emit(const UserNotLoggedIn());
    }
    else if (authState is AuthenticationError) {
      emit(AccountError(message: authState.message));
    }
  }

  Future<void> loadAccountDetails() async {
    _authenticationCubit.loadUserProfile();

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
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      emit(const AccountLoading());

      final uploadResult =
          await _repository.uploadProfilePhoto(pickedFile.path);
      if (uploadResult is Success) {
        _authenticationCubit.loadUserProfile();
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

  @override
  Future<void> close() {
    _authenticationSubscription.cancel();

    return super.close();
  }
}
