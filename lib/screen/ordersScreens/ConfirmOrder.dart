import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/c_orderScreenModel.dart';
import '../../utils/Colors.dart';
import 'ConfirmSuccess.dart';

class ConfirmScreen extends StatelessWidget {
  final Orders order;

  ConfirmScreen({required this.order});

  void _confirmOrder() async {
    bool success = true; // Assume success (you can add API logic here)

    if (success) {
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay
      Get.to(ConfirmSuccess(order: order,)); // Navigate to success screen (Update with actual route)
    } else {
      print("❌ Order status update failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD5E9F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: primeryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Confirmation",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primeryColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Super Laundromat", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildDetailRow("Laundry Time", "${order.orderDate}  ${order.orderTime}"),
            _buildDetailRow("Weight", "67 Lb / 2 bags"),
            _buildDetailRow("Delivery type", order.deliveryType ?? "Next day"),
            _buildDetailRow("Delivery time", "12:00 pm"),
            // _buildDetailRow("Address & instruction", "3277 Parkside pl\nHand to Hand"),
            _buildDetailRow("Delivery fee", "\$${order.orderPrice}"),
            SizedBox(height: 20),
            Center(child: _buildButton("Confirm", Colors.blue[900]!, Colors.white, _confirmOrder)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          text: "$title  ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          children: [
            TextSpan(text: value, style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primeryColor,
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(text, style: TextStyle(fontSize: 16, color: textColor)),
      ),
    );
  }
}
