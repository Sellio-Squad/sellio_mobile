import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('sellio.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const textTypeNullable = 'TEXT';
    const intType = 'INTEGER NOT NULL';
    const realType = 'REAL NOT NULL';
    const boolType = 'INTEGER NOT NULL';

    // Products table
    await db.execute('''
      CREATE TABLE products (
        id $idType,
        name $textType,
        description $textType,
        price $realType,
        currency $textType,
        discount $textTypeNullable,
        storeId $textType,
        categoryId $textType,
        isAvailable $boolType,
        stockQuantity $intType,
        isFavorite $boolType
      )
    ''');

    // Product Images table
    await db.execute('''
      CREATE TABLE product_images (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId $textType,
        imageUrl $textType,
        FOREIGN KEY (productId) REFERENCES products (id) ON DELETE CASCADE
      )
    ''');

    // Stores table
    await db.execute('''
      CREATE TABLE stores (
        id $idType,
        name $textType,
        description $textType,
        coverImage $textType,
        profileImage $textType,
        sale $textTypeNullable,
        rating $realType,
        country $textType,
        city $textType,
        latitude $textTypeNullable,
        longitude $textTypeNullable,
        isActive $boolType,
        isFavorite $boolType
      )
    ''');

    // Store Categories table
    await db.execute('''
      CREATE TABLE store_categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        storeId $textType,
        categoryId $textType,
        categoryName $textType,
        FOREIGN KEY (storeId) REFERENCES stores (id) ON DELETE CASCADE
      )
    ''');

    // Store Contact Info table
    await db.execute('''
      CREATE TABLE store_contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        storeId $idType,
        provider $textType,
        type $textType,
        FOREIGN KEY (storeId) REFERENCES stores (id) ON DELETE CASCADE
      )
    ''');

    // Categories table
    await db.execute('''
      CREATE TABLE categories (
        id $idType,
        name $textType
      )
    ''');

    // Cart table
    await db.execute('''
      CREATE TABLE cart (
        id $idType,
        userId $textType,
        totalPrice $realType
      )
    ''');

    // Cart Items table
    await db.execute('''
      CREATE TABLE cart_items (
        id $idType,
        cartId $textType,
        productId $textType,
        productName $textType,
        productImage $textType,
        price $realType,
        quantity $intType,
        currency $textType,
        FOREIGN KEY (cartId) REFERENCES cart (id) ON DELETE CASCADE
      )
    ''');

    // User table
    await db.execute('''
      CREATE TABLE users (
        id $idType,
        fullName $textType,
        phoneNumber $textType,
        countryCode $textType,
        profilePhotoUrl $textTypeNullable,
        country $textType,
        city $textType,
        latitude $textTypeNullable,
        longitude $textTypeNullable
      )
    ''');

    // Auth Tokens table
    await db.execute('''
      CREATE TABLE auth_tokens (
        id INTEGER PRIMARY KEY CHECK (id = 1),
        token $textType,
        refreshToken $textTypeNullable,
        expiresAt $intType
      )
    ''');

    // Favorite Products table
    await db.execute('''
      CREATE TABLE favorite_products (
        productId $idType
      )
    ''');

    // Favorite Stores table
    await db.execute('''
      CREATE TABLE favorite_stores (
        storeId $idType
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database migrations here
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> clearDatabase() async {
    final db = await instance.database;
    await db.delete('products');
    await db.delete('product_images');
    await db.delete('stores');
    await db.delete('store_categories');
    await db.delete('store_contacts');
    await db.delete('categories');
    await db.delete('cart');
    await db.delete('cart_items');
    await db.delete('favorite_products');
    await db.delete('favorite_stores');
  }
}
