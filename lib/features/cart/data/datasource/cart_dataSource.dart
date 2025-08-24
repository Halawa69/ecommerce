import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../../../../core/database/app_database.dart';
import '../models/cart_model.dart';

class CartLocalDataSource {
  final _streamController = StreamController<List<CartModel>>.broadcast();
  Stream<List<CartModel>> get cartStream => _streamController.stream;

  Future<Database> get _db async => await AppDatabase().database;

  Future<int> insertCart(CartModel cart) async {
    final dbClient = await _db;
    final result = await dbClient.insert(
      'cart',
      cart.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await refreshStream();
    return result;
  }

  Future<List<CartModel>> getCartItems() async {
    final dbClient = await _db;
    final maps = await dbClient.query('cart');
    return maps.map((map) => CartModel.fromMap(map)).toList();
  }

  Future<int> updateCartQuantity(int productId, int quantity) async {
    final dbClient = await _db;
    final result = await dbClient.update(
      'cart',
      {'quantity': quantity},
      where: 'productId = ?',
      whereArgs: [productId],
    );
    await refreshStream();
    return result;
  }

  Future<int> deleteCartItem(int productId) async {
    final dbClient = await _db;
    final result = await dbClient.delete(
      'cart',
      where: 'productId = ?',
      whereArgs: [productId],
    );
    await refreshStream();
    return result;
  }

  Future<int> clearCart() async {
    final dbClient = await _db;
    final result = await dbClient.delete('cart');
    await refreshStream();
    return result;
  }

  Future<void> refreshStream() async {
    final dbClient = await _db;
    final cartItems = await dbClient.query('cart');
    _streamController.sink.add(
      cartItems.map((item) => CartModel.fromMap(item)).toList(),
    );
  }

  void dispose() {
    _streamController.close();
  }
}
