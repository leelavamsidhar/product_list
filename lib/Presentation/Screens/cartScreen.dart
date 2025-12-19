import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_list/Presentation/Bloc/cart_bloc/cart_bloc.dart';

import '../widget/Addcart_widget.dart';

class Cartscreen extends StatefulWidget {
  const Cartscreen({super.key});

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  @override
  void initState() {
    context.read<CartBloc>().add(GetCartList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart list')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CartListSucessState) {
            return state.cartProduct.isNotEmpty?GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount:state.cartProduct.length ,
              itemBuilder: (context, index) {
                final singleProduct = state.cartProduct[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: AddcartWidget(cartProduct: singleProduct),
                );
              },
            ):const Center(
                child: Text(
                  "No Cart data available",
                  style: TextStyle(fontSize: 16),
                ));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
