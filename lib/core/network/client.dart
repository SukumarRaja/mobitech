import 'package:dio/dio.dart';
import 'package:mobitech/features/products/presentation/bloc/bloc.dart';
import 'package:mobitech/features/products/presentation/bloc/initial.dart';

class ApiClient {
  static Dio createDio(InitialBloc bloc) {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://fakestoreapi.com",
        connectTimeout: const Duration(seconds: 5000),
        receiveTimeout: const Duration(seconds: 3000),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    return dio;
  }
}

const baseUrl = "https://fakestoreapi.com";
