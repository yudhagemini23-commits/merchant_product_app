import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection.dart';
import '../bloc/product_cubit.dart';
import '../widgets/product_item_card.dart';
import '../widgets/offline_banner.dart';
import '../widgets/create_product_fab.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductCubit>()..loadProducts(),
      child: const ProductView(),
    );
  }
}

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Merchant Product'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),

            onPressed: () => context.read<ProductCubit>().syncData(),
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            if (state.products.isEmpty) {
              return const Center(child: Text("Belum ada produk."));
            }
            return Column(
              children: [
                if (state.isOffline) const OfflineBanner(),

                Expanded(
                  child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return ProductItemCard(product: state.products[index]);
                    },
                  ),
                ),
              ],
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),

      floatingActionButton: const CreateProductFab(),
    );
  }
}
