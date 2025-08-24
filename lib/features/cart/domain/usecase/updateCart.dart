
import 'package:ecommerce/features/cart/domain/repo/cart_repo.dart';

class UpdateCartQuantity {
  final CartRepository repository;

  UpdateCartQuantity(this.repository);

  Future<void> call(int productId, int quantity) {
    return repository.updateCartQuantity(productId, quantity);
  }
}
