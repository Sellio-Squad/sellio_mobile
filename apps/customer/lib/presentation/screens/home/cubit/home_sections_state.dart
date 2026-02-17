import 'package:equatable/equatable.dart';
import '../../../../domain/entities/category_section.dart';

abstract class HomeSectionsState extends Equatable {
  const HomeSectionsState();

  @override
  List<Object?> get props => [];
}

class HomeSectionsInitial extends HomeSectionsState {}

class HomeSectionsLoading extends HomeSectionsState {}

class HomeSectionsLoaded extends HomeSectionsState {
  final List<CategorySection> sections;

  const HomeSectionsLoaded(this.sections);

  @override
  List<Object?> get props => [sections];
}

class HomeSectionsError extends HomeSectionsState {
  final String message;

  const HomeSectionsError(this.message);

  @override
  List<Object?> get props => [message];
}
