part of 'products_list_bloc.dart';

abstract class ProductsListState {}

final class ProductsListInitial extends ProductsListState {}
class loaingState extends ProductsListState{}

class ProductsListSucessState extends ProductsListState {
  final List<Product> productList;
  ProductsListSucessState({required this.productList});
}
class ProductsListErrorState extends ProductsListState {
  String errorMessage;
  ProductsListErrorState({required this.errorMessage});
}
class AddCartSucessfully extends ProductsListState {
}
class AddCartError extends ProductsListState {
  String errorMessage;
  AddCartError({required this.errorMessage});
}
class RemoveCartSucessfully extends ProductsListState{}
class RemoveCartError extends ProductsListState {
  String errorMessage;
  RemoveCartError({required this.errorMessage});
}