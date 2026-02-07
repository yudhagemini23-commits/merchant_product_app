import 'package:hive/hive.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
  Future<void> addProduct(ProductModel product);
  Future<List<ProductModel>> getPendingSyncProducts();
  Future<void> deleteProduct(String id);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Box box;

  ProductLocalDataSourceImpl({required this.box});

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    // Return all persisted records as a typed list
    return box.values.toList().cast<ProductModel>();
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    // Bulk update/insert local cache
    for (var product in products) {
      await box.put(product.id, product);
    }
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    await box.put(product.id, product);
  }

  @override
  Future<List<ProductModel>> getPendingSyncProducts() async {
    // Filter locally persisted data for unsynced records
    final all = box.values.toList().cast<ProductModel>();
    return all.where((p) => p.isSynced == false).toList();
  }

  @override
  Future<void> deleteProduct(String id) async {
    // Remove specific entry (usually called after successful remote sync)
    await box.delete(id);
  }
}