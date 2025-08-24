import 'package:ecommerce/features/home/domain/usecase/getCatigories.dart';
import 'package:ecommerce/features/home/domain/usecase/getProduct.dart';
import 'package:ecommerce/features/home/domain/usecase/getProductsbycatigaori.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';


class ProductProvider with ChangeNotifier {
  final GetProducts getProductsUseCase;
  final GetProductsByCategory getProductsByCategoryUseCase;
  final GetCategories getCategoriesUseCase;

  ProductProvider({
    required this.getProductsUseCase,
    required this.getProductsByCategoryUseCase,
    required this.getCategoriesUseCase,
  });

  List<Product> _products = [];
  List<String> _categories = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get products => _products;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Load all products
  Future<void> fetchProducts({int limit = 50}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await getProductsUseCase.call(limit: limit);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load categories
  Future<void> fetchCategories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _categories = await getCategoriesUseCase.call();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load products by category
  Future<void> fetchProductsByCategory(String category) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await getProductsByCategoryUseCase.call(category);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
