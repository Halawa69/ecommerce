// features/cart/domain/usecases/delete_cart_item.dart
import 'package:ecommerce/features/cart/domain/repo/cart_repo.dart';

class DeleteCartItem {
  final CartRepository repository;

  DeleteCartItem(this.repository);

  Future<void> call(int productId) {
    return repository.deleteCartItem(productId);
  }
}
