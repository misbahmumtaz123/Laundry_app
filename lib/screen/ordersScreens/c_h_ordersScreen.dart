import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/c_orderScreenController.dart';
import '../../model/c_orderScreenModel.dart';
import '../../utils/Colors.dart';
import 'ConfirmOrder.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final OrderController orderController = Get.put(OrderController());
  bool showCurrentOrders = true;

  @override
  void initState() {
    super.initState();
    orderController.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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

  Widget _buildCurrentOrders() {
    return Obx(() {
      if (orderController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (orderController.ordersList.isEmpty) {
        return Center(child: Text("No current orders found."));
      }

      return ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: orderController.ordersList.length,
        itemBuilder: (context, index) {
          Orders order = orderController.ordersList[index];

          return GestureDetector(
            onTap: () {
              Get.to(() => ConfirmScreen(order: order)); // Navigate to ConfirmScreen
            },
            child: _buildOrderCard(
              order.orderType ?? "Unknown",
              order.id?.toString() ?? "Unknown",
              order.orderStatus ?? "Unknown",
              order.orderDate ?? "Unknown",
              order.orderTime ?? "Unknown",
              order.orderPrice ?? "0.00",
            ),
          );
        },
      );
    });
  }

  Widget _buildOrderCard(String type, String orderId, String status, String date, String time, String price) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      color: Colors.white,
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
                Text("Order ID: $orderId", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                Text(time, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 5),
            Text("Super Laundromat", style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 5),
            Text("Status: $status", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            Text(date, style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 5),
            Text("Price: \$${price}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryOrders() {
    return Center(child: Text("History oorders feature coming soon!"));
  }

  Widget _buildTabButton(String text, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ?primeryColor : Colors.grey[300],
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
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Controller/c_orderScreenController.dart';
//
// class OrderScreen extends StatelessWidget {
//   final OrderController orderController = Get.put(OrderController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Pending Orders")),
//       body: Obx(() {
//         if (orderController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (orderController.ordersList.isEmpty) {
//           return Center(child: Text("No orders available"));
//         }
//         return ListView.builder(
//           itemCount: orderController.ordersList.length,
//           itemBuilder: (context, index) {
//             var order = orderController.ordersList[index];
//             return Card(
//               margin: EdgeInsets.all(10),
//               child: ListTile(
//                 title: Text("Order #${order.orderQId}"),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Status: ${order.orderStatus}"),
//                     Text("Price: \$${order.orderPrice}"),
//                     Text("Date: ${order.orderDate}"),
//                   ],
//                 ),
//                 trailing: Icon(Icons.arrow_forward_ios),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
