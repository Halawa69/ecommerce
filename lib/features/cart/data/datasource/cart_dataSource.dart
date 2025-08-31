import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../models/cart_model.dart';

/// Table name
const String cartTable = 'cart';

/// -------------------------------
/// DataSource Contract
/// -------------------------------
abstract class CartLocalDataSource {
  Future<int> insertCart(CartModel cart);
  Future<List<CartModel>> getCartItems();
  Future<int> updateCartQuantity(int productId, int quantity);
  Future<int> deleteCartItem(int productId);
  Future<int> clearCart();
  Future<void> refreshStream();
  void dispose();
  Stream<List<CartModel>> get cartStream;
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  CartLocalDataSourceImpl(this.db);
  final Database db;
  
  final _streamController = StreamController<List<CartModel>>.broadcast();
  @override
  Stream<List<CartModel>> get cartStream => _streamController.stream;

  Future<Database> get _db async => await db;

  @override
  Future<int> insertCart(CartModel cart) async {
    final dbClient = await _db;
    final result = await dbClient.insert(
      cartTable,
      cart.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await refreshStream();
    return result;
  }

  @override
  Future<List<CartModel>> getCartItems() async {
    final dbClient = await _db;
    final maps = await dbClient.query(cartTable);
    return maps.map((map) => CartModel.fromMap(map)).toList();
  }

  @override
  Future<int> updateCartQuantity(int productId, int quantity) async {
    final dbClient = await _db;
    final result = await dbClient.update(
      cartTable,
      {'quantity': quantity},
      where: 'productId = ?',
      whereArgs: [productId],
    );
    await refreshStream();
    return result;
  }

  @override
  Future<int> deleteCartItem(int productId) async {
    final dbClient = await _db;
    final result = await dbClient.delete(
      cartTable,
      where: 'productId = ?',
      whereArgs: [productId],
    );
    await refreshStream();
    return result;
  }

  @override
  Future<int> clearCart() async {
    final dbClient = await _db;
    final result = await dbClient.delete(cartTable);
    await refreshStream();
    return result;
  }

  @override
  Future<void> refreshStream() async {
    final dbClient = await _db;
    final cartItems = await dbClient.query(cartTable);
    _streamController.sink.add(
      cartItems.map((item) => CartModel.fromMap(item)).toList(),
    );
  }

  @override
  void dispose() {
    _streamController.close();
  }
}

