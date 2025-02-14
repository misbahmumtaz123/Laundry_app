import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:laundry/model/c_orderScreenModel.dart';
import 'package:laundry/model/h_orderScreenModel.dart';

import '../../controller/c_orderScreenController.dart';
import '../../controller/h_orderScreenController.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final CurrentOrderController currentController = Get.put(CurrentOrderController());
  final HistoryOrderController historyController = Get.put(HistoryOrderController());

  bool showCurrentOrders = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            _buildTabButton("Current", showCurrentOrders, () {
              setState(() {
                showCurrentOrders = true;
              });
            }),
            _buildTabButton("History", !showCurrentOrders, () {
              setState(() {
                showCurrentOrders = false;
              });
            }),
          ],
        ),
      ),
      body: showCurrentOrders ? _buildCurrentOrders() : _buildHistoryOrders(),
    );
  }

  Widget _buildTabButton(String text, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue[900] : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentOrders() {
    return Obx(() {
      if (currentController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (currentController.currentOrders.isEmpty) {
        return Center(child: Text("No current orders found."));
      }

      return ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: currentController.currentOrders.length,
        itemBuilder: (context, index) {
          CurrentOrder order = currentController.currentOrders[index];
          return _buildOrderCard(order.orderType, order.orderId, order.orderStatus, order.orderDate, order.orderTime, order.orderPrice);
        },
      );
    });
  }

  Widget _buildHistoryOrders() {
    return Obx(() {
      if (historyController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (historyController.historyOrders.isEmpty) {
        return Center(child: Text("No completed orders found."));
      }

      return ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: historyController.historyOrders.length,
        itemBuilder: (context, index) {
          HistoryOrder order = historyController.historyOrders[index];
          return _buildHistoryCard(order.orderId, order.orderStatus, order.orderDate);
        },
      );
    });
  }

  Widget _buildOrderCard(String type, String orderId, String status, String date, String time, String price) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(type, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900])),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("no: $orderId", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                Text(time, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 5),
            Text("Super Laundromat", style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 5),
            Text("Status: $status", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            Text(date, style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(String orderId, String status, String date) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pickup no: $orderId", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900])),
            SizedBox(height: 5),
            Text("Super Laundromat", style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 5),
            Text("Status: $status", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            Text(date, style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }
}
