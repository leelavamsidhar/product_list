import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:products_list/data/Models/order_model/order_model.dart';

import '../../../data/Reposatary/HiveBox.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final Box<OrderModel> box = Hive.box<OrderModel>(HiveBoxes.orderBox);
  OrderBloc() : super(OrderState()) {
    on<FormChange>(_onFormChange);
    on<FormSubmit>(_onFormSubmit);
    on<PaymentSucess>(_onPaymentSucess);
  }

  Future<void> _onFormChange(FormChange event, Emitter<OrderState> emit) async {
    log(
      "📝 Form Changed -> Email: ${event.email}, ProductName: ${event.productName}, Name: ${event.name}, Mobile: ${event.mobile}, Amount: ${event.amount}",
    );
    emit(
      state.copyWith(
        email: event.email,
        name: event.name,
        mobile: event.mobile,
        amount: event.amount,
        productName: event.productName,
      ),
    );
  }

  Future<void> _onFormSubmit(FormSubmit event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: FormStatus.enablePayment));
  }

  Future<void> _onPaymentSucess(
    PaymentSucess event,
    Emitter<OrderState> emit,
  ) async {
    final order = OrderModel(
      productName: state.productName,
      mobileNumber: state.mobile,
      date: DateTime.now(),
      orderId: event.orderId,
      paymentId: event.paymentId,
    );
    box.add(order);

  }
}
