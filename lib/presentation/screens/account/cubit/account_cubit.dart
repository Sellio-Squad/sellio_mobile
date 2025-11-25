import 'package:flutter_bloc/flutter_bloc.dart';
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
          imagePath: result.data.avatarUrl
        )
      );
    } else {
      final errorMessage = _extractErrorMessage([result]);
      emit(AccountError(message: errorMessage));
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
