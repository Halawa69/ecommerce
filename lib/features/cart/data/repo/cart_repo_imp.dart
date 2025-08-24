// features/cart/data/repositories/cart_repo_impl.dart
import 'package:ecommerce/features/cart/domain/entites/cart.dart';
import 'package:ecommerce/features/cart/domain/repo/cart_repo.dart';
import 'package:sqflite/sqflite.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final Future<Database> db;

  CartRepositoryImpl(this.db);

  @override
  Future<void> insertCart(Cart cart) async {
    final dbClient = await db;
    final cartModel = CartModel.fromEntity(cart);

    await dbClient.insert(
      'cart',
      cartModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Cart>> getCartItems() async {
    final dbClient = await db;
    final result = await dbClient.query('cart');
    return result.map((map) => CartModel.fromMap(map)).toList();
  }

  @override
  Future<void> updateCartQuantity(int productId, int quantity) async {
    final dbClient = await db;
    await dbClient.update(
      'cart',
      {'quantity': quantity},
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  @override
  Future<void> deleteCartItem(int productId) async {
    final dbClient = await db;
    await dbClient.delete(
      'cart',
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  @override
  Future<void> clearCart() async {
    final dbClient = await db;
    await dbClient.delete('cart');
  }
}
