import 'dart:ffi';

import 'package:equatable/equatable.dart';



class OrderState extends Equatable {
  final String email;
  final String name;
  final String mobile;
  final String productName;
  final double amount ;
  final FormStatus status;
  final String errorMessage;

  OrderState({
    this.email = '',
    this.name = '',
    this.mobile = '',
    this.productName = '',
    this.amount = 0.0,
    this.status = FormStatus.initial,
    this.errorMessage = '',
  });

  OrderState copyWith({
    String? email,
    String? name,
    String? mobile,
    String? productName,
    double? amount,
    FormStatus? status,
    String? errorMessage,

  }) {
    return OrderState(
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        name: name ?? this.name,
        productName: productName?? this.productName,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props =>
      [email, status, errorMessage, name, mobile,productName,amount ];
}

enum FormStatus {
  initial,
  loading,
  success,
  failure,
  enablePayment,
}
