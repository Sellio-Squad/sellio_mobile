import 'dart:io';

import 'package:core/core.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/store/create_store_request.dart';
import '../../../../domain/entity/category.dart';
import '../../../../domain/repositories/category_repository.dart';
import '../../../../domain/repositories/store_repository.dart';
import '../../../../domain/validators/store_validation_error.dart';
import '../../../../domain/validators/store_validators.dart';
import 'create_store_state.dart';

class CreateStoreCubit extends Cubit<CreateStoreState> {
  final StoreRepository _storeRepository;
  final CountryRepository _countryRepository;
  final CategoryRepository _categoryRepository;
  final ImagePickerService _imagePickerService;
  CreateStoreIdle? _lastIdleState;

  CreateStoreCubit({
    required StoreRepository storeRepository,
    required CountryRepository countryRepository,
    required CategoryRepository categoryRepository,
    required ImagePickerService imagePickerService,
    Country? initialCountry,
  })  : _storeRepository = storeRepository,
        _countryRepository = countryRepository,
        _categoryRepository = categoryRepository,
        _imagePickerService = imagePickerService,
        super(CreateStoreIdle(
          selectedCountry: initialCountry,
        ));

  Future<void> loadInitialData() async {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    await loadCategories();
  }

  Future<void> loadCategories() async {
    final result = await _categoryRepository.getCategories();

    result.fold(
      onSuccess: (categories) {
        final latestState = state;
        if (latestState is CreateStoreIdle) {
          emit(latestState.copyWith(
            allCategories: categories,
            isFormValid: _isFormValid(latestState, allCategories: categories),
          ));
        }
      },
      onFailure: (failure) {},
    );
  }

  Future<void> loadCitiesForSelectedCountry(String iso2) async {
    final result = await _countryRepository.getCitiesByCountryIso2(iso2);

    result.fold(
      onSuccess: (cities) {
        final latestState = state;
        if (latestState is CreateStoreIdle &&
            latestState.selectedCountry?.countryCode.toLowerCase() ==
                iso2.toLowerCase()) {
          final nextState = latestState.copyWith(cities: cities);
          emit(nextState.copyWith(isFormValid: _isFormValid(nextState)));
        }
      },
      onFailure: (e) {
        final latestState = state;
        if (latestState is CreateStoreIdle) {
          final nextState = latestState.copyWith(cities: []);
          emit(nextState.copyWith(isFormValid: _isFormValid(nextState)));
        }
      },
    );
  }

  void updateStoreName(String value) {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final result = StoreValidators.validateName(value);
    final error = result.error as StoreValidationError?;

    emit(currentState.copyWith(
      storeName: value,
      nameError: () => error,
      isFormValid: _isFormValid(currentState, name: value, nError: error),
    ));
  }

  void updateDescription(String value) {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final result = StoreValidators.validateDescription(value);
    final error = result.error as StoreValidationError?;

    emit(currentState.copyWith(
      description: value,
      descriptionError: () => error,
      isFormValid: _isFormValid(currentState, desc: value, dError: error),
    ));
  }

  void updateCity(String value) {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final result = StoreValidators.validateCity(value);
    final error = result.error as StoreValidationError?;

    emit(currentState.copyWith(
      city: value,
      cityError: () => error,
      isFormValid: _isFormValid(currentState, city: value, cError: error),
    ));
  }

  void toggleCategory(Category category) {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final isSelected =
        currentState.selectedCategories.any((c) => c.id == category.id);
    final newSelection = isSelected ? <Category>[] : [category];

    emit(currentState.copyWith(
      selectedCategories: newSelection,
      isFormValid: _isFormValid(currentState, categories: newSelection),
    ));
  }

  void updateSelectedCountry(Country country) {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final nextState = currentState.copyWith(
      selectedCountry: country,
      city: '',
      cityError: () => null,
      countryError: () => null,
    );
    emit(nextState.copyWith(isFormValid: _checkStrictFormValidity(nextState)));
    loadCitiesForSelectedCountry(country.countryCode);
  }

  void validateStoreNameOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final result = StoreValidators.validateName(value);
    emit(currentState.copyWith(
      nameError: () => result.error as StoreValidationError?,
    ));
  }

  void validateDescriptionOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final result = StoreValidators.validateDescription(value);
    emit(currentState.copyWith(
      descriptionError: () => result.error as StoreValidationError?,
    ));
  }

  void validateCityOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final result = StoreValidators.validateCity(value);
    emit(currentState.copyWith(
      cityError: () => result.error as StoreValidationError?,
    ));
  }

  Future<void> pickStoreImage() async {
    final image = await _imagePickerService.pickFromGallery();
    if (image == null) return;

    final result = StoreValidators.validateImage(image);
    final error = result.error as StoreValidationError?;
    final latestState = state;

    if (latestState is CreateStoreIdle) {
      emit(latestState.copyWith(
        storeImage: image,
        imageError: () => error,
        isFormValid: _isFormValid(latestState, sImage: image, iError: error),
      ));
    }
  }

  Future<void> pickCoverImage() async {
    final image = await _imagePickerService.pickFromGallery();
    if (image == null) return;

    final result = StoreValidators.validateCoverImage(image);
    final error = result.error as StoreValidationError?;
    final latestState = state;

    if (latestState is CreateStoreIdle) {
      emit(latestState.copyWith(
        coverImage: image,
        coverImageError: () => error,
        isFormValid: _isFormValid(latestState, cImage: image, cvError: error),
      ));
    }
  }

  bool _isFormValid(
    CreateStoreIdle s, {
    String? name,
    String? desc,
    String? city,
    List<Category>? categories,
    File? sImage,
    File? cImage,
    StoreValidationError? nError,
    StoreValidationError? dError,
    StoreValidationError? cError,
    StoreValidationError? iError,
    StoreValidationError? cvError,
    List<Category>? allCategories,
  }) {
    return (name ?? s.storeName).isNotEmpty &&
        (desc ?? s.description).isNotEmpty &&
        (city ?? s.city).isNotEmpty &&
        s.selectedCountry != null &&
        (categories ?? s.selectedCategories).isNotEmpty &&
        (sImage ?? s.storeImage) != null &&
        (cImage ?? s.coverImage) != null &&
        (nError ?? s.nameError) == null &&
        (dError ?? s.descriptionError) == null &&
        (cError ?? s.cityError) == null &&
        (iError ?? s.imageError) == null &&
        (cvError ?? s.coverImageError) == null;
  }

  bool _checkStrictFormValidity(CreateStoreIdle s) {
    return s.storeName.isNotEmpty &&
        s.description.isNotEmpty &&
        s.city.isNotEmpty &&
        s.selectedCountry != null &&
        s.selectedCategories.isNotEmpty &&
        s.storeImage != null &&
        s.coverImage != null &&
        s.nameError == null &&
        s.descriptionError == null &&
        s.cityError == null &&
        s.imageError == null &&
        s.coverImageError == null;
  }

  Future<void> createStore() async {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    _lastIdleState = currentState;

    final nameResult = StoreValidators.validateName(currentState.storeName);
    final descriptionResult =
        StoreValidators.validateDescription(currentState.description);
    final cityResult = StoreValidators.validateCity(currentState.city);
    final countryResult =
        StoreValidators.validateCountry(currentState.selectedCountry?.name);
    final imageResult = StoreValidators.validateImage(currentState.storeImage);
    final coverImageResult =
        StoreValidators.validateCoverImage(currentState.coverImage);

    if (!nameResult.isValid ||
        !descriptionResult.isValid ||
        !cityResult.isValid ||
        !countryResult.isValid ||
        !imageResult.isValid ||
        !coverImageResult.isValid) {
      final nextState = currentState.copyWith(
        nameError: () => nameResult.error as StoreValidationError?,
        descriptionError: () =>
            descriptionResult.error as StoreValidationError?,
        cityError: () => cityResult.error as StoreValidationError?,
        countryError: () => countryResult.error as StoreValidationError?,
        imageError: () => imageResult.error as StoreValidationError?,
        coverImageError: () => coverImageResult.error as StoreValidationError?,
      );
      emit(
          nextState.copyWith(isFormValid: _checkStrictFormValidity(nextState)));
      return;
    }

    emit(const CreateStoreSubmitting());

    final request = CreateStoreRequest(
      name: currentState.storeName.trim(),
      description: currentState.description.trim(),
      city: currentState.city,
      country: currentState.selectedCountry!.name,
      categoryIds: currentState.selectedCategories.map((c) => c.id).toList(),
      avatarImage: currentState.storeImage!,
      coverImage: currentState.coverImage!,
    );

    final result = await _storeRepository.createStore(request);

    result.fold(
      onSuccess: (store) {
        emit(CreateStoreSuccess(store));
      },
      onFailure: (failure) {
        emit(CreateStoreFailure(failure.message));
        final nextState = currentState.copyWith(
          nameError: () => null,
          descriptionError: () => null,
          cityError: () => null,
          imageError: () => null,
          coverImageError: () => null,
        );
        emit(nextState.copyWith(
            isFormValid: _checkStrictFormValidity(nextState)));
      },
    );
  }

  void resetToIdle() {
    if (state is CreateStoreIdle) return;
    if (_lastIdleState != null) {
      emit(_lastIdleState!);
    }
  }
}
