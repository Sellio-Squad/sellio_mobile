import 'package:equatable/equatable.dart';

sealed class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();
  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {
  const UserLoading();
  @override
  List<Object?> get props => [];
}

class UserLoaded extends UserState {
  final String name;
  final String? location;

  const UserLoaded({
    required this.name,
    this.location,
  });

  @override
  List<Object?> get props => [name, location];
}

class UserError extends UserState {
  final String message;
  const UserError({required this.message});
  @override
  List<Object?> get props => [message];
}
