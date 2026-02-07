import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/network/network_info.dart';
import 'features/product/data/datasources/product_local_data_source.dart';
import 'features/product/data/datasources/product_remote_data_source.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/add_product.dart';
import 'features/product/domain/usecases/get_products.dart';
import 'features/product/domain/usecases/sync_products.dart';
import 'features/product/presentation/bloc/product_cubit.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> init() async {
  sl.registerFactory(
    () => ProductCubit(getProducts: sl(), addProduct: sl(), syncProducts: sl()),
  );

  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => AddProduct(sl()));
  sl.registerLazySingleton(() => SyncProducts(sl()));

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(box: sl()),
  );

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final box = Hive.box('products_box'); // Pastikan nama sama dengan main.dart
  sl.registerLazySingleton(() => box);

  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnection());
}
