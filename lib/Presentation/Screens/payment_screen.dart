import 'package:flutter/material.dart';
import 'package:products_list/data/Models/order_model/order_model.dart';
import 'package:hive/hive.dart';

import '../../data/Reposatary/HiveBox.dart';
import '../widget/order_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final Box<OrderModel> box = Hive.box<OrderModel>(HiveBoxes.orderBox);
  late  List<OrderModel>  paymentData = box.values.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment List"),),
      body: ListView.builder(itemCount: paymentData.length,
        itemBuilder: (context, index) {
        final OrderModel singleData = paymentData[index];
        return OrderCardWidget(order: singleData,);

      },)
    );
  }
}
