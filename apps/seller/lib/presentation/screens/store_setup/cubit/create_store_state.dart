import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entity/category.dart';
import '../../../../domain/entity/store_seller.dart';
import '../../../../domain/validators/store_validation_error.dart';

sealed class CreateStoreState extends Equatable {
  const CreateStoreState();

  @override
  List<Object?> get props => [];
}

class CreateStoreIdle extends CreateStoreState {
  final String storeName;
  final String description;
  final String city;
  final Country? selectedCountry;
  final List<String> cities;
  final List<Category> allCategories;
  final List<Category> selectedCategories;
  final File? storeImage;
  final File? coverImage;

  final StoreValidationError? nameError;
  final StoreValidationError? descriptionError;
  final StoreValidationError? cityError;
  final StoreValidationError? countryError;
  final StoreValidationError? imageError;
  final StoreValidationError? coverImageError;

  final bool isFormValid;

  const CreateStoreIdle({
    this.storeName = '',
    this.description = '',
    this.city = '',
    this.selectedCountry,
    this.cities = const [],
    this.allCategories = const [],
    this.selectedCategories = const [],
    this.storeImage,
    this.coverImage,
    this.nameError,
    this.descriptionError,
    this.cityError,
    this.countryError,
    this.imageError,
    this.coverImageError,
    this.isFormValid = false,
  });

  CreateStoreIdle copyWith({
    String? storeName,
    String? description,
    String? city,
    Country? selectedCountry,
    List<String>? cities,
    List<Category>? allCategories,
    List<Category>? selectedCategories,
    File? storeImage,
    File? coverImage,
    StoreValidationError? Function()? nameError,
    StoreValidationError? Function()? descriptionError,
    StoreValidationError? Function()? cityError,
    StoreValidationError? Function()? countryError,
    StoreValidationError? Function()? imageError,
    StoreValidationError? Function()? coverImageError,
    bool? isFormValid,
  }) {
    return CreateStoreIdle(
      storeName: storeName ?? this.storeName,
      description: description ?? this.description,
      city: city ?? this.city,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      cities: cities ?? this.cities,
      allCategories: allCategories ?? this.allCategories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      storeImage: storeImage ?? this.storeImage,
      coverImage: coverImage ?? this.coverImage,
      nameError: nameError != null ? nameError() : this.nameError,
      descriptionError:
          descriptionError != null ? descriptionError() : this.descriptionError,
      cityError: cityError != null ? cityError() : this.cityError,
      countryError: countryError != null ? countryError() : this.countryError,
      imageError: imageError != null ? imageError() : this.imageError,
      coverImageError:
          coverImageError != null ? coverImageError() : this.coverImageError,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<Object?> get props => [
        storeName,
        description,
        city,
        selectedCountry,
        cities,
        allCategories,
        selectedCategories,
        storeImage,
        coverImage,
        nameError,
        descriptionError,
        cityError,
        countryError,
        imageError,
        coverImageError,
        isFormValid,
      ];
}

class CreateStoreSubmitting extends CreateStoreState {
  const CreateStoreSubmitting();
}

class CreateStoreSuccess extends CreateStoreState {
  final StoreSeller store;

  const CreateStoreSuccess(this.store);

  @override
  List<Object?> get props => [store];
}

class CreateStoreFailure extends CreateStoreState {
  final String errorMessage;

  const CreateStoreFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
