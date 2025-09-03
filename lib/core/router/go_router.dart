import 'package:ecommerce/core/di/dependency_injection.dart';
import 'package:ecommerce/features/auth/presentation/page/login.dart';
import 'package:ecommerce/features/auth/presentation/page/signUp.dart';
import 'package:ecommerce/features/auth/presentation/provider/userProvider.dart';
import 'package:ecommerce/features/cart/presentation/page/cartPage.dart';
import 'package:ecommerce/features/cart/presentation/provider/cart_provider.dart';
import 'package:ecommerce/features/home/presentation/page/home.dart';
import 'package:ecommerce/features/home/presentation/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();
  factory AppRouter() => _instance;

  AppRouter._internal();

  final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: <RouteBase>[
      // ✅ Signup page with UserProvider
      GoRoute(
        path: '/signup',
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => sl<UserProvider>(),
            child: const Signup(),
          );
        },
      ),

      // ✅ Login page with UserProvider
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => sl<UserProvider>(),
            child: const Login(),
          );
        },
      ),

      // ✅ Home page with MultiProvider (Products + Cart)
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => sl<ProductProvider>()),
              ChangeNotifierProvider(create: (_) => sl<CartProvider>()),
              ChangeNotifierProvider(create: (_) => sl<UserProvider>()),

            ],
            child: const Home(),
          );
        },
      ),

      // ✅ Cart page with CartProvider only
      GoRoute(
        path: '/cart',
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => sl<CartProvider>(),
            child: Cart(),
          );
        },
      ),
    ],
  );
}
