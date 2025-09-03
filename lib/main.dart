import 'package:ecommerce/core/di/dependency_injection.dart';
import 'package:ecommerce/core/router/go_router.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  await sl.allReady();
  runApp(const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.router,
    );
  }
}
