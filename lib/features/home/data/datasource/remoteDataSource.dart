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

  /// لو مش بعت client، هينشئ http.Client تلقائي
  ProductRemoteDataSourceImpl({http.Client? client}) : client = client ?? http.Client();

  /// دالة مساعدة عشان نعمل GET Requests
  Future<List<dynamic>> _getJsonList(String url) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List;
    } else {
      throw Exception("Failed to load data from $url | StatusCode: ${response.statusCode}");
    }
  }

  @override
  Future<List<ProductModel>> getProducts({int limit = 50}) async {
    final data = await _getJsonList('$baseUrl?limit=$limit');
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final encodedCategory = Uri.encodeComponent(category);
    final data = await _getJsonList('$baseUrl/category/$encodedCategory');
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<List<String>> getCategories() async {
    final data = await _getJsonList('$baseUrl/categories');
    return data.map((e) => e.toString()).toList();
  }
}
