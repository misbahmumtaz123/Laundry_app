import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/product_model.dart';

class SummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve order data (excluding laundry details)
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
              // Service Name
              Text(
                "Selected Service: $serviceName",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
              ),

              const SizedBox(height: 10),

              // Selected Products List
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

              // Temperature Selection
              Text("Selected Temperature: $temperature", style: const TextStyle(fontSize: 16)),

              const SizedBox(height: 10),

              // Pickup and Delivery Time
              Text("Pickup Time: $pickupTime", style: const TextStyle(fontSize: 16)),
              Text("Delivery Time: $deliveryTime", style: const TextStyle(fontSize: 16)),

              const SizedBox(height: 10),

              // Delivery Type
              Text("Delivery Type: $deliveryType", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              // Address Section
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

              // Total Price
              Text(
                "Total Price: \$${totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),

              const SizedBox(height: 20),

              // Confirm Order Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar("Order Confirmed", "Your order has been placed successfully!");
                    Get.offAllNamed('/home'); // Navigate to home or order tracking screen
                  },
                  child: const Text('Confirm Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
