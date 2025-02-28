// import 'package:flutter/material.dart';
//
// class AddressAndInstructionScreen extends StatefulWidget {
//   const AddressAndInstructionScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddressAndInstructionScreen> createState() =>
//       _AddressAndInstructionScreenState();
// }
//
// class _AddressAndInstructionScreenState
//     extends State<AddressAndInstructionScreen> {
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController aptNoController = TextEditingController();
//   final TextEditingController floorNoController = TextEditingController();
//   final TextEditingController instructionController = TextEditingController();
//
//   bool hasElevator = false, leaveAtDoor = false, handToHand = false;
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Address & Instructions"),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             padding: EdgeInsets.symmetric(
//               horizontal: screenWidth * 0.05, // Adjust padding based on screen size
//               vertical: 16,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildInputField(
//                   label: "Address",
//                   controller: addressController,
//                   hint: "Enter your address",
//                 ),
//                 _buildInputField(
//                   label: "Apt No",
//                   controller: aptNoController,
//                   hint: "Enter Apt No",
//                 ),
//                 _buildInputField(
//                   label: "Floor No",
//                   controller: floorNoController,
//                   hint: "Enter Floor No",
//                 ),
//                 CheckboxListTile(
//                   value: hasElevator,
//                   onChanged: (value) => setState(() => hasElevator = value!),
//                   title: const Text("Building has Elevator"),
//                 ),
//                 CheckboxListTile(
//                   value: leaveAtDoor,
//                   onChanged: (value) => setState(() => leaveAtDoor = value!),
//                   title: const Text("Leave at Door"),
//                 ),
//                 CheckboxListTile(
//                   value: handToHand,
//                   onChanged: (value) => setState(() => handToHand = value!),
//                   title: const Text("Hand to Hand"),
//                 ),
//                 _buildInputField(
//                   label: "Instructions",
//                   controller: instructionController,
//                   hint: "Enter additional instructions",
//                   maxLines: 4,
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context, {
//                         "address": addressController.text,
//                         "aptNo": aptNoController.text,
//                         "floorNo": floorNoController.text,
//                         "instruction": instructionController.text,
//                         "hasElevator": hasElevator,
//                         "leaveAtDoor": leaveAtDoor,
//                         "handToHand": handToHand,
//                       });
//                     },
//                     child: const Text("Add Address"),
//                   ),
//                 ),
//                 const SizedBox(height: 20), // Extra space at the bottom
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildInputField({
//     required String label,
//     required TextEditingController controller,
//     required String hint,
//     int maxLines = 1,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           maxLines: maxLines,
//           decoration: InputDecoration(
//             hintText: hint,
//             border: const OutlineInputBorder(),
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';

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

  // Existing checkboxes
  bool hasElevator = false;
  bool leaveAtDoor = false;
  bool handToHand = false;

  // NEW: Add two booleans for Building or House
  bool isBuilding = false;
  bool isHouse = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(

          backgroundColor: primeryColor, // Customize button color

        title: const Text("Address & Instructions"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, // Adjust padding based on screen size
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- NEW: Building or House checkboxes in a row ---
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text("Building"),
                        value: isBuilding,
                        onChanged: (value) {
                          setState(() {
                            isBuilding = value ?? false;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text("House"),
                        value: isHouse,
                        onChanged: (value) {
                          setState(() {
                            isHouse = value ?? false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                // ------------------------------------------------

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
                  title: const Text("Building sElevator"),
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primeryColor, // Customize button color
                    ),
                    onPressed: () {
                      // Pass back all values including new fields
                      Navigator.pop(context, {
                        "isBuilding": isBuilding,
                        "isHouse": isHouse,
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
                ),
                const SizedBox(height: 20), // Extra space at the bottom
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
