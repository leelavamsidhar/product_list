import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_list/Presentation/Bloc/cart_bloc/cart_bloc.dart';
import 'package:products_list/Presentation/Screens/payment_screen.dart';
import 'package:products_list/data/Models/products_model.dart';

import '../Bloc/products_list/products_list_bloc.dart';
import '../widget/product_widget.dart';
import 'cartScreen.dart';
import 'package:flutter/cupertino.dart';

class ProductlistScreen extends StatefulWidget {
  const ProductlistScreen({super.key});

  @override
  State<ProductlistScreen> createState() => _ProductlistScreenState();
}

class _ProductlistScreenState extends State<ProductlistScreen> {
  @override
  void initState() {
    context.read<ProductsListBloc>().add(GetProductList());
    super.initState();
  }

  Future<void> _refresh() async {
    context.read<ProductsListBloc>().add(GetProductList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => CartBloc(),
                    child: Cartscreen(),
                  ),
                ),
              );
            },
            icon: Icon(CupertinoIcons.cart),
          ),
          IconButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentScreen(),)), icon: Icon(Icons.credit_card))
        ],
      ),
      // body: RefreshIndicator(
      //   onRefresh: _refresh,
      //   child: MultiBlocListener(
      //     listeners: [
      //       BlocListener<ProductsListBloc, ProductsListState>(
      //         listenWhen: (previous, current) =>
      //         current is AddCartSucessfully ||
      //             current is AddCartError ||
      //             current is ProductsListErrorState,
      //         listener: (context, state) {
      //           if (state is AddCartSucessfully) {
      //             ScaffoldMessenger.of(context).showSnackBar(
      //               const SnackBar(content: Text("Cart added successfully")),
      //             );
      //           }
      //
      //           if (state is AddCartError) {
      //             ScaffoldMessenger.of(context).showSnackBar(
      //               SnackBar(content: Text(state.errorMessage)),
      //             );
      //           }
      //
      //           if (state is ProductsListErrorState) {
      //             ScaffoldMessenger.of(context).showSnackBar(
      //               SnackBar(content: Text(state.errorMessage)),
      //             );
      //           }
      //         },
      //       ),
      //     ],
      //     child: BlocBuilder<ProductsListBloc, ProductsListState>(
      //       buildWhen: (previous, current) =>
      //       current is loaingState ||
      //           current is ProductsListSucessState,
      //       builder: (context, state) {
      //         if (state is loaingState) {
      //           return const Center(child: CircularProgressIndicator());
      //         }
      //
      //         if (state is ProductsListSucessState) {
      //           return ListView.builder(
      //             itemCount: state.productList.length,
      //             itemBuilder: (context, index) {
      //               return ProductCard(product: state.productList[index]);
      //             },
      //           );
      //         }
      //
      //         return const SizedBox.shrink();
      //       },
      //     ),
      //   ),
      // ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocConsumer<ProductsListBloc, ProductsListState>(
          builder: (context, state) {
            if (state is loaingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProductsListSucessState) {
              return ListView.builder(
                itemCount: state.productList.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: state.productList[index]);
                },
              );
            }
            return SizedBox.shrink();
          },
          listener: (context, state) {
            if (state is AddCartSucessfully) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Cart added successfully")),
              );
            }

            if (state is AddCartError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }

            if (state is ProductsListErrorState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
        ),
      ),
    );
  }
}
