import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/repositories/user_repository.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(const UserInitial());

  Future<void> loadUserInfo() async {
    emit(const UserLoading());
    try {
      final userResult = await _userRepository.getUserProfile();

      final user = userResult.data;
      emit(UserLoaded(
        name: user.firstName,
        location: '${user.address.city}, ${user.address.country}',
      ));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? country,
    String? city,
    String? avatarUrl,
  }) async {
    try {
      await _userRepository.updateUserProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        country: country,
        city: city,
        avatarUrl: avatarUrl,
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
