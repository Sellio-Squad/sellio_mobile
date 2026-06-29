import 'package:authentication/authentication.dart';
import 'package:core/error/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/presentation/screens/account/delete_account/cubit/delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  DeleteAccountCubit({
    required UserRepository userRepository,
    required AuthRepository authRepository,
  })  : _userRepository = userRepository,
        _authRepository = authRepository,
        super(DeleteAccountInitial());

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());
    final deleteResult = await _userRepository.deleteAccount();

    if (deleteResult is Success) {
      await _authRepository.clearAuthData();
      emit(DeleteAccountSuccess());
    } else if (deleteResult is ResultFailure) {
      emit(DeleteAccountError(message: deleteResult.failure.message));
    }
  }
}
