import 'dart:convert';
import 'package:ecommerce/features/home/data/models/product_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({int limit = 50});
  Future<List<ProductModel>> getProductsByCategory(String category);
  Future<List<String>> getCategories();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  static const String baseUrl = "https://fakestoreapi.com/products";
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts({int limit = 50}) async {
    final response = await client.get(Uri.parse('$baseUrl?limit=$limit'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final encodedCategory = Uri.encodeComponent(category);
    final response = await client.get(Uri.parse('$baseUrl/category/$encodedCategory'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch products by category');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    final response = await client.get(Uri.parse('$baseUrl/categories'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => e.toString()).toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }
}
