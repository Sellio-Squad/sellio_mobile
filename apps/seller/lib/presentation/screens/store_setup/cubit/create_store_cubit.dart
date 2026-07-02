import 'package:core/core.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    await Future.wait([
      loadInitialCountry(),
      loadCategories(),
    ]);
  }

  Future<void> loadInitialCountry() async {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final countryCode = await _countryRepository.getCurrentCountryCode();
    final allowedCodes = ['IQ', 'EG', 'SY', 'PS'];

    if (allowedCodes.contains(countryCode.toUpperCase())) {
      final country = Country.parse(countryCode);
      _updateState(currentState.copyWith(selectedCountry: country));
      loadCitiesForSelectedCountry(countryCode);
    }
  }

  Future<void> loadCategories() async {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final result = await _categoryRepository.getCategories();

    result.fold(
      onSuccess: (categories) {
        _updateState(currentState.copyWith(allCategories: categories));
      },
      onFailure: (failure) {
        // Handle failure if needed
      },
    );
  }

  Future<void> loadCitiesForSelectedCountry(String iso2) async {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final result = await _countryRepository.getCitiesByCountryIso2(iso2);

    result.fold(
      onSuccess: (cities) {
        final latestState = state;
        if (latestState is CreateStoreIdle &&
            latestState.selectedCountry?.countryCode == iso2) {
          _updateState(latestState.copyWith(cities: cities));
        }
      },
      onFailure: (e) {
        _updateState(currentState.copyWith(cities: []));
      },
    );
  }

  void updateStoreName(String value) {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final result = StoreValidators.validateName(value);

    _updateState(currentState.copyWith(
      storeName: value,
      nameError: () => result.error as StoreValidationError?,
    ));
  }

  void updateDescription(String value) {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final result = StoreValidators.validateDescription(value);

    _updateState(currentState.copyWith(
      description: value,
      descriptionError: () => result.error as StoreValidationError?,
    ));
  }

  void updateCity(String value) {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final result = StoreValidators.validateCity(value);

    _updateState(currentState.copyWith(
      city: value,
      cityError: () => result.error as StoreValidationError?,
    ));
  }

  void toggleCategory(Category category) {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final isSelected =
        currentState.selectedCategories.any((c) => c.id == category.id);
    final newSelection = isSelected ? <Category>[] : [category];

    _updateState(currentState.copyWith(selectedCategories: newSelection));
  }

  void updateSelectedCountry(Country country) {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    _updateState(currentState.copyWith(
      selectedCountry: country,
      city: '',
      cityError: () => null,
      countryError: () => null,
    ));
    loadCitiesForSelectedCountry(country.countryCode);
  }

  void validateStoreNameOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final result = StoreValidators.validateName(value);
    _updateState(currentState.copyWith(
      nameError: () => result.error as StoreValidationError?,
    ));
  }

  void validateDescriptionOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final result = StoreValidators.validateDescription(value);
    _updateState(currentState.copyWith(
      descriptionError: () => result.error as StoreValidationError?,
    ));
  }

  void validateCityOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final result = StoreValidators.validateCity(value);
    _updateState(currentState.copyWith(
      cityError: () => result.error as StoreValidationError?,
    ));
  }

  Future<void> pickStoreImage() async {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final image = await _imagePickerService.pickFromGallery();
    if (image == null) return;

    final result = StoreValidators.validateImage(image);

    _updateState(currentState.copyWith(
      storeImage: image,
      imageError: () => result.error as StoreValidationError?,
    ));
  }

  Future<void> pickCoverImage() async {
    final currentState = state;
    if (currentState is! CreateStoreIdle) return;

    final image = await _imagePickerService.pickFromGallery();
    if (image == null) return;

    final result = StoreValidators.validateCoverImage(image);

    _updateState(currentState.copyWith(
      coverImage: image,
      coverImageError: () => result.error as StoreValidationError?,
    ));
  }

  void _updateState(CreateStoreIdle newState) {
    emit(newState.copyWith(
      isFormValid: _checkFormValidity(newState),
    ));
  }

  bool _checkFormValidity(CreateStoreIdle s) {
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
      _updateState(currentState.copyWith(
        nameError: () => nameResult.error as StoreValidationError?,
        descriptionError: () =>
            descriptionResult.error as StoreValidationError?,
        cityError: () => cityResult.error as StoreValidationError?,
        countryError: () => countryResult.error as StoreValidationError?,
        imageError: () => imageResult.error as StoreValidationError?,
        coverImageError: () => coverImageResult.error as StoreValidationError?,
      ));
      return;
    }

    emit(const CreateStoreSubmitting());

    final result = await _storeRepository.createStore(
      name: currentState.storeName.trim(),
      description: currentState.description.trim(),
      city: currentState.city,
      country: currentState.selectedCountry!.name,
      categories: currentState.selectedCategories,
      profileImage: currentState.storeImage!,
      coverImage: currentState.coverImage!,
    );

    result.fold(
      onSuccess: (store) {
        emit(CreateStoreSuccess(store));
      },
      onFailure: (failure) {
        emit(CreateStoreFailure(failure.message));
        _updateState(currentState.copyWith(
          nameError: () => null,
          descriptionError: () => null,
          cityError: () => null,
          imageError: () => null,
          coverImageError: () => null,
        ));
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
