import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobitech/features/products/domain/products_service.dart';
import 'package:mobitech/features/products/presentation/bloc/bloc.dart';
import 'package:mobitech/features/products/presentation/bloc/initial.dart';
import 'package:mobitech/features/products/presentation/bloc/initial_state.dart';

import 'core/network/client.dart';
import 'features/products/presentation/bloc/event.dart';
import 'features/products/presentation/bloc/initial_event.dart';
import 'features/products/presentation/ui/products_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ProductBloc _productBloc;
  late final InitialBloc _initAppBloc;
  late final ProductsServices _productsServices;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    late final InitialBloc _initAppBloc = InitialBloc()..add(StartInitial());
    final dio = ApiClient.createDio(_initAppBloc);
    _productsServices = ProductsServices(dio, baseUrl: baseUrl);

    _productBloc = ProductBloc(_productsServices)..add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InitialBloc>(create: (_) => _initAppBloc),
        BlocProvider<ProductBloc>(create: (_) => _productBloc),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductsList(),
      ),
    );
  }
}
