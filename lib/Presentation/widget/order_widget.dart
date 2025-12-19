import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/Models/order_model/order_model.dart';

class OrderCardWidget extends StatelessWidget {
  final OrderModel order;

  const OrderCardWidget({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final dateText = order.date != null
        ? DateFormat('dd MMM yyyy, hh:mm a').format(order.date!)
        : 'N/A';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E3C72),
            Color(0xFF2A5298),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Product Name
          Text(
            order.productName ?? 'Unknown Product',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 6),

          /// 🔹 Order ID
          Text(
            "Order ID: ${order.orderId ?? '--'}",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.8),
            ),
          ),

          const SizedBox(height: 14),
          const Divider(color: Colors.white24),

          const SizedBox(height: 12),

          /// 🔹 Info Row
          _infoRow(
            icon: Icons.phone_android,
            label: "Mobile",
            value: order.mobileNumber ?? '--',
          ),

          _infoRow(
            icon: Icons.payment,
            label: "Payment ID",
            value: order.paymentId ?? '--',
          ),

          _infoRow(
            icon: Icons.calendar_today,
            label: "Date",
            value: dateText,
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white70),
          const SizedBox(width: 8),
          Text(
            "$label:",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
