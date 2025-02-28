import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/screen/placeorder/addAdressInstructions.dart';
import 'package:laundry/screen/placeorder/orderDetailsend.dart';

import '../../utils/Colors.dart';

class PlaceOrderScreen extends StatefulWidget {
  final String laundryName;
  final String laundryAddress;
  final double laundryDistance;
  const PlaceOrderScreen({
    Key? key,
    required this.laundryName,
    required this.laundryAddress,
    required this.laundryDistance,
  }) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  String? selectedPickupTime;
  String? selectedDeliveryTime;
  String? selectedDeliveryType;
  Map<String, dynamic>? selectedAddress;
  String? selectedTemperature; // Tracks the selected temperature
  bool iDontKnowWeight = false;

  TextEditingController weightController = TextEditingController();

  Future<void> _selectTime(BuildContext context, bool isPickup) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isPickup) {
          selectedPickupTime = pickedTime.format(context);
        } else {
          selectedDeliveryTime = pickedTime.format(context);
        }
      });
    }
  }

  void _navigateToAddressScreen() async {
    final result = await Get.to(() => const AddressAndInstructionScreen());
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        selectedAddress = result;
      });
    }
  }

  void _validateAndProceed() {
    String? errorMessage;

    // Validation
    if (selectedPickupTime == null) {
      errorMessage = "Please select a pickup time.";
    } else if (selectedDeliveryTime == null) {
      errorMessage = "Please select a delivery time.";
    } else if (selectedDeliveryType == null) {
      errorMessage = "Please select a delivery type.";
    } else if (selectedTemperature == null) {
      errorMessage = "Please select a temperature.";
    } else if (selectedAddress == null) {
      errorMessage = "Please add an address.";
    } else if (weightController.text.isEmpty && !iDontKnowWeight) {
      errorMessage = "Please enter the weight or select 'I don't know the weight'.";
    }

    if (errorMessage != null) {
      Get.snackbar("Error", errorMessage, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Proceed to the next screen
    final orderData = {
      "laundryName": widget.laundryName,
      "pickupTime": selectedPickupTime,
      "deliveryTime": selectedDeliveryTime,
      "deliveryType": selectedDeliveryType,
      "temperature": selectedTemperature,
      "weight": iDontKnowWeight ? "Unknown" : weightController.text,
      ...selectedAddress!,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderSummaryScreen(orderData: orderData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place Order"),
        backgroundColor: primeryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Laundry details
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primeryColor, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.laundryName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(widget.laundryAddress,
                      style: TextStyle(color: Colors.grey.shade600)),
                  Text("${widget.laundryDistance.toStringAsFixed(2)} ml",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text("Choose Weight",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: weightController,
              enabled: !iDontKnowWeight,
              decoration: const InputDecoration(
                hintText: "Enter weight in pounds",
                border: OutlineInputBorder(),
              ),
            ),
            CheckboxListTile(
              value: iDontKnowWeight,
              onChanged: (value) {
                setState(() {
                  iDontKnowWeight = value!;
                  if (iDontKnowWeight) weightController.clear();
                });
              },
              title: const Text("I don’t know the weight"),
            ),
            const Text("Temperature",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                _buildTemperatureRadio("Cold"),
                _buildTemperatureRadio("Warm"),
                _buildTemperatureRadio("Hot"),
              ],
            ),
            const SizedBox(height: 16),
            _buildTimePicker(
              context: context,
              label: "Pickup Time",
              selectedTime: selectedPickupTime,
              onTap: () => _selectTime(context, true),
            ),
            _buildTimePicker(
              context: context,
              label: "Delivery Time",
              selectedTime: selectedDeliveryTime,
              onTap: () => _selectTime(context, false),
            ),
            const Text("Delivery Type",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedDeliveryType,
              items: ["Same Day", "Next Day"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => selectedDeliveryType = value),
              hint: const Text("Select Delivery Type"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Address & Instruction",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primeryColor, // Customize button color
                  ),
                  onPressed: _navigateToAddressScreen,
                  child: const Text("Add"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primeryColor, // Customize button color
              ),
              onPressed: _validateAndProceed,
              child: const Text("Proceed"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemperatureRadio(String label) {
    return Row(
      children: [
        Radio<String>(
          value: label,
          groupValue: selectedTemperature,
          onChanged: (value) {
            setState(() {
              selectedTemperature = value;
            });
          },
        ),
        Text(label),
      ],
    );
  }

  Widget _buildTimePicker({
    required BuildContext context,
    required String label,
    required String? selectedTime,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedTime ?? "Select $label"),
            const Icon(Icons.access_time),
          ],
        ),
      ),
    );
  }
}
