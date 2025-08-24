

import 'package:ecommerce/features/cart/domain/entites/cart.dart';
import 'package:ecommerce/features/cart/domain/repo/cart_repo.dart';

class GetCartItems {
  final CartRepository repository;

  GetCartItems(this.repository);

  Future<List<Cart>> call() {
    return repository.getCartItems();
  }
}
