import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart' as http;

import '../data/models/products_list_model.dart';

part 'products_service.g.dart';

@http.RestApi()
abstract class ProductsService {
  factory ProductsService(Dio dio, {String baseUrl}) = _ProductsService;

  @http.GET('/products')
  Future<List<ProductResponse>> getProducts();
}
