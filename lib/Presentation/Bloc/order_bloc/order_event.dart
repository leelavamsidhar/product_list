import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {}

class FormChange extends OrderEvent {
  final String name;
  final String email;
  final String mobile;
  final String productName;
  final double amount;
  FormChange({
    required this.email,
    required this.mobile,
    required this.name,
    required this.productName,
    required this.amount,
  });
  @override
  List<Object?> get props => [name, email, mobile, productName, amount];
}

class FormSubmit extends OrderEvent {
  @override
  List<Object?> get props => [];
}

class PaymentSucess extends OrderEvent {
  String paymentId;
  String orderId;
  String orderDate;
  PaymentSucess({
    required this.paymentId,
    required this.orderId,
    required this.orderDate,
  });
  @override
  List<Object?> get props => [];
}
