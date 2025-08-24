import 'package:ecommerce/features/cart/domain/entites/cart.dart';

abstract class CartRepository {
  Future<void> insertCart(Cart cart);
  Future<List<Cart>> getCartItems();
  Future<void> updateCartQuantity(int productId, int quantity);
  Future<void> deleteCartItem(int productId);
  Future<void> clearCart();
}
