import 'dart:io';
import 'dart:ui' as ui;

import 'package:authentication/domain/entities/address.dart';
import 'package:authentication/domain/repository/auth_repository.dart';
import 'package:authentication/domain/repository/user_repository.dart';
import 'package:authentication/presentation/cubits/auth/authentication_cubit.dart';
import 'package:core/error/result.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sellio_mobile/core/localization/l10n/app_localizations.dart';
import 'package:sellio_mobile/domain/entities/product.dart';
import 'package:sellio_mobile/domain/entities/store.dart';
import 'package:sellio_mobile/domain/repository/favorites_repository.dart';
import 'package:sellio_mobile/domain/repository/store_repository.dart';
import 'package:sellio_mobile/presentation/cubits/favorites/cubit/favorites_cubit.dart';
import 'package:sellio_mobile/presentation/screen/stores/stores_screen.dart';

class FakeAuthRepository implements AuthRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #isLoggedIn) {
      return Future<bool>.value(false);
    }
    return super.noSuchMethod(invocation);
  }
}

class FakeUserRepository implements UserRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeFavoritesRepository implements FavoritesRepository {
  @override
  Future<void> toggleProductFavorite(String productId) async {}

  @override
  Future<void> toggleStoreFavorite(String storeId) async {}

  @override
  Future<Result<List<Product>>> getFavoriteProductsFull() async =>
      const Success([]);

  @override
  Future<Result<List<Store>>> getFavoriteStoresFull() async =>
      const Success([]);
}

class FakeStoreRepository implements StoreRepository {
  @override
  Future<Result<List<Store>>> getStores({
    int page = 1,
    int limit = 20,
  }) async {
    return Success(_sampleStores);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

const List<Store> _sampleStores = [
  Store(
    id: 'store-1',
    name: 'Sunny Store',
    description: 'A sunny store',
    coverImage: '',
    profileImage: '',
    address: Address(country: 'Egypt', city: 'Cairo'),
    contactInfoList: [],
    categories: [],
    isFavorite: false,
  ),
  Store(
    id: 'store-2',
    name: 'Ocean Store',
    description: 'An ocean store',
    coverImage: '',
    profileImage: '',
    address: Address(country: 'Egypt', city: 'Alexandria'),
    contactInfoList: [],
    categories: [],
    isFavorite: false,
  ),
];

final _boundaryKey = GlobalKey();

Widget _buildStoresApp() {
  final authCubit =
      AuthenticationCubit(FakeAuthRepository(), FakeUserRepository());
  return RepaintBoundary(
    key: _boundaryKey,
    child: SellioThemeProvider(
      brightness: Brightness.light,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<StoreRepository>(
              create: (_) => FakeStoreRepository(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<FavoritesCubit>(
                create: (_) => FavoritesCubit(
                  FakeFavoritesRepository(),
                  authCubit,
                ),
              ),
            ],
            child: const StoresScreen(),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('capture StoresScreen screenshot', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_buildStoresApp());
    await tester.pumpAndSettle();

    final boundary =
        tester.renderObject<RenderRepaintBoundary>(find.byKey(_boundaryKey));

    final bytes = await tester.runAsync(() async {
      final image = await boundary.toImage(pixelRatio: 1.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    });

    final screenshotsDir = Directory('screenshots');
    if (!screenshotsDir.existsSync()) {
      screenshotsDir.createSync(recursive: true);
    }

    File('screenshots/stores_screen.png').writeAsBytesSync(bytes!);

    expect(bytes.length, greaterThan(0));
  });
}
