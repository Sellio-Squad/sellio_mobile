import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/category_section_repository.dart';
import 'home_sections_state.dart';

class HomeSectionsCubit extends Cubit<HomeSectionsState> {
  final CategorySectionRepository _repository;

  HomeSectionsCubit(this._repository) : super(HomeSectionsInitial());

  Future<void> loadSections() async {
    emit(HomeSectionsLoading());
    final result = await _repository.getActiveSections();
    result.fold(
      onFailure: (failure) => emit(HomeSectionsError(failure.message)),
      onSuccess: (sections) => emit(HomeSectionsLoaded(sections)),
    );
  }
}
