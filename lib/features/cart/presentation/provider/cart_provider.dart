import 'package:ecommerce/features/cart/domain/entites/cart.dart';
import 'package:ecommerce/features/cart/domain/usecase/ClearFromCart.dart';
import 'package:ecommerce/features/cart/domain/usecase/DeleteFromCart.dart';
import 'package:ecommerce/features/cart/domain/usecase/addToCart.dart';
import 'package:ecommerce/features/cart/domain/usecase/getFromCart.dart';
import 'package:ecommerce/features/cart/domain/usecase/updateCart.dart';
import 'package:ecommerce/features/home/domain/entities/product.dart';
import 'package:flutter/material.dart';
class CartProvider with ChangeNotifier {
  final AddToCart addToCartUseCase;
  final GetCartItems getCartItemsUseCase;
  final UpdateCartQuantity updateCartQuantityUseCase;
  final DeleteCartItem deleteCartItemUseCase;
  final ClearCart clearCartUseCase;

  List<Cart> _items = [];

  List<Cart> get items => _items;

  CartProvider({
    required this.addToCartUseCase,
    required this.getCartItemsUseCase,
    required this.updateCartQuantityUseCase,
    required this.deleteCartItemUseCase,
    required this.clearCartUseCase,
  }) {
    loadCart();
  }

  Future<void> loadCart() async {
    _items = await getCartItemsUseCase();
    notifyListeners();
  }

  Future<void> addToCart(Cart cart) async {
    await addToCartUseCase(cart);
    await loadCart();
  }
  Future<void> addToCartFromProduct(Product product) async {
    final cart = Cart(
      productId: product.id,
      name: product.name,
      price: product.price,
      imageUrl: product.imageUrl,
      quantity: 1,
      id: null,
    );

    await addToCartUseCase(cart);
    await loadCart();
  }

  Future<void> increaseQuantity(int productId) async {
    final item = _items.firstWhere((i) => i.productId == productId);
    await updateCartQuantityUseCase(productId, item.quantity + 1);
    await loadCart();
  }

  Future<void> decreaseQuantity(int productId) async {
    final item = _items.firstWhere((i) => i.productId == productId);
    if (item.quantity > 1) {
      await updateCartQuantityUseCase(productId, item.quantity - 1);
    } else {
      await removeItem(productId);
    }
    await loadCart();
  }

  Future<void> removeItem(int productId) async {
    await deleteCartItemUseCase(productId);
    await loadCart();
  }

  Future<void> clearCart() async {
    await clearCartUseCase();
    await loadCart();
  }

  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }
}
