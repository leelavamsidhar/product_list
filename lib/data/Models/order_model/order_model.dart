import 'package:hive/hive.dart';

part 'order_model.g.dart';

@HiveType(typeId: 2) // must be unique across app
class OrderModel extends HiveObject {

  @HiveField(0)
  final String? mobileNumber;

  @HiveField(1)
  final String? paymentId;

  @HiveField(2)
  final String? orderId;

  @HiveField(3)
  final DateTime? date;

  @HiveField(4)
  final String? productName;

   OrderModel({
     this.mobileNumber,
     this.paymentId,
     this.orderId,
     this.date,
     this.productName,
  });

  /// ✅ Null-safe fromJson
  factory OrderModel.fromJson(Map<String, dynamic>? json) {
    return OrderModel(
      mobileNumber: json?['mobile_number']?.toString() ?? '',
      paymentId: json?['payment_id']?.toString() ?? '',
      orderId: json?['order_id']?.toString() ?? '',
      date: json?['date'] != null
          ? DateTime.tryParse(json!['date'].toString()) ?? DateTime.now()
          : DateTime.now(),
      productName: json?['product_name']?.toString() ?? '',
    );
  }

  /// ✅ Null-safe toJson
  Map<String, dynamic> toJson() {
    return {
      'mobile_number': mobileNumber,
      'payment_id': paymentId,
      'order_id': orderId,
      'date': date,
      'product_name': productName,
    };
  }
}
