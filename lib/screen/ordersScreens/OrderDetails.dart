import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/screen/ordersScreens/DelieveryDetailScreen.dart';
import 'package:laundry/screen/ordersScreens/QrScanScreen.dart';
import '../../model/c_orderScreenModel.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Orders order;

  OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD5E9F7), // Light blue background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue[900]),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Order No. ${order.id ?? 'N/A'}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900]),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatus(order.orderStatus ?? "Unknown"),
            SizedBox(height: 10),
            _buildViewDeliveryCodeButton(),
            SizedBox(height: 10),
            InkWell(child: Text('Delivery Details'),
              onTap: (){
              Get.to(DeliveryDetailsScreen(order: order));
              },

            ),
            SizedBox(height: 10),
            _buildTag("Added by laundromat"),
            SizedBox(height: 10),
            _buildSectionTitle("Delivery Details"),
            _buildDetailRow("Super Laundromat"),
            _buildDetailRow("Laundry Time", "${order.orderDate}  ${order.orderTime}"),
            _buildDetailRow("Weight", "67 Lb / 2 bags"),
            _buildDetailRow("Delivery type", order.deliveryType ?? "Next day"),
            _buildDetailRow("Delivery time", "12:00 pm"),
            _buildDetailRow("Delivery fee", "\$${order.orderPrice} - Paid"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatus(String status) {
    return Row(
      children: [
        Text("Status", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900])),
        SizedBox(width: 10),
        Text(status, style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.w600)),
        Spacer(),
        Icon(Icons.chat_bubble_outline, color: Colors.blue[900])
      ],
    );
  }

  Widget _buildViewDeliveryCodeButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Get.to(QrScanScreen(order: order));
        }, // Add logic for delivery code
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF0D47A1), // Dark blue button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
        ),
        child: Text(
          "View Delivery Code",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900])),
    );
  }

  Widget _buildDetailRow(String title, [String? value]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          text: "$title  ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          children: value != null
              ? [
            TextSpan(
              text: value,
              style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
            ),
          ]
              : [],
        ),
      ),
    );
  }
}
