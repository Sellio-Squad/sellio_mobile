import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/domain/repositories/auth_repository.dart';
import '../../../../domain/core/failure.dart';
import '../../../../domain/core/result.dart';
import 'BottomSheetType.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AuthRepository _authRepository;

  AccountCubit(this._authRepository) : super(AccountInitial());

  Future<void> loadProfileData() async {
    final result = _authRepository.getCurrentUser();
    switch (result) {
      case Success(data: final user):
        emit(AccountLoaded(userProfile: user));
      case Failure(message: final error):
        emit(AccountError(message: error));
    }
  }

  void showBottomSheet(BottomSheetType type) {
    if (state is AccountLoaded) {
      final currentState = state as AccountLoaded;
      emit(currentState.copyWith(activeBottomSheet: type));
    }
  }
  void toggleNotifications(bool enabled) {
    if (state is AccountLoaded) {
      final currentState = state as AccountLoaded;
      emit(currentState.copyWith(notificationsEnabled: enabled));
    }
  }
  void changeLanguage(String language) {
    if (state is AccountLoaded) {
      final currentState = state as AccountLoaded;
      emit(currentState.copyWith(selectedLanguage: language,activeBottomSheet: BottomSheetType.none));
    }
  }
  Future<void> updateAccountSettings({
    required String fullName,
    required String phone,
    required String countryCode,
  }) async {
    if (state is AccountLoaded) {
      final currentState = state as AccountLoaded;
      emit(AccountActionLoading(previousState: currentState));

      try {
        final updatedUser = currentState.userProfile.copyWith(fullName: fullName, phoneNumber: phone,countryCode: countryCode);
        emit(currentState.copyWith(userProfile: updatedUser,activeBottomSheet: BottomSheetType.none));

      } catch (e) {
        emit(AccountError(message: e.toString()));
      }
    }
  }
  Future<void> logout() async {
    if (state is AccountLoaded) {
      final currentState = state as AccountLoaded;
      emit(AccountActionLoading(previousState: currentState));

      try {
        emit(currentState.copyWith(activeBottomSheet: BottomSheetType.none));
      } catch (e) {
        emit(AccountError(message: e.toString()));
      }
    }
  }

  Future<void> deleteAccount() async {
    if (state is AccountLoaded) {
      final currentState = state as AccountLoaded;
      emit(AccountActionLoading(previousState: currentState));

      try {
        emit(currentState.copyWith(activeBottomSheet: BottomSheetType.none));
      } catch (e) {
        emit(AccountError(message: e.toString()));
      }
    }
  }

  Future<void> resetPassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (state is AccountLoaded) {
      final currentState = state as AccountLoaded;
      emit(AccountActionLoading(previousState: currentState));

      try {
        emit(currentState.copyWith(activeBottomSheet: BottomSheetType.none));
      } catch (e) {
        emit(AccountError(message: e.toString()));
      }
    }
  }


}
