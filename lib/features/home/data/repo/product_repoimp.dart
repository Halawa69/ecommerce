import 'package:ecommerce/features/home/data/datasource/remoteDataSource.dart';
import 'package:ecommerce/features/home/domain/entities/product.dart';
import 'package:ecommerce/features/home/domain/repo/product_repo.dart';

import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(ProductRemoteDataSource productApiService, {required this.remoteDataSource});

  @override
  Future<List<Product>> getProducts({int limit = 50}) async {
    final List<ProductModel> models = await remoteDataSource.getProducts(limit: limit);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    final List<ProductModel> models = await remoteDataSource.getProductsByCategory(category);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<String>> getCategories() async {
    return await remoteDataSource.getCategories();
  }
}
