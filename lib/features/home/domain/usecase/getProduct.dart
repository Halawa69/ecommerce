import 'package:ecommerce/features/home/domain/repo/product_repo.dart';

import '../entities/product.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<List<Product>> call({int limit = 50}) async {
    return await repository.getProducts(limit: limit);
  }
}
