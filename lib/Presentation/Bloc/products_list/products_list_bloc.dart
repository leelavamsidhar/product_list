import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:products_list/data/Models/products_model.dart';

import '../../../data/Reposatary/HiveBox.dart';
import '../../../data/Reposatary/products_list_api.dart';
import 'package:hive/hive.dart';

part 'products_list_event.dart';
part 'products_list_state.dart';

class ProductsListBloc extends Bloc<ProductsListEvent, ProductsListState> {
  ProductRepository _productRepository = ProductRepository();
  final Box<Product> box = Hive.box<Product>(HiveBoxes.productBox);
  ProductsListBloc() : super(ProductsListInitial()) {
    on<GetProductList>(_onGetProductList);
    on<ProductAddCart>(_onProductAddCart);
    on<ProductRemoveCart>(_onProductRemoveCart);
  }
  Future<void> saveProducts(List<Product> products) async {
    await box.clear();
    for (var product in products) box.put(product.id, product);
  }

  Future<void> _onGetProductList(
    GetProductList event,
    Emitter<ProductsListState> state,
  ) async {
    try {
      emit(loaingState());
      if (box.isNotEmpty) {
        emit(ProductsListSucessState(productList: box.values.toList()));
      }
      final List<Product>? productList =
          await _productRepository.GetProductList();
      if (productList!.isNotEmpty) {
        await saveProducts(productList);
        emit(ProductsListSucessState(productList: productList));
      } else {
        emit(ProductsListErrorState(errorMessage: "Failed to get the list"));
      }
    } catch (e) {
      log('the log is ${e.toString()}');
    }
  }

  Future<void> _onProductAddCart(
    ProductAddCart event,
    Emitter<ProductsListState> state,
  ) async {
    emit(loaingState());

    try {
      final product = event.cartProduct;
      if (product.id == null) {
        emit(AddCartError(errorMessage: 'Product is not eggest'));
      }
      for (var p1 in box.values) {
        if (p1.id == product.id) {
          p1.isCard = 1;
          p1.save();
          break;
        }
      }
      final card = box.values.where((element) => element.isCard == 1).toList();
      log('The card value are ${card.first.title}');
      emit(AddCartSucessfully());
      emit(ProductsListSucessState(productList: box.values.toList()));
    } catch (e) {
      AddCartError(errorMessage: e.toString());
    }
  }

  Future<void> _onProductRemoveCart(
    ProductRemoveCart event,
    Emitter<ProductsListState> state,
  ) async {
    try {
      emit(loaingState());
      final removedProduct = event.removeCartProduct;
      if (removedProduct.id == null) {
        emit(RemoveCartError(errorMessage: "Please give the valid product "));
      }
      for (var p1 in box.values) {
        if (p1.id == removedProduct.id) {
          p1.isCard = 0;
          p1.save();
          break;
        }
      }
      emit(ProductsListSucessState(productList: box.values.toList()));
    } catch (e) {
      emit(RemoveCartError(errorMessage: e.toString()));
    }
  }
}
