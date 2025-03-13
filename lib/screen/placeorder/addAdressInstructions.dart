import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/Colors.dart';

class AddressAndInstructionScreen extends StatefulWidget {
  const AddressAndInstructionScreen({Key? key}) : super(key: key);

  @override
  State<AddressAndInstructionScreen> createState() =>
      _AddressAndInstructionScreenState();
}

class _AddressAndInstructionScreenState
    extends State<AddressAndInstructionScreen> {
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
    _loadSavedData(); // Load saved data when the screen is initialized
  }

  // Load saved data
  void _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isBuilding = prefs.getBool('house_status') ?? false;
      isHouse = prefs.getBool('house_status') ?? false;
      addressController.text = prefs.getString('order_address') ?? '';
      aptNoController.text = prefs.getString('aptNo') ?? '';
      floorNoController.text = prefs.getString('floorNo') ?? '';
      instructionController.text = prefs.getString('instruction') ?? '';
      hasElevator = prefs.getBool('hasElevator') ?? false;
      leaveAtDoor = prefs.getBool('leaveAtDoor') ?? false;
      handToHand = prefs.getBool('handToHand') ?? false;
    });
  }

  // Save data
  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('house_status', isBuilding);
    prefs.setBool('house_status', isHouse);
    prefs.setString('order_address', addressController.text);
    prefs.setString('apt_no', aptNoController.text);
    prefs.setString('floor', floorNoController.text);
    prefs.setString('order_instruction', instructionController.text);
    prefs.setBool('elevator_status', hasElevator);
    prefs.setBool('delivery_status', leaveAtDoor);
    prefs.setBool('delivery_status', handToHand);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primeryColor,
        title: const Text("Address & Instructions"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Building or House checkboxes
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text("is Building"),
                        value: isBuilding,
                        onChanged: (value) {
                          setState(() {
                            isBuilding = value ?? false;
                            if (isBuilding) {
                              isHouse = false; // Ensure only one is selected
                            }
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
                              isBuilding = false; // Ensure only one is selected
                              hasElevator = false; // Disable elevator option
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),

                // Address Field
                _buildInputField(
                  label: "Address",
                  controller: addressController,
                  hint: "Enter your address",
                ),

                // Apt No Field
                _buildInputField(
                  label: "Apt No",
                  controller: aptNoController,
                  hint: "Enter Apt No",
                ),

                // Floor No Field
                _buildInputField(
                  label: "Floor No",
                  controller: floorNoController,
                  hint: "Enter Floor No",
                ),

                // Building has Elevator (disabled if House is selected)
                CheckboxListTile(
                  value: hasElevator,
                  onChanged: isHouse
                      ? null // Disable if House is selected
                      : (value) => setState(() => hasElevator = value!),
                  title: const Text("Building has Elevator"),
                ),

                // Delivery Status Heading
                const Text(
                  "Delivery Status",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Leave at Door and Hand to Hand (only one can be selected)
                CheckboxListTile(
                  value: leaveAtDoor,
                  onChanged: (value) {
                    setState(() {
                      leaveAtDoor = value ?? false;
                      if (leaveAtDoor) handToHand = false; // Ensure only one is selected
                    });
                  },
                  title: const Text("Leave at Door"),
                ),
                CheckboxListTile(
                  value: handToHand,
                  onChanged: (value) {
                    setState(() {
                      handToHand = value ?? false;
                      if (handToHand) leaveAtDoor = false; // Ensure only one is selected
                    });
                  },
                  title: const Text("Hand to Hand"),
                ),

                // Instructions Field
                _buildInputField(
                  label: "Instructions",
                  controller: instructionController,
                  hint: "Enter additional instructions",
                  maxLines: 4,
                ),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primeryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      // Validate fields
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

                      // Save data
                      _saveData();

                      // Return data
                      Navigator.pop(context, {
                        "house_status": isBuilding,
                        "house_status": isHouse,
                        "order_address": addressController.text,
                        "apt_no": aptNoController.text,
                        "floor": floorNoController.text,
                        "order_instructions": instructionController.text,
                        "elevator_status": hasElevator,
                        "delivery_status": leaveAtDoor ? "leave at the door" : "hand to hand",
                      });
                    },
                    child: const Text("Save Address"),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
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