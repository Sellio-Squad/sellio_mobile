import 'package:authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/datasource/fake/fake_create_product_datasource.dart';
import '../../../../domain/entities/create_product_params.dart';
import '../../../../domain/entities/product_item.dart';
import '../../../../domain/repositories/product_repository.dart';
import 'create_product_state.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  final ProductRepository _productRepository;
  final AuthenticationCubit _authCubit;
  final FakeCreateProductDataSource _metadataDataSource;

  CreateProductCubit({
    required ProductRepository productRepository,
    required AuthenticationCubit authCubit,
    required FakeCreateProductDataSource metadataDataSource,
  })  : _productRepository = productRepository,
        _authCubit = authCubit,
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
    _updateForm((state) => state.copyWith(
          categoryId: categoryId,
          subCategoryIds: [],
          subcategories: [], // Clear old subcategories
        ));

    final subcategories =
        await _metadataDataSource.getSubcategories(categoryId);
    _updateForm((state) => state.copyWith(subcategories: subcategories));
  }

  void updateTitle(String title) {
    _updateForm((state) => state.copyWith(title: title));
  }

  void updateDescription(String description) {
    _updateForm((state) => state.copyWith(description: description));
  }

  void updatePrice(double price) {
    _updateForm((state) => state.copyWith(price: price));
  }

  void updateStock(int stock) {
    _updateForm((state) => state.copyWith(stockQuantity: stock));
  }

  void updateMainImage(String path) {
    _updateForm((state) => state.copyWith(mainImagePath: path));
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
      final storeResult = await _productRepository.getOwnerStoreId();

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
      final params = CreateProductParams(
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
    if (state.title.isEmpty) {
      _emitError('Title is required');
      return false;
    }
    if (state.description.isEmpty) {
      _emitError('Description is required');
      return false;
    }
    if (state.mainImagePath == null || state.mainImagePath!.isEmpty) {
      _emitError('Main image is required');
      return false;
    }
    if (state.price <= 0) {
      _emitError('Price must be greater than 0');
      return false;
    }
    if (state.categoryId.isEmpty) {
      _emitError('Category is required');
      return false;
    }
    return true;
  }

  void _emitError(String message) {
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
