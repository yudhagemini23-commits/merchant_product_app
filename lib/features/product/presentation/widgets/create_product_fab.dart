import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_cubit.dart';

class CreateProductFab extends StatelessWidget {
  const CreateProductFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Logika dummy data dipindah ke sini
        final newProduct = Product(
          id: const Uuid().v4(),
          name: "New Item ${DateTime.now().second}",
          price: 15000,
          description: "Created at ${DateTime.now()}",
          status: "active",
          updatedAt: DateTime.now(),
          isSynced: true, // Nanti di repo akan diubah jadi false jika offline
        );
        // Menggunakan context.read (Best Practice untuk Event)
        context.read<ProductCubit>().addNewProduct(newProduct);
      },
      child: const Icon(Icons.add),
    );
  }
}