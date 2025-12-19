import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../data/Models/products_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final box = Hive.box<Product>('productBox');
  CartBloc() : super(CartInitial()) {
    on<GetCartList>(_onGetCartList);
  }
  Future<void> _onGetCartList(
    GetCartList event,
    Emitter<CartState> state,
  ) async {
    try {
      emit(CartLoadingState());
      final cartProducts = box.values
          .where((element) => element.isCard == 1)
          .toList();
      emit(CartListSucessState(cartProduct: cartProducts));
    } catch (e) {
      log("Get CartList ${e.toString()}");
      emit(CartListErrorState(errorMesssage: e.toString()));
    }
  }
}
