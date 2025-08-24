import 'package:ecommerce/features/home/domain/repo/product_repo.dart';


class GetCategories {
  final ProductRepository repository;

  GetCategories(this.repository);

  Future<List<String>> call() async {
    return await repository.getCategories();
  }
}
