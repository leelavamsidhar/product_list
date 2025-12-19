part of 'cart_bloc.dart';

abstract class CartState {}

final class CartInitial extends CartState {}

final class CartListSucessState extends CartState {
  final List<Product> cartProduct;
  CartListSucessState({required this.cartProduct});
}

final class CartListErrorState extends CartState {
  final String errorMesssage;
  CartListErrorState({required this.errorMesssage});
}
final class CartLoadingState extends CartState {}
