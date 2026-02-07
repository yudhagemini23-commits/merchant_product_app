import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/sync_products.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProducts getProducts;
  final AddProduct addProduct;
  final SyncProducts syncProducts;

  ProductCubit({
    required this.getProducts,
    required this.addProduct,
    required this.syncProducts,
  }) : super(ProductInitial());

  Future<void> loadProducts() async {
    emit(ProductLoading());
    try {
      final result = await getProducts();

      bool isDataOffline = result.any((element) => element.isSynced == false);

      emit(ProductLoaded(result, isOffline: isDataOffline));
    } catch (e) {
      emit(ProductError("Gagal memuat data: $e"));
    }
  }

  Future<void> addNewProduct(Product product) async {
    emit(ProductLoading());
    try {
      await addProduct(product);
      emit(const ProductOperationSuccess("Produk berhasil disimpan!"));
      loadProducts();
    } catch (e) {
      emit(ProductError("Gagal menambah produk: $e"));
    }
  }

  Future<void> syncData() async {
    try {
      await syncProducts();
      loadProducts();
    } catch (e) {}
  }
}
