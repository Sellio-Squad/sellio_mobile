import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/repositories/user_repository.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(const UserInitial());

  Future<void> loadUserInfo() async {
    emit(const UserLoading());
    try {
      final user = await _userRepository.getUserProfile();
      final address = await _userRepository.getUserAddress();

      emit(UserLoaded(
        name: user.fullName,
        location: '${address.city}, ${address.country}',
      ));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> updateProfile({
    String? fullName,
    String? email,
    String? profilePhotoUrl,
  }) async {
    try {
      await _userRepository.updateUserProfile(
        fullName: fullName,
        email: email,
        profilePhotoUrl: profilePhotoUrl,
      );
      await loadUserInfo();
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> refreshUserInfo() async {
    await loadUserInfo();
  }


}