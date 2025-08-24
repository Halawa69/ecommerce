
import 'package:ecommerce/features/cart/domain/repo/cart_repo.dart';

class ClearCart {
  final CartRepository repository;

  ClearCart(this.repository);

  Future<void> call() {
    return repository.clearCart();
  }
}
