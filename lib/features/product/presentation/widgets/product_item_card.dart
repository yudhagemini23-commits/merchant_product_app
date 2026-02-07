import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class ProductItemCard extends StatelessWidget {
  final Product product;

  const ProductItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text(product.description, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Rp ${product.price.toStringAsFixed(0)}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Icon(
            product.isSynced ? Icons.cloud_done : Icons.cloud_off,
            color: product.isSynced ? Colors.green : Colors.grey,
            size: 16,
          ),
        ],
      ),
    );
  }
}