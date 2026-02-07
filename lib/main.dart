import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'injection.dart' as di;

import 'features/product/presentation/pages/product_page.dart';
import 'features/product/data/models/product_model.dart';

void main() async {
  // Ensure framework binding is initialized before executing async tasks
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local persistence layer
  await Hive.initFlutter();

  // Adapter registration is mandatory before opening boxes for custom TypeIDs
  Hive.registerAdapter(ProductModelAdapter());

  // Open the primary box for product caching and offline storage
  await Hive.openBox('products_box');

  // Initialize Dependency Injection / Service Locator (GetIt)
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Merchant App',
      debugShowCheckedModeBanner: false, // Clean UI for submission
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // Root View: Merchant product management dashboard
      home: const ProductPage(),
    );
  }
}