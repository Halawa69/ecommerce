import 'package:ecommerce/features/auth/domain/repo/user_repo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ecommerce/features/cart/domain/repo/cart_repo.dart';
import 'package:ecommerce/features/home/domain/repo/product_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/core/database/app_database.dart';

// DataSources
import 'package:ecommerce/features/auth/data/datasource/userdatasource.dart';
import 'package:ecommerce/features/cart/data/datasource/cart_dataSource.dart';
import 'package:ecommerce/features/home/data/datasource/remoteDataSource.dart';

// Repositories
import 'package:ecommerce/features/auth/data/repo/user_repoimp.dart';
import 'package:ecommerce/features/cart/data/repo/cart_repo_imp.dart';
import 'package:ecommerce/features/home/data/repo/product_repoimp.dart';

// UseCases
import 'package:ecommerce/features/auth/domain/usecase/checkUser.dart';
import 'package:ecommerce/features/auth/domain/usecase/checkUserLogin.dart';
import 'package:ecommerce/features/auth/domain/usecase/insrtUser.dart';

import 'package:ecommerce/features/cart/domain/usecase/addToCart.dart';
import 'package:ecommerce/features/cart/domain/usecase/getFromCart.dart';
import 'package:ecommerce/features/cart/domain/usecase/updateCart.dart';
import 'package:ecommerce/features/cart/domain/usecase/DeleteFromCart.dart';
import 'package:ecommerce/features/cart/domain/usecase/ClearFromCart.dart';

import 'package:ecommerce/features/home/domain/usecase/getProduct.dart';
import 'package:ecommerce/features/home/domain/usecase/getProductsbycatigaori.dart';
import 'package:ecommerce/features/home/domain/usecase/getCatigories.dart';

// Providers
import 'package:ecommerce/features/auth/presentation/provider/userProvider.dart';
import 'package:ecommerce/features/cart/presentation/provider/cart_provider.dart';
import 'package:ecommerce/features/home/presentation/provider/product_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ✅ Database (Future → Lazy Singleton)
  sl.registerSingletonAsync<Database>(() async => await AppDatabase().database);

  // ✅ DataSources
sl.registerSingletonWithDependencies<UserLocalDataSource>(
  () => UserLocalDataSourceImpl(sl()),
  dependsOn: [Database],
);

sl.registerSingletonWithDependencies<CartLocalDataSource>(
  () => CartLocalDataSourceImpl(sl()),
  dependsOn: [Database],
);
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: http.Client()));

// ✅ Repositories
sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(dataSource: sl()));
sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(sl()));
sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl(), remoteDataSource: sl()));


  // ✅ UseCases
  sl.registerLazySingleton(() => CheckUser(sl()));
  sl.registerLazySingleton(() => CheckUserLogin(sl()));
  sl.registerLazySingleton(() => InsertUser(sl()));

  sl.registerLazySingleton(() => AddToCart(sl()));
  sl.registerLazySingleton(() => GetCartItems(sl()));
  sl.registerLazySingleton(() => UpdateCartQuantity(sl()));
  sl.registerLazySingleton(() => DeleteCartItem(sl()));
  sl.registerLazySingleton(() => ClearCart(sl()));

  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => GetProductsByCategory(sl()));
  sl.registerLazySingleton(() => GetCategories(sl()));

  // ✅ Providers
  sl.registerFactory(() => UserProvider(
        checkUserUseCase: sl(),
        checkUserLoginUseCase: sl(),
        insertUserUseCase: sl(),
      ));

  sl.registerFactory(() => CartProvider(
        addToCartUseCase: sl(),
        getCartItemsUseCase: sl(),
        updateCartQuantityUseCase: sl(),
        deleteCartItemUseCase: sl(),
        clearCartUseCase: sl(),
      ));

  sl.registerFactory(() => ProductProvider(
        getProductsUseCase: sl(),
        getProductsByCategoryUseCase: sl(),
        getCategoriesUseCase: sl(),
      ));
}
