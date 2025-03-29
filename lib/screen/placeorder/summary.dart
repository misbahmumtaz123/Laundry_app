// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controller/createOrderController.dart';
// import '../../model/createOrderModel.dart';
// import '../../model/product_model.dart';
//
// class SummaryScreen extends StatelessWidget {
//   final OrderController _orderController = OrderController();
//
//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic> orderData = Get.arguments as Map<String, dynamic>;
//
//     final String serviceName = orderData["serviceName"];
//     final List<Product> selectedProducts = orderData["selectedProducts"];
//     final String? temperature = orderData["temperature"];
//     final String? pickupTime = orderData["pickupTime"];
//     final String? deliveryTime = orderData["deliveryTime"];
//     final String? deliveryType = orderData["deliveryType"];
//     final double totalPrice = orderData["totalPrice"];
//     final Map<String, dynamic> addressDetails = orderData["addressDetails"];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Order Summary"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Selected Service: $serviceName",
//                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
//               ),
//               const SizedBox(height: 10),
//               const Text("Selected Products:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               for (var product in selectedProducts)
//                 if (product.basePrice > 0)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                     child: ListTile(
//                       title: Text(product.productName),
//                       subtitle: Text("Quantity: ${product.selectedQuantity}"),
//                       trailing: Text(
//                         "\$${product.totalPrice.toStringAsFixed(2)}",
//                         style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//               const SizedBox(height: 10),
//               Text("Selected Temperature: $temperature", style: const TextStyle(fontSize: 16)),
//               const SizedBox(height: 10),
//               Text("Pickup Time: $pickupTime", style: const TextStyle(fontSize: 16)),
//               Text("Delivery Time: $deliveryTime", style: const TextStyle(fontSize: 16)),
//               const SizedBox(height: 10),
//               Text("Delivery Type: $deliveryType", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               const Text("Delivery Address Details:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               Text("Building Type: ${addressDetails["isBuilding"] ? "Building" : "House"}"),
//               Text("Address: ${addressDetails["order_address"]}"),
//               Text("Apt No: ${addressDetails["aptNo"].isNotEmpty ? addressDetails["aptNo"] : "N/A"}"),
//               Text("Floor No: ${addressDetails["floorNo"].isNotEmpty ? addressDetails["floorNo"] : "N/A"}"),
//               Text("Elevator: ${addressDetails["hasElevator"] ? "Yes" : "No"}"),
//               Text("Delivery Status: ${addressDetails["delivery_status"]}"),
//               Text("Instructions: ${addressDetails["instructions"]}"),
//               const SizedBox(height: 20),
//               Text(
//                 "Total Price: \$${totalPrice.toStringAsFixed(2)}",
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       // ✅ Creating OrderModel
//                       final OrderModel order = OrderModel(
//                         customerId: orderData["customer_id"],
//                         laundromatId: orderData["laundromat_id"],
//                         orderType: orderData["order_type"],
//                         orderStatus: orderData["order_status"],
//                         pickupTime: [pickupTime ?? ""],
//                         productType: selectedProducts.map((product) => int.parse(product.productId)).toList(), // ✅ Fixed
//                         variationId: List<int>.from(orderData["variation_id"] ?? []), // ✅ Fixed
//                         quantity: selectedProducts.map((product) => int.tryParse(product.selectedQuantity) ?? 1).toList(),
//                         price: selectedProducts.map((product) => product.totalPrice).toList(),
//                         totalPrice: totalPrice,
//                         payment: orderData["payment"],
//                         deliveryMethod: orderData["delivery_method"],
//                         deliveryType: deliveryType ?? "",
//                         orderInstructions: orderData["order_instructions"],
//                         orderAddress: orderData["order_address"],
//                         orderTemp: [temperature ?? ""],
//                         houseStatus: addressDetails["isBuilding"] ? "building" : "house",
//                         aptNo: addressDetails["aptNo"] ?? "",
//                         elevatorStatus: addressDetails["hasElevator"] ? 1 : 0,
//                         floor: addressDetails["floorNo"] != null ? int.tryParse(addressDetails["floorNo"]) ?? 0 : 0,
//                         deliveryStatus: addressDetails["delivery_status"],
//                       );
//
//                       // ✅ Placing Order
//                       final OrderModel newOrder = await _orderController.placeOrder(order);
//                       Get.snackbar("Success", "Your order has been placed successfully!",
//                           snackPosition: SnackPosition.BOTTOM);
//                       Get.offAllNamed('/home');
//                     } catch (e) {
//                       Get.snackbar("Error", e.toString(),
//                           snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
//                     }
//                   },
//                   child: const Text('Confirm Order'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/createOrderController.dart';
import '../../model/createOrderModel.dart';
import '../../model/product_model.dart';
import '../ordersScreens/c_h_ordersScreen.dart';

class SummaryScreen extends StatelessWidget {
  final OrderController _orderController = OrderController();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> orderData = Get.arguments as Map<String, dynamic>;

    final String serviceName = orderData["serviceName"];
    final List<Product> selectedProducts = orderData["selectedProducts"];
    final String? temperature = orderData["temperature"];
    final String? pickupTime = orderData["pickupTime"];
    final String? deliveryTime = orderData["deliveryTime"];
    final String? deliveryType = orderData["deliveryType"];
    final double totalPrice = orderData["totalPrice"];
    final Map<String, dynamic> addressDetails = orderData["addressDetails"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selected Service: $serviceName",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 10),
              const Text("Selected Products:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              for (var product in selectedProducts)
                if (product.basePrice > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(product.productName),
                      subtitle: Text("Quantity: ${product.selectedQuantity}"),
                      trailing: Text(
                        "\$${product.totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              const SizedBox(height: 10),
              Text("Selected Temperature: $temperature", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text("Pickup Time: $pickupTime", style: const TextStyle(fontSize: 16)),
              Text("Delivery Time: $deliveryTime", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text("Delivery Type: $deliveryType", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("Delivery Address Details:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Building Type: ${addressDetails["isBuilding"] ? "Building" : "House"}"),
              Text("Address: ${addressDetails["order_address"]}"),
              Text("Apt No: ${addressDetails["aptNo"].isNotEmpty ? addressDetails["aptNo"] : "N/A"}"),
              Text("Floor No: ${addressDetails["floorNo"].isNotEmpty ? addressDetails["floorNo"] : "N/A"}"),
              Text("Elevator: ${addressDetails["hasElevator"] ? "Yes" : "No"}"),
              Text("Delivery Status: ${addressDetails["delivery_status"]}"),
              Text("Instructions: ${addressDetails["instructions"]}"),
              const SizedBox(height: 20),
              Text(
                "Total Price: \$${totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final OrderModel order = OrderModel(
                        customerId: orderData["customer_id"],
                        laundromatId: orderData["laundromat_id"],
                        orderType: orderData["order_type"],
                        orderStatus: orderData["order_status"],
                        pickupTime: [pickupTime ?? ""],
                        productType: selectedProducts.map((product) => int.parse(product.productId)).toList(),
                        variationId: List<int>.from(orderData["variation_id"] ?? []),
                        quantity: selectedProducts.map((product) => int.tryParse(product.selectedQuantity) ?? 1).toList(),
                        price: selectedProducts.map((product) => product.totalPrice).toList(),
                        totalPrice: totalPrice,
                        payment: orderData["payment"],
                        deliveryMethod: orderData["delivery_method"],
                        deliveryType: deliveryType ?? "",
                        orderInstructions: orderData["order_instructions"],
                        orderAddress: orderData["order_address"],
                        orderTemp: [temperature ?? ""],
                        houseStatus: addressDetails["isBuilding"] ? "building" : "house",
                        aptNo: addressDetails["aptNo"] ?? "",
                        elevatorStatus: addressDetails["hasElevator"] ? 1 : 0,
                        floor: addressDetails["floorNo"] != null ? int.tryParse(addressDetails["floorNo"]) ?? 0 : 0,
                        deliveryStatus: addressDetails["delivery_status"],
                      );
                      final OrderModel newOrder = await _orderController.placeOrder(order);
                      Get.snackbar("Success", "Your order has been placed successfully!", snackPosition: SnackPosition.BOTTOM);
                      Get.offAllNamed('/home');
                    } catch (e) {
                      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                    }
                  },
                  child: const Text('Confirm Order'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderScreen()),
                    );

                  },
                  child: const Text('View Details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}