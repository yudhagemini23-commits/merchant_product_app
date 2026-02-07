import 'package:dio/dio.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts(int page);
  Future<ProductModel> addProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});
  // final String baseUrl = "http://localhost:3000";
  final String baseUrl = "http://192.168.100.3:3000/";

  @override
  Future<List<ProductModel>> getProducts(int page) async {
    final response = await dio.get(
      '$baseUrl/products',
      queryParameters: {'_page': page, '_limit': 20},
    );
    return (response.data as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    final response = await dio.post(
      '$baseUrl/products',
      data: product.toJson(),
    );
    return ProductModel.fromJson(response.data);
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    final response = await dio.put(
      '$baseUrl/products/${product.id}',
      data: product.toJson(),
    );
    return ProductModel.fromJson(response.data);
  }
}
