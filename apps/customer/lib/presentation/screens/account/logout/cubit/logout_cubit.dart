import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/error/result.dart';
import 'package:sellio_mobile/domain/repositories/auth_repository.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepository _authRepository;

  LogoutCubit(this._authRepository) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());

    final result = await _authRepository.logout();

    if (result is Success) {
      emit(LogoutSuccess());
    } else if (result is ResultFailure) {
      emit(LogoutError(message: result.failure.message));
    }
  }
}
