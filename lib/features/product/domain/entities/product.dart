import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final double price; 
  final String description;
  final String status; 
  final DateTime updatedAt;
  final bool isSynced; 

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.status,
    required this.updatedAt,
    this.isSynced = true, 
  });

  
  @override
  List<Object?> get props => [id, name, price, description, status, updatedAt, isSynced];
}