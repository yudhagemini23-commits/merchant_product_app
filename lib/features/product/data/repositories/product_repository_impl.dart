import 'package:merchant_app/core/network/network_info.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Product>> getProducts({int page = 1, int limit = 20}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getProducts(page);

        await localDataSource.cacheProducts(remoteProducts);
        return remoteProducts;
      } catch (e) {
        return localDataSource.getCachedProducts();
      }
    } else {
      return localDataSource.getCachedProducts();
    }
  }

  @override
  Future<void> addProduct(Product product) async {
    final productModel = ProductModel.fromEntity(product);

    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addProduct(productModel);

        await localDataSource.addProduct(productModel);
      } catch (e) {
        final offlineProduct = ProductModel(
          id: product.id,
          name: product.name,
          price: product.price,
          description: product.description,
          status: product.status,
          updatedAt: DateTime.now(),
          isSynced: false,
        );
        await localDataSource.addProduct(offlineProduct);
      }
    } else {
      final offlineProduct = ProductModel(
        id: product.id,
        name: product.name,
        price: product.price,
        description: product.description,
        status: product.status,
        updatedAt: DateTime.now(),
        isSynced: false,
      );
      await localDataSource.addProduct(offlineProduct);
    }
  }

  @override
  Future<void> syncPendingData() async {
    if (await networkInfo.isConnected) {
      final pendingProducts = await localDataSource.getPendingSyncProducts();

      for (var product in pendingProducts) {
        try {
          final remoteProduct = await remoteDataSource.addProduct(product);

          await localDataSource.deleteProduct(product.id);

          final syncedProduct = ProductModel(
            id: remoteProduct.id,
            name: remoteProduct.name,
            price: remoteProduct.price,
            description: remoteProduct.description,
            status: remoteProduct.status,
            updatedAt: remoteProduct.updatedAt,
            isSynced: true,
          );

          await localDataSource.addProduct(syncedProduct);
        } catch (e) {
          print("Gagal sync product id: ${product.id} -> $e");
        }
      }
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    final cached = await localDataSource.getCachedProducts();
    return cached.firstWhere((element) => element.id == id);
  }

  @override
  Future<void> updateProduct(Product product) async {}
}
