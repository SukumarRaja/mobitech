import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobitech/features/products/presentation/bloc/bloc.dart';
import 'package:mobitech/features/products/presentation/bloc/state.dart';
import 'package:mobitech/features/products/presentation/ui/product_detail.dart';

import '../bloc/event.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

int ratingLength = 5;
final searchController = TextEditingController();
Timer? debounce;

class _ProductsListState extends State<ProductsList> {
  @override
  void initState() {
    context.read<ProductBloc>().add(LoadProducts());
    super.initState();
    searchController.addListener(() {
      final query = searchController.text;
      context.read<ProductBloc>().add(SearchProducts(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is ProductError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Products List'), elevation: 0),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(
                          0,
                          3,
                        ), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search Products',
                      contentPadding: const EdgeInsets.all(16.0),
                    ),
                    onChanged: (val) {
                      if (debounce?.isActive ?? false) debounce!.cancel();
                      debounce = Timer(const Duration(milliseconds: 500), () {
                        context.read<ProductBloc>().add(SearchProducts(val));
                        // Perform search operation here
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: context.read<ProductBloc>().products.length,
                    itemBuilder: (context, index) {
                      var product = context.read<ProductBloc>().products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetail(product: product),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(
                                  0,
                                  3,
                                ), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: product.image,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  width: double.infinity,
                                  height: 150,
                                  errorWidget: (context, _, __) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                              ),
                              Text(
                                product.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                product.category,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                "\u20B9 ${product.price}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  ratingLength,
                                  (index) => Icon(
                                    index < product.rating.rate
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                ),
                              ),

                              Wrap(children: [Text(product.description)]),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
