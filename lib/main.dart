import 'package:ecommerce/core/database/app_database.dart';
import 'package:ecommerce/core/reuseable/getStart.dart';
import 'package:ecommerce/features/auth/data/datasource/userdatasource.dart';
import 'package:ecommerce/features/auth/data/repo/user_repoimp.dart';
import 'package:ecommerce/features/auth/domain/usecase/checkUser.dart';
import 'package:ecommerce/features/auth/domain/usecase/checkUserLogin.dart';
import 'package:ecommerce/features/auth/domain/usecase/insrtUser.dart';
import 'package:ecommerce/features/auth/presentation/provider/userProvider.dart';
import 'package:ecommerce/features/cart/data/datasource/cart_dataSource.dart';
import 'package:ecommerce/features/cart/data/repo/cart_repo_imp.dart';
import 'package:ecommerce/features/cart/domain/usecase/ClearFromCart.dart';
import 'package:ecommerce/features/cart/domain/usecase/DeleteFromCart.dart';
import 'package:ecommerce/features/cart/domain/usecase/addToCart.dart';
import 'package:ecommerce/features/cart/domain/usecase/getFromCart.dart';
import 'package:ecommerce/features/cart/domain/usecase/updateCart.dart';
import 'package:ecommerce/features/cart/presentation/provider/cart_provider.dart';
import 'package:ecommerce/features/home/data/datasource/remoteDataSource.dart';
import 'package:ecommerce/features/home/data/repo/product_repoimp.dart';
import 'package:ecommerce/features/home/domain/usecase/getCatigories.dart';
import 'package:ecommerce/features/home/domain/usecase/getProduct.dart';
import 'package:ecommerce/features/home/domain/usecase/getProductsbycatigaori.dart';
import 'package:ecommerce/features/home/presentation/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http; // ضيف import

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Database instance
  final db = AppDatabase().database;

  // Local DataSources
  final userLocalDataSource = UserLocalDataSourceImpl(db);
  final cartLocalDataSource = CartLocalDataSourceImpl(db);

  // Repositories
  final userRepository = UserRepositoryImpl(userLocalDataSource);
  final cartRepository = CartRepositoryImpl(cartLocalDataSource);


  // Remote DataSource (API)
  final productApiService = ProductRemoteDataSourceImpl(client: http.Client());
  final productRepository =
      ProductRepositoryImpl(productApiService, remoteDataSource: productApiService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartProvider(
            addToCartUseCase: AddToCart(cartRepository),
            getCartItemsUseCase: GetCartItems(cartRepository),
            updateCartQuantityUseCase: UpdateCartQuantity(cartRepository),
            deleteCartItemUseCase: DeleteCartItem(cartRepository),
            clearCartUseCase: ClearCart(cartRepository),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(
            checkUserUseCase: CheckUser(userRepository),
            checkUserLoginUseCase: CheckUserLogin(userRepository),
            insertUserUseCase: InsertUser(userRepository),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(
            getProductsUseCase: GetProducts(productRepository),
            getProductsByCategoryUseCase: GetProductsByCategory(productRepository),
            getCategoriesUseCase: GetCategories(productRepository),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Getstart(),
    );
  }
}
