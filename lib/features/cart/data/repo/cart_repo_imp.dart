// features/cart/data/repositories/cart_repo_impl.dart
import 'package:ecommerce/features/cart/data/datasource/cart_dataSource.dart';
import 'package:ecommerce/features/cart/domain/entites/cart.dart';
import 'package:ecommerce/features/cart/domain/repo/cart_repo.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl(this.localDataSource);

  @override
  Future<void> insertCart(Cart cart) async {
    final cartModel = CartModel.fromEntity(cart);
    await localDataSource.insertCart(cartModel);
  }

  @override
  Future<List<Cart>> getCartItems() async {
    final result = await localDataSource.getCartItems();
    return result; // Already List<CartModel> extends Cart
  }

  @override
  Future<void> updateCartQuantity(int productId, int quantity) async {
    await localDataSource.updateCartQuantity(productId, quantity);
  }

  @override
  Future<void> deleteCartItem(int productId) async {
    await localDataSource.deleteCartItem(productId);
  }

  @override
  Future<void> clearCart() async {
    await localDataSource.clearCart();
  }
}
