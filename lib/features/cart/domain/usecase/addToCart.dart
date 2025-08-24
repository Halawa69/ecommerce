import 'package:ecommerce/features/cart/domain/entites/cart.dart';
import 'package:ecommerce/features/cart/domain/repo/cart_repo.dart';

class AddToCart {
  final CartRepository repository;

  AddToCart(this.repository);

  Future<void> call(Cart cart) async {
    return await repository.insertCart(cart);
  }
}
