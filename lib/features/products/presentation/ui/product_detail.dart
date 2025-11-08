import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobitech/features/products/data/models/products_list_model.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});

  final ProductResponse product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail'), elevation: 0),
      body: Center(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                spacing: 5,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      width: double.infinity,
                      height: 300,
                      errorWidget: (context, _, __) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                  Text(
                    product.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    product.category,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  Text(
                    "\u20B9 ${product.price}",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),

                  Wrap(children: [Text(product.description)]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
