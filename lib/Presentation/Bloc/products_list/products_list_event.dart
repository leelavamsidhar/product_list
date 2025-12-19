part of 'products_list_bloc.dart';

abstract class ProductsListEvent {}

class GetProductList extends ProductsListEvent {}

class ProductAddCart extends ProductsListEvent {
  Product cartProduct;
  ProductAddCart({required this.cartProduct});
}
class ProductRemoveCart extends ProductsListEvent{
  Product removeCartProduct;
  ProductRemoveCart({required this.removeCartProduct});
}
