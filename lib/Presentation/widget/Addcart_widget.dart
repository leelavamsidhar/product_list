import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:products_list/data/Models/products_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/order_bloc/order_bloc.dart';
import '../Screens/BookingScreen.dart';

class AddcartWidget extends StatefulWidget {
  final Product cartProduct;
  const AddcartWidget({Key? key, required this.cartProduct}) : super(key: key);

  @override
  State<AddcartWidget> createState() => _AddcartWidgetState();
}

class _AddcartWidgetState extends State<AddcartWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: widget.cartProduct.image.toString(),
                height: 120,
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              widget.cartProduct.category!.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${widget.cartProduct.price!.toStringAsFixed(2)}",
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
                      "${widget.cartProduct.rating!.rate} (${widget.cartProduct.rating!.count})",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => OrderBloc(),child: OrderScreen(product: widget.cartProduct,),),));
              },
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text("Book Now",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
