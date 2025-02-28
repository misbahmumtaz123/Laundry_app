import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../model/c_orderScreenModel.dart';

class QrScanScreen extends StatelessWidget {
  final Orders order;

  QrScanScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    String? orderQid = order.orderQId;

    // Check if the orderQid has an underscore and safely extract the first part
    String? shortOrderQid;

    if (orderQid != null && orderQid.contains('_')) {
      // If it contains an underscore, split and extract the second part, then shorten it
      List<String> parts = orderQid.split('_');
      if (parts.length > 1) {
        shortOrderQid = parts[1].substring(0, 4); // Get the first 4 characters after the underscore
      } else {
        // If no second part, use the full `order_q_id` (fallback)
        shortOrderQid = orderQid;
      }
    } else {
      // If the format doesn't match (no underscore), fallback to the full `order_q_id`
      shortOrderQid = orderQid;
    }

    // Convert data to JSON string for QR code
    String qrData = jsonEncode({
      "orderId": shortOrderQid,  // Use the processed orderQId (shortened if valid)
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scan"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Show Driver to confirm receiving the delivery",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              PrettyQr(
                typeNumber: 3,
                size: 150,
                data: qrData, // The QR code will display the shortened order ID
                errorCorrectLevel: QrErrorCorrectLevel.M,
                roundEdges: true,
              ),
              SizedBox(height: 20),
              Text(
                "Order ID: $shortOrderQid",  // Show the shortened order ID or the full one
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  //Get.to(() => ScanQRCodeScreen());
                },
                child: Text("Scan QR Code"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
