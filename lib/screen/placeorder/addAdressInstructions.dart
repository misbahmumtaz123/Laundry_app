
import 'package:flutter/material.dart';

class AddressAndInstructionScreen extends StatefulWidget {
  const AddressAndInstructionScreen({Key? key}) : super(key: key);

  @override
  State<AddressAndInstructionScreen> createState() =>
      _AddressAndInstructionScreenState();
}

class _AddressAndInstructionScreenState
    extends State<AddressAndInstructionScreen> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController aptNoController = TextEditingController();
  final TextEditingController floorNoController = TextEditingController();
  final TextEditingController instructionController = TextEditingController();

  bool hasElevator = false, leaveAtDoor = false, handToHand = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address & Instructions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField(
              label: "Address",
              controller: addressController,
              hint: "Enter your address",
            ),
            _buildInputField(
              label: "Apt No",
              controller: aptNoController,
              hint: "Enter Apt No",
            ),
            _buildInputField(
              label: "Floor No",
              controller: floorNoController,
              hint: "Enter Floor No",
            ),
            CheckboxListTile(
              value: hasElevator,
              onChanged: (value) => setState(() => hasElevator = value!),
              title: const Text("Building has Elevator"),
            ),
            CheckboxListTile(
              value: leaveAtDoor,
              onChanged: (value) => setState(() => leaveAtDoor = value!),
              title: const Text("Leave at Door"),
            ),
            CheckboxListTile(
              value: handToHand,
              onChanged: (value) => setState(() => handToHand = value!),
              title: const Text("Hand to Hand"),
            ),
            _buildInputField(
              label: "Instructions",
              controller: instructionController,
              hint: "Enter additional instructions",
              maxLines: 4,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  "address": addressController.text,
                  "aptNo": aptNoController.text,
                  "floorNo": floorNoController.text,
                  "instruction": instructionController.text,
                  "hasElevator": hasElevator,
                  "leaveAtDoor": leaveAtDoor,
                  "handToHand": handToHand,
                });
              },
              child: const Text("Add Address"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
