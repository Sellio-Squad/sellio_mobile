import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/domain/entities/address.dart';
import 'package:sellio_mobile/domain/entities/user.dart';

import 'BottomSheetType.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());

  Future<void> loadProfileData() async {
    final currentUser = User(id: '1', fullName: 'Hamsa',email: 'Hamsa2025@gmail.com', phoneNumber: '1012314451', countryCode: '+20', address: Address(city: 'Cairo', country: 'Egypt',id: '1'));
    emit(AccountLoaded(userProfile: currentUser));
  }

  void showBottomSheet(BottomSheetType type) {
    if (state is AccountLoaded) {
      final currentState = state as AccountLoaded;
      emit(currentState.copyWith(activeBottomSheet: type));
    }
  }
  void hideBottomSheet() {
    if (state is AccountLoaded) {
      final currentState = state as AccountLoaded;
      emit(currentState.copyWith(activeBottomSheet: BottomSheetType.none));
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
      emit(currentState.copyWith(selectedLanguage: language));
    }
  }
  Future<void> updateAccountSettings({
    required String fullName,
    required String email,
  }) async {
    if (state is AccountLoaded) {
      final currentState = state as AccountLoaded;
      emit(AccountActionLoading(previousState: currentState));

      try {
        await Future.delayed(const Duration(seconds: 1));

        final updatedUser = currentState.userProfile.copyWith(fullName: fullName, email: email,);

        emit(currentState.copyWith(userProfile: updatedUser, activeBottomSheet: BottomSheetType.none));
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
        await Future.delayed(const Duration(seconds: 1));
        emit(const AccountInitial());
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
        await Future.delayed(const Duration(seconds: 1));
        emit(const AccountInitial());
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
        await Future.delayed(const Duration(seconds: 1));
        emit(currentState.copyWith(activeBottomSheet: BottomSheetType.none));
      } catch (e) {
        emit(AccountError(message: e.toString()));
      }
    }
  }


}
