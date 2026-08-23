import 'dart:async';

import 'package:authentication/presentation/cubits/auth/authentication_cubit.dart';
import 'package:authentication/presentation/cubits/auth/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repository/store_repository.dart';
import 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final StoreRepository _storeRepository;
  final AuthenticationCubit _authCubit;
  StreamSubscription? _authSubscription;

  StoreCubit(this._storeRepository, this._authCubit)
      : super(const StoreInitial()) {
    _authSubscription = _authCubit.stream.listen((authState) {
      if (authState is LoggedIn) {
        checkStoreExistence();
      } else if (authState is Guest || authState is RequireLogin) {
        emit(const StoreInitial());
      }
    });

    if (_authCubit.state is LoggedIn) {
      checkStoreExistence();
    }
  }

  Future<void> checkStoreExistence({bool force = false}) async {
    if (!force &&
        (state is StoreLoading ||
            state is StoreLoaded ||
            state is StoreNotFound)) {
      return;
    }

    emit(const StoreLoading());

    final result = await _storeRepository.getStoreId();

    result.fold(
      onSuccess: (id) {
        if (id.isNotEmpty) {
          emit(StoreLoaded(id));
        } else {
          emit(const StoreNotFound());
        }
      },
      onFailure: (failure) {
        if (failure.code == 'STORE_004') {
          emit(const StoreNotFound());
        } else {
          emit(StoreError(failure.message));
        }
      },
    );
  }

  void setStoreLoaded(String storeId) {
    emit(StoreLoaded(storeId));
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
