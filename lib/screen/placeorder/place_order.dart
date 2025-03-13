import 'package:flutter/material.dart';
import '../../model/order_model.dart';
import '../../controller/ordercontroller.dart';
import '../ordersScreens/c_h_ordersScreen.dart';
import 'addAdressInstructions.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  String? selectedDeliveryType;
  bool isWeightUnknown = false;
  String? selectedPickupTime; // Updated to String for dropdown
  String? selectedTemperature;
  Map<String, dynamic>? addressAndInstructions; // Updated to Map
  TextEditingController weightController = TextEditingController(); // Controller for weight input

  // Category Section State
  String selectedCategory = "Clothes";
  final List<String> quantities = ["1", "2", "3", "4", "5"];
  final Map<String, int> basePrices = {"Clothes": 160, "Blanket": 200, "Comforter": 300};
  final Map<String, int> quantitiesMap = {"Clothes": 1, "Blanket": 1, "Comforter": 1};
  String? selectedVariation; // For Single/Double dropdown

  final OrderController _orderController = OrderController();
  bool _isLoading = false;

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  Future<void> _placeOrder() async {
    // Retrieve token and customer ID
    final prefs = await SharedPreferences.getInstance();
    final String? securityToken = prefs.getString('auth_token');
    final String? customerId = prefs.getString('customer_id');

    if (securityToken == null || customerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please login to place an order")),
      );
      return;
    }

    // Validate all fields
    if (selectedCategory.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a category")),
      );
      return;
    }

    if (selectedTemperature == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a temperature")),
      );
      return;
    }

    if (selectedPickupTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a pickup time")),
      );
      return;
    }

    if (selectedDeliveryType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a delivery type")),
      );
      return;
    }

    if (addressAndInstructions == null ||
        addressAndInstructions!["order_address"].isEmpty ||
        addressAndInstructions!["order_instructions"].isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add address and instructions")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Prepare order data
      final orderData = {
        "product_type": selectedCategory,
        "quantity": quantitiesMap[selectedCategory],
        "order_temp": selectedTemperature,
        "pickuptime": selectedPickupTime, // Updated to use dropdown value
        "delivery_type": selectedDeliveryType,
        "is_weight_unknown": isWeightUnknown,
        "order_instructions": addressAndInstructions,
        "security_token": securityToken, // Add security token
        "customer_id": customerId, // Add customer ID
        "variation_id": [selectedVariation == "Single" ? 1 : 2], // 1 for Single, 2 for Double
        "laundromat_id": 1, // Fixed laundromat ID
        "weight": isWeightUnknown ? "Unknown" : weightController.text, // Add weight
      };

      // Call the API
      final NewOrder response = await _orderController.placeOrder(orderData);

      // Prepare order summary
      final orderSummary = {
        "product_type": selectedCategory,
        "quantity": quantitiesMap[selectedCategory],
        "order_temp": selectedTemperature,
        "pickuptime": selectedPickupTime,
        "delivery_type": selectedDeliveryType,
        "total_amount": basePrices[selectedCategory]! * quantitiesMap[selectedCategory]!,
        "address": addressAndInstructions!["order_address"],
        "apartment": addressAndInstructions!["apartment"], // Ensure this key exists
        "floor": addressAndInstructions!["floor"], // Ensure this key exists
        "instructions": addressAndInstructions!["order_instructions"],
        "weight": isWeightUnknown ? "Unknown" : weightController.text, // Add weight
      };

      // Navigate to the Order Summary Screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderSummaryScreen(orderSummary: orderSummary),
        ),
      );

      // Handle success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Order placed successfully: ${response.result}")),
      );
    } catch (e) {
      // Handle error
      print("Error placing order: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to place order: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place Order"),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customer Details Box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff113FFF)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Carlos Hunter",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("Lucy Roach, Expedita vero perfer, Consequuntur provide 49128"),
                    Text("0.00 ml", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Rating, Distance, Time Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 20),
                      const SizedBox(width: 4),
                      const Text("5"),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.green, size: 20),
                      const SizedBox(width: 4),
                      const Text("0.42 Km"),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.blue, size: 20),
                      const SizedBox(width: 4),
                      const Text("9AM - 10PM"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Category Section
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryItem(label: "Clothes", icon: Icons.checkroom, color: Colors.red, selected: selectedCategory == "Clothes", onTap: () => selectCategory("Clothes")),
                    const SizedBox(width: 10),
                    CategoryItem(label: "Blanket", icon: Icons.bed, color: Colors.green, selected: selectedCategory == "Blanket", onTap: () => selectCategory("Blanket")),
                    const SizedBox(width: 10),
                    CategoryItem(label: "Comforter", icon: Icons.king_bed, color: Colors.blue, selected: selectedCategory == "Comforter", onTap: () => selectCategory("Comforter")),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(selectedCategory, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Image.asset("assets/${selectedCategory.toLowerCase()}.jpg", width: 120, height: 120),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(selectedCategory, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          if (selectedCategory != "Clothes") // Hide charges for Clothes
                            Row(
                              children: [
                                Text("\\${basePrices[selectedCategory]! * quantitiesMap[selectedCategory]!}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                                const SizedBox(width: 5),
                                Text("\\${basePrices[selectedCategory]! * quantitiesMap[selectedCategory]! + 40}", style: const TextStyle(fontSize: 14, color: Colors.grey, decoration: TextDecoration.lineThrough)),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        DropdownButton<String>(
                          value: selectedVariation,
                          hint: const Text("Select"),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedVariation = newValue;
                            });
                          },
                          items: ["Single", "Double"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          quantitiesMap[selectedCategory] = quantitiesMap[selectedCategory]! + 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: const Text("Add", style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Choose Weight
              const Text("Choose Weight", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextField(
                controller: weightController,
                decoration: InputDecoration(
                  hintText: "Enter weight in pounds",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                enabled: !isWeightUnknown,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isWeightUnknown,
                    onChanged: (value) {
                      setState(() {
                        isWeightUnknown = value!;
                      });
                    },
                  ),
                  const Text("I don’t know the weight"),
                ],
              ),
              const SizedBox(height: 16),

              // Temperature Selection
              const Text("Temperature", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Radio(
                    value: "Cold",
                    groupValue: selectedTemperature,
                    onChanged: (value) {
                      setState(() {
                        selectedTemperature = value.toString();
                      });
                    },
                  ),
                  const Text("Cold"),
                  const SizedBox(width: 20),
                  Radio(
                    value: "Warm",
                    groupValue: selectedTemperature,
                    onChanged: (value) {
                      setState(() {
                        selectedTemperature = value.toString();
                      });
                    },
                  ),
                  const Text("Warm"),
                  const SizedBox(width: 20),
                  Radio(
                    value: "Hot",
                    groupValue: selectedTemperature,
                    onChanged: (value) {
                      setState(() {
                        selectedTemperature = value.toString();
                      });
                    },
                  ),
                  const Text("Hot"),
                ],
              ),
              const SizedBox(height: 16),

              // Pickup Time Dropdown
              const Text("Pickup Time", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedPickupTime,
                hint: const Text("Select Pickup Time"),
                items: ["17:56", "11:56"]
                    .map((time) => DropdownMenuItem(value: time, child: Text(time)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPickupTime = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),

              // Delivery Type Dropdown
              const Text("Delivery Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedDeliveryType,
                hint: const Text("Select Delivery Type"),
                items: ["Same Day", "Next Day"]
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDeliveryType = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),

              // Address & Instruction
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Address & Instruction", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddressAndInstructionScreen()),
                      );
                      if (result != null) {
                        setState(() {
                          addressAndInstructions = result; // Store the returned address and instructions
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff113FFF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text("Add"),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Proceed Button
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _placeOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff113FFF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Proceed"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Define CategoryItem outside the _PlaceOrderScreenState class
class CategoryItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const CategoryItem({
    required this.label,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.blue.shade100 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.2),
              ),
              child: Icon(icon, size: 40, color: color),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

// Order Summary Screen
class OrderSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> orderSummary;

  const OrderSummaryScreen({super.key, required this.orderSummary});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary"),
        backgroundColor: const Color(0xff113FFF), // Same as receipt app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReceiptRow("Product Type", orderSummary["product_type"]),
            _buildReceiptRow("Quantity", orderSummary["quantity"].toString()),
            _buildReceiptRow("Temperature", orderSummary["order_temp"]),
            _buildReceiptRow("Pickup Time", orderSummary["pickuptime"]),
            _buildReceiptRow("Delivery Type", orderSummary["delivery_type"]),
            _buildReceiptRow("Weight", orderSummary["weight"]), // Add weight row
            _buildReceiptRow("Total Amount", "\\${orderSummary["total_amount"]}"),
            const SizedBox(height: 16),
            const Text(
              "Address & Instructions",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "${orderSummary["address"]}, ${orderSummary["apartment"] ?? "N/A"}, ${orderSummary["floor"] ?? "N/A"}",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              orderSummary["instructions"],
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Send Order
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Order Sent!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff113FFF), // Same as app bar
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text("Send Order", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderScreen(),
                      ),
                    );

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff113FFF), // Same as app bar
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text("View Order", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a row in the receipt
  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}