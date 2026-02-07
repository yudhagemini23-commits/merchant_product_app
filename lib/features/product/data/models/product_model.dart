import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/product.dart';

part 'product_model.g.dart'; 

@HiveType(typeId: 0) 
class ProductModel extends Product {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String status;
  @HiveField(5)
  final DateTime updatedAt;
  @HiveField(6)
  final bool isSynced;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.status,
    required this.updatedAt,
    this.isSynced = true,
  }) : super(
          id: id,
          name: name,
          price: price,
          description: description,
          status: status,
          updatedAt: updatedAt,
          isSynced: isSynced,
        );

  
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(), 
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      status: json['status'],
      updatedAt: DateTime.parse(json['updatedAt']),
      isSynced: true, 
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id, 
      'name': name,
      'price': price,
      'description': description,
      'status': status,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  
  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      price: product.price,
      description: product.description,
      status: product.status,
      updatedAt: product.updatedAt,
      isSynced: product.isSynced,
    );
  }
}