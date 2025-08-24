import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts({int limit = 50});
  Future<List<Product>> getProductsByCategory(String category);
  Future<List<String>> getCategories();
}
