import 'package:ecommerce/features/home/domain/repo/product_repo.dart';

import '../entities/product.dart';

class GetProductsByCategory {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  Future<List<Product>> call(String category) async {
    return await repository.getProductsByCategory(category);
  }
}
