import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/error/result.dart';
import 'package:sellio_mobile/domain/repositories/user_repository.dart';

import 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final UserRepository _userRepository;

  DeleteAccountCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(DeleteAccountInitial());

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());
    final deleteResult = await _userRepository.deleteAccount();
    if (deleteResult is Success) {
      emit(DeleteAccountSuccess());
    } else if (deleteResult is ResultFailure) {
      emit(DeleteAccountError(message: deleteResult.failure.message));
    }
  }
}
