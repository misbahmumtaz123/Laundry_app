// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:laundry/controller/laundryment_search_controller.dart';
// import 'package:laundry/screen/placeorder/servicesPage.dart';
// import '../../model/laundryment_search_model.dart';
// class LaundrySearchScreen extends StatefulWidget {
//   @override
//   _LaundrySearchScreenState createState() => _LaundrySearchScreenState();
// }
// class _LaundrySearchScreenState extends State<LaundrySearchScreen> {
//   final LaundryController controller = Get.put(LaundryController());
//   final TextEditingController searchController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     controller.fetchLaundromats(24.92994926038695, 67.07463296801761);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       blurRadius: 8,
//                       spreadRadius: 2,
//                     ),
//                   ],
//                 ),
//                 child: TextField(
//                   controller: searchController,
//                   autofocus: true,  // Automatically opens keyboard for search
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey.shade100,
//                     prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
//                     suffixIcon: searchController.text.isNotEmpty
//                         ? IconButton(
//                       icon: Icon(Icons.clear, color: Colors.grey.shade600),
//                       onPressed: () {
//                         searchController.clear();
//                         controller.searchLaundromats(""); // Reset search
//                       },
//                     )
//                         : null,
//                     hintText: "Choose a laundromat...",
//                     hintStyle: TextStyle(color: Colors.grey.shade500),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     contentPadding: EdgeInsets.symmetric(vertical: 14),
//                   ),
//                   onChanged: (value) => controller.searchLaundromats(value),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Obx(() {
//                 if (controller.laundromats.isEmpty) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (controller.filteredLaundromats.isEmpty) {
//                   return Center(child: Text('No laundromats found.'));
//                 }
//                 return ListView.builder(
//                   itemCount: controller.filteredLaundromats.length,
//                   itemBuilder: (context, index) {
//                     Laundry laundry = controller.filteredLaundromats[index];
//                     return GestureDetector(
//                       onTap: () {
//                         Get.to(() => ServicesScreen(laundry: laundry));
//                       },
//                       child: Card(
//                         margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16.0),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     laundry.name,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   SizedBox(height: 4.0),
//                                   Text(
//                                     laundry.address,
//                                     style: TextStyle(color: Colors.grey.shade600),
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     "${laundry.distance} ml",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: Theme.of(context).primaryColor,
//                                     ),
//                                   ),
//                                   SizedBox(height: 4.0),
//                                   Text(
//                                     "Open",
//                                     style: TextStyle(
//                                       color: Colors.green,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/controller/laundryment_search_controller.dart';
import 'package:laundry/screen/placeorder/servicesPage.dart';
import '../../model/laundryment_search_model.dart';

class LaundrySearchScreen extends StatefulWidget {
  @override
  _LaundrySearchScreenState createState() => _LaundrySearchScreenState();
}

class _LaundrySearchScreenState extends State<LaundrySearchScreen> {
  final LaundryController controller = Get.put(LaundryController());
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.fetchLaundromats(24.92994926038695, 67.07463296801761);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  autofocus: true, // Automatically opens keyboard for search
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey.shade600),
                      onPressed: () {
                        searchController.clear();
                        controller.searchLaundromats(""); // Reset search
                      },
                    )
                        : null,
                    hintText: "Choose a laundromat...",
                    hintStyle: TextStyle(
                        color: Colors.grey.shade500, fontSize: screenWidth * 0.04),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  ),
                  onChanged: (value) => controller.searchLaundromats(value),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.laundromats.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.filteredLaundromats.isEmpty) {
                  return Center(child: Text('No laundromats found.'));
                }
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  itemCount: controller.filteredLaundromats.length,
                  itemBuilder: (context, index) {
                    Laundry laundry = controller.filteredLaundromats[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ServicesScreen(laundry: laundry));
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      laundry.name,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.045,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.005),
                                    Text(
                                      laundry.address,
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: screenWidth * 0.035),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${laundry.distance} ml",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.005),
                                  Text(
                                    "Open",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.035,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

