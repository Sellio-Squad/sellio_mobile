import 'package:authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/datasource/fake/fake_create_product_datasource.dart';
import '../../../../domain/entity/create_product_params.dart';
import '../../../../domain/entity/product_item.dart';
import '../../../../domain/repository/product_repository.dart';
import '../../../../domain/repository/store_repository.dart';
import '../../../../domain/validators/product_validation_error.dart';
import '../../../../domain/validators/product_validators.dart';
import 'create_product_state.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  final ProductRepository _productRepository;
  final StoreRepository _storeRepository;
  final FakeCreateProductDataSource _metadataDataSource;

  CreateProductCubit({
    required ProductRepository productRepository,
    required StoreRepository storeRepository,
    required AuthenticationCubit authCubit,
    required FakeCreateProductDataSource metadataDataSource,
  })  : _productRepository = productRepository,
        _storeRepository = storeRepository,
        _metadataDataSource = metadataDataSource,
        super(const CreateProductInitial());

  Future<void> initForm() async {
    emit(const CreateProductFormState(isLoadingMetadata: true));

    try {
      final categories = await _metadataDataSource.getCategories();
      final colors = await _metadataDataSource.getColors();
      final sizes = await _metadataDataSource.getSizes();
      final discounts = await _metadataDataSource.getDiscounts();

      emit((state as CreateProductFormState).copyWith(
        categories: categories,
        colors: colors,
        sizes: sizes,
        discounts: discounts,
        isLoadingMetadata: false,
      ));
    } catch (e) {
      emit((state as CreateProductFormState).copyWith(
        isLoadingMetadata: false,
        error: 'Failed to load form data',
      ));
    }
  }

  Future<void> updateCategory(String categoryId) async {
    final result = ProductValidators.validateCategory(categoryId);
    final error = result.error as ProductValidationError?;

    _updateForm((state) => state.copyWith(
          categoryId: categoryId,
          categoryError: () => error,
          subCategoryIds: [],
          subcategories: [], // Clear old subcategories
          isFormValid:
              _isFormValid(state, categoryId: categoryId, cError: error),
        ));

    final subcategories =
        await _metadataDataSource.getSubcategories(categoryId);
    _updateForm((state) => state.copyWith(subcategories: subcategories));
  }

  void updateTitle(String title) {
    final result = ProductValidators.validateTitle(title);
    final error = result.error as ProductValidationError?;

    _updateForm((state) => state.copyWith(
          title: title,
          titleError: () => error,
          isFormValid: _isFormValid(state, title: title, tError: error),
        ));
  }

  void updateDescription(String description) {
    final result = ProductValidators.validateDescription(description);
    final error = result.error as ProductValidationError?;

    _updateForm((state) => state.copyWith(
          description: description,
          descriptionError: () => error,
          isFormValid:
              _isFormValid(state, description: description, dError: error),
        ));
  }

  void updatePrice(double price) {
    final result = ProductValidators.validatePrice(price);
    final error = result.error as ProductValidationError?;

    _updateForm((state) => state.copyWith(
          price: price,
          priceError: () => error,
          isFormValid: _isFormValid(state, price: price, pError: error),
        ));
  }

  void updateStock(int stock) {
    _updateForm((state) => state.copyWith(stockQuantity: stock));
  }

  void updateMainImage(String path) {
    final result = ProductValidators.validateMainImage(path);
    final error = result.error as ProductValidationError?;

    _updateForm((state) => state.copyWith(
          mainImagePath: path,
          imageError: () => error,
          isFormValid: _isFormValid(state, mainImagePath: path, iError: error),
        ));
  }

  void addAdditionalImage(String path) {
    _updateForm((state) => state.copyWith(
          additionalImagePaths: [...state.additionalImagePaths, path],
        ));
  }

  void removeAdditionalImage(String path) {
    _updateForm((state) => state.copyWith(
          additionalImagePaths:
              state.additionalImagePaths.where((p) => p != path).toList(),
        ));
  }

  void toggleFeatured(bool isFeatured) {
    _updateForm((state) => state.copyWith(isFeatured: isFeatured));
  }

  void toggleAvailable(bool isAvailable) {
    _updateForm((state) => state.copyWith(isAvailable: isAvailable));
  }

  void updateSubCategories(List<String> subCategoryIds) {
    _updateForm((state) => state.copyWith(subCategoryIds: subCategoryIds));
  }

  void updateColor(String colorId) {
    _updateForm((state) => state.copyWith(colorId: colorId));
  }

  void updateSize(String sizeId) {
    _updateForm((state) => state.copyWith(sizeId: sizeId));
  }

  void updateWeight(int weightId) {
    _updateForm((state) => state.copyWith(weightId: weightId));
  }

  void updateDiscount(String discountId) {
    _updateForm((state) => state.copyWith(discountId: discountId));
  }

  void addItem(ProductItem item) {
    _updateForm((state) => state.copyWith(
          items: [...state.items, item],
        ));
  }

  void removeItem(int index) {
    _updateForm((state) => state.copyWith(
          items: List.from(state.items)..removeAt(index),
        ));
  }

  void updateItem(int index, ProductItem item) {
    final newItems =
        List<ProductItem>.from((state as CreateProductFormState).items);
    newItems[index] = item;
    _updateForm((state) => state.copyWith(items: newItems));
  }

  Future<void> submit() async {
    final currentState = state;
    if (currentState is! CreateProductFormState) return;

    if (!_validate(currentState)) return;

    emit(currentState.copyWith(isSubmitting: true, error: null));

    try {
      // 0. Get storeId dynamically based on the current user's token
      final storeResult = await _storeRepository.getStoreId();

      String? storeId;
      storeResult.fold(
        onSuccess: (id) => storeId = id,
        onFailure: (failure) {
          throw Exception('Failed to retrieve Store ID: ${failure.message}');
        },
      );

      if (storeId == null) {
        emit(currentState.copyWith(
          isSubmitting: false,
          error:
              'Store ID not found. Please make sure you have a store created.',
        ));
        return;
      }

      // 1. Create items list
      final List<ProductItem> finalItems = List.from(currentState.items);
      if (finalItems.isEmpty) {
        finalItems.add(ProductItem(
          price: currentState.price,
          stock: currentState.stockQuantity,
          weightId: currentState.weightId,
          colorId: currentState.colorId,
          sizeId: currentState.sizeId,
          discountId: currentState.discountId,
        ));
      }

      // 2. Prepare params with file paths for single multipart request
      final params = AddProduct(
        title: currentState.title,
        description: currentState.description,
        mainImagePath: currentState.mainImagePath!,
        storeId: storeId!,
        categoryId: currentState.categoryId,
        price: currentState.price,
        isFeatured: currentState.isFeatured,
        isAvailable: currentState.isAvailable,
        subCategoryIds: currentState.subCategoryIds,
        additionalImagePaths: currentState.additionalImagePaths,
        items: finalItems,
      );

      // 3. Create product (Handles uploads internally via Multipart)
      final result = await _productRepository.createProduct(params);

      result.fold(
        onSuccess: (_) {
          emit(currentState.copyWith(isSubmitting: false, isSuccess: true));
        },
        onFailure: (failure) {
          emit(currentState.copyWith(
            isSubmitting: false,
            error: failure.message,
          ));
        },
      );
    } catch (e) {
      emit(currentState.copyWith(
        isSubmitting: false,
        error: e is Exception
            ? e.toString().replaceFirst('Exception: ', '')
            : e.toString(),
      ));
    }
  }

  bool _validate(CreateProductFormState state) {
    final titleResult = ProductValidators.validateTitle(state.title);
    final descriptionResult =
        ProductValidators.validateDescription(state.description);
    final imageResult =
        ProductValidators.validateMainImage(state.mainImagePath);
    final priceResult = ProductValidators.validatePrice(state.price);
    final categoryResult = ProductValidators.validateCategory(state.categoryId);

    if (!titleResult.isValid ||
        !descriptionResult.isValid ||
        !imageResult.isValid ||
        !priceResult.isValid ||
        !categoryResult.isValid) {
      _updateForm((s) => s.copyWith(
            titleError: () => titleResult.error as ProductValidationError?,
            descriptionError: () =>
                descriptionResult.error as ProductValidationError?,
            imageError: () => imageResult.error as ProductValidationError?,
            priceError: () => priceResult.error as ProductValidationError?,
            categoryError: () =>
                categoryResult.error as ProductValidationError?,
          ));

      // Emit first error as a general error for SnackBar if needed
      final firstError = titleResult.error ??
          descriptionResult.error ??
          imageResult.error ??
          priceResult.error ??
          categoryResult.error;

      if (firstError != null) {
        _emitError(firstError);
      }

      return false;
    }

    return true;
  }

  bool _isFormValid(
    CreateProductFormState s, {
    String? title,
    String? description,
    String? mainImagePath,
    double? price,
    String? categoryId,
    ProductValidationError? tError,
    ProductValidationError? dError,
    ProductValidationError? iError,
    ProductValidationError? pError,
    ProductValidationError? cError,
  }) {
    return (title ?? s.title).isNotEmpty &&
        (description ?? s.description).isNotEmpty &&
        (mainImagePath ?? s.mainImagePath) != null &&
        (price ?? s.price) > 0 &&
        (categoryId ?? s.categoryId).isNotEmpty &&
        (tError ?? s.titleError) == null &&
        (dError ?? s.descriptionError) == null &&
        (iError ?? s.imageError) == null &&
        (pError ?? s.priceError) == null &&
        (cError ?? s.categoryError) == null;
  }

  void _emitError(Object message) {
    if (state is CreateProductFormState) {
      emit((state as CreateProductFormState).copyWith(error: message));
    }
  }

  void _updateForm(
      CreateProductFormState Function(CreateProductFormState) update) {
    if (state is CreateProductFormState) {
      emit(update(state as CreateProductFormState));
    } else {
      emit(update(const CreateProductFormState()));
    }
  }
}
