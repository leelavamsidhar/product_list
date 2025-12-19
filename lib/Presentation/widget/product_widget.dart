import 'package:flutter/material.dart';

import '../../data/Models/products_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/products_list/products_list_bloc.dart';
import 'package:flutter/cupertino.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentGeometry.topRight,
              child: BlocProvider(
                create: (context) => ProductsListBloc(),
                child: GestureDetector(
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      color: product.isCard == 1
                          ? Colors.green.shade400.withOpacity(0.5)
                          : Colors.grey.shade400.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Icon(Icons.add_shopping_cart),
                  ),
                  onTap: () {
                    product.isCard == 1? context.read<ProductsListBloc>().add(
                      ProductRemoveCart(removeCartProduct: product),
                    ):
                    context.read<ProductsListBloc>().add(
                      ProductAddCart(cartProduct: product),
                    );
                  },
                ),
              ),
            ),

            Center(
              child: CachedNetworkImage(
                imageUrl: product.image.toString(),
                height: 120,
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),

            const SizedBox(height: 12),
            Text(
              product.category!.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),
            Text(
              product.title.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.price!.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),

                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      "${product.rating!.rate} (${product.rating!.count})",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
