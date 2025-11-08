import 'package:mobitech/features/products/data/models/products_list_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductResponse> products;

  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
