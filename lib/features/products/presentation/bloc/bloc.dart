import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobitech/features/products/data/models/products_list_model.dart';
import 'package:mobitech/features/products/domain/products_service.dart';
import 'package:mobitech/features/products/presentation/bloc/event.dart';

import 'state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsServices service;

  late List<ProductResponse> products = [];

  ProductBloc(this.service) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        // Fetch products from the service
        final res = await service.getProducts();
        emit(ProductLoaded(res));
        products = res;
      } catch (e) {
        emit(ProductError('Failed to load products: $e'));
      }
    });

    on<SearchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        // If products are not loaded yet, fetch them first
        if (products.isEmpty) {
          products = await service.getProducts();
        }
        
        final query = event.query.toLowerCase().trim();
        if (query.isEmpty) {
          emit(ProductLoaded(products));
          return;
        }
        
        final filteredProducts = products.where((product) {
          return product.title.toLowerCase().contains(query) ||
              product.description.toLowerCase().contains(query);
        }).toList();
        
        emit(ProductLoaded(filteredProducts));
      } catch (e) {
        emit(ProductError('Failed to search products: $e'));
      }
    });
  }
}
