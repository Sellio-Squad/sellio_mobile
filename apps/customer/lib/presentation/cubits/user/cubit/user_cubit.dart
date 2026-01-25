import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/repositories/user_repository.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(const UserInitial());

  Future<void> loadUserInfo() async {
    emit(const UserLoading());

    final userResult = await _userRepository.getUserProfile();

    userResult.fold(
      onSuccess: (user) {
        emit(UserLoaded(
          name: user.fullName,
          location: '${user.address.city}, ${user.address.country}',
        ));
      },
      onFailure: (failure) {
        emit(UserError(message: failure.message ?? 'Failed to load user profile'));
      },
    );
  }

  Future<void> updateProfile({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? country,
    String? city,
    String? avatarUrl,
  }) async {
    try {
      await _userRepository.updateUserProfile(
        fullName: fullName,
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
