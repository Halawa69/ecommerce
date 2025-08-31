import 'package:ecommerce/core/di/dependency_injection.dart';
import 'package:ecommerce/features/auth/presentation/provider/userProvider.dart';
import 'package:ecommerce/features/cart/presentation/provider/cart_provider.dart';
import 'package:ecommerce/features/home/presentation/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/presentation/page/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  
  await sl.allReady();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<UserProvider>()),
        ChangeNotifierProvider(create: (_) => sl<CartProvider>()),
        ChangeNotifierProvider(create: (_) => sl<ProductProvider>()),
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
      home: const Login(),
    );
  }
}
