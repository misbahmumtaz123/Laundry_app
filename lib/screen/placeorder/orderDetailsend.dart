// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:laundry/controller/orderController.dart';
// import 'package:laundry/model/order_model.dart';
//
//
// class OrderSummaryScreen extends StatelessWidget {
//   final Map<String, dynamic> orderData;
//
//   const OrderSummaryScreen({Key? key, required this.orderData})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final OrderController controller = OrderController();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Order Summary"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Laundromat: ${orderData['laundryName']}"),
//             Text("Pickup Time: ${orderData['pickupTime']}"),
//             Text("Delivery Time: ${orderData['deliveryTime']}"),
//             Text("Delivery Type: ${orderData['deliveryType']}"),
//             Text("Temperature: ${orderData['temperature']}"),
//             Text("Weight: ${orderData['weight']}"),
//             Text("Address: ${orderData['address']}"),
//             ElevatedButton(
//               onPressed: () async {
//                 final order = OrderModel(
//                   customerId: "12345",
//                   laundromatId: "67890",
//                   orderTime: DateTime.now().toIso8601String(),
//                   orderType: "pickup",
//                   orderStatus: "pending",
//                   driverAssignedId: "98765",
//                   pickuptime: [
//                     orderData['pickupTime'] ?? "14:00",
//                     orderData['deliveryTime'] ?? "15:00"
//                   ],
//                   receipt: "receipt123",
//                   rating: "4",
//                   attachment: "file_url",
//                   deliveryCode: "ABC123",
//                   totalPrice: "85.00",
//                   productType: ["1", "3"],
//                   quantity: ["1", "2"],
//                   price: ["40", "45"],
//                   weight: [null, null],
//                 );
//
//                 try {
//                   final response = await controller.placeOrder(order);
//                   if (response.result) {
//                     Get.snackbar(response.title, response.message);
//                   }
//                 } catch (e) {
//                   Get.snackbar("Error", "Failed to place order.");
//                 }
//               },
//               child: const Text("Send Order"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/controller/orderController.dart';
import 'package:laundry/model/order_model.dart';
import 'package:laundry/screen/placeorder/c_h_ordersScreen.dart';


class OrderSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> orderData;

  const OrderSummaryScreen({Key? key, required this.orderData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderController controller = OrderController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Laundromat: ${orderData['laundryName']}"),
            Text("Pickup Time: ${orderData['pickupTime']}"),
            Text("Delivery Time: ${orderData['deliveryTime']}"),
            Text("Delivery Type: ${orderData['deliveryType']}"),
            Text("Temperature: ${orderData['temperature']}"),
            Text("Weight: ${orderData['weight']}"),
            Text("Address: ${orderData['address']}"),
            const SizedBox(height: 20),

            // Send Order Button
            ElevatedButton(
              onPressed: () async {
                final order = OrderModel(
                  customerId: "12345",
                  laundromatId: "67890",
                  orderTime: DateTime.now().toIso8601String(),
                  orderType: "pickup",
                  orderStatus: "pending",
                  driverAssignedId: "98765",
                  pickuptime: [
                    orderData['pickupTime'] ?? "14:00",
                    orderData['deliveryTime'] ?? "15:00"
                  ],
                  receipt: "receipt123",
                  rating: "4",
                  attachment: "file_url",
                  deliveryCode: "ABC123",
                  totalPrice: "85.00",
                  productType: ["1", "3"],
                  quantity: ["1", "2"],
                  price: ["40", "45"],
                  weight: [null, null],
                );

                try {
                  final response = await controller.placeOrder(order);
                  if (response.result) {
                    Get.snackbar(response.title, response.message);
                  }
                } catch (e) {
                  Get.snackbar("Error", "Failed to place order.");
                }
              },
              child: const Text("Send Order"),
            ),

            const SizedBox(height: 10),

            // View Orders Button
            ElevatedButton(
              onPressed: () {
                Get.to(() =>OrderScreen()); // Navigate to OrdersScreen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Customize button color
              ),
              child: const Text("View Orders"),
            ),
          ],
        ),
      ),
    );
  }
}

