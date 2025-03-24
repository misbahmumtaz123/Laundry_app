import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/Colors.dart';

class AddressAndInstructionScreen extends StatefulWidget {
  const AddressAndInstructionScreen({Key? key}) : super(key: key);

  @override
  State<AddressAndInstructionScreen> createState() => _AddressAndInstructionScreenState();
}

class _AddressAndInstructionScreenState extends State<AddressAndInstructionScreen> {
  // Text controllers
  final TextEditingController addressController = TextEditingController();
  final TextEditingController aptNoController = TextEditingController();
  final TextEditingController floorNoController = TextEditingController();
  final TextEditingController instructionController = TextEditingController();

  // Checkboxes
  bool hasElevator = false;
  bool leaveAtDoor = false;
  bool handToHand = false;
  bool isBuilding = false;
  bool isHouse = false;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  void _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isBuilding = prefs.getBool('isBuilding') ?? false;
      isHouse = prefs.getBool('isHouse') ?? false;
      addressController.text = prefs.getString('order_address') ?? '';
      aptNoController.text = prefs.getString('aptNo') ?? '';
      floorNoController.text = prefs.getString('floorNo') ?? '';
      instructionController.text = prefs.getString('instruction') ?? '';
      hasElevator = prefs.getBool('hasElevator') ?? false;
      leaveAtDoor = prefs.getBool('leaveAtDoor') ?? false;
      handToHand = prefs.getBool('handToHand') ?? false;
    });
  }

  void _saveAndReturnData() {
    if (addressController.text.isEmpty || instructionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    if (!isBuilding && !isHouse) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select Building or House")),
      );
      return;
    }

    Navigator.pop(context, {
      "isBuilding": isBuilding,
      "isHouse": isHouse,
      "order_address": addressController.text,
      "aptNo": aptNoController.text,
      "floorNo": floorNoController.text,
      "hasElevator": hasElevator,
      "delivery_status": leaveAtDoor ? "Leave at Door" : "Hand to Hand",
      "instructions": instructionController.text,
    });
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primeryColor,
        title: const Text("Address & Instructions"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: const Text("is Building"),
                    value: isBuilding,
                    onChanged: (value) {
                      setState(() {
                        isBuilding = value ?? false;
                        if (isBuilding) isHouse = false;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text("is House"),
                    value: isHouse,
                    onChanged: (value) {
                      setState(() {
                        isHouse = value ?? false;
                        if (isHouse) {
                          isBuilding = false;
                          hasElevator = false;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            _buildInputField(label: "Address", controller: addressController, hint: "Enter your address"),
            _buildInputField(label: "Apt No", controller: aptNoController, hint: "Enter Apt No"),
            _buildInputField(label: "Floor No", controller: floorNoController, hint: "Enter Floor No"),
            CheckboxListTile(
              value: hasElevator,
              onChanged: isHouse ? null : (value) => setState(() => hasElevator = value!),
              title: const Text("Building has Elevator"),
            ),
            const Text("Delivery Status", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            CheckboxListTile(
              value: leaveAtDoor,
              onChanged: (value) {
                setState(() {
                  leaveAtDoor = value ?? false;
                  if (leaveAtDoor) handToHand = false;
                });
              },
              title: const Text("Leave at Door"),
            ),
            CheckboxListTile(
              value: handToHand,
              onChanged: (value) {
                setState(() {
                  handToHand = value ?? false;
                  if (handToHand) leaveAtDoor = false;
                });
              },
              title: const Text("Hand to Hand"),
            ),
            _buildInputField(label: "Instructions", controller: instructionController, hint: "Enter instructions", maxLines: 4),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primeryColor, foregroundColor: Colors.white),
                onPressed: _saveAndReturnData,
                child: const Text("Save Address"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({required String label, required TextEditingController controller, required String hint, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(hintText: hint, border: const OutlineInputBorder()),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
