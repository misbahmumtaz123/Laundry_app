import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/controller/laundryment_search_controller.dart';
 import 'package:laundry/screen/placeorder/servicesPage.dart';
import 'package:laundry/utils/Colors.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Find Your Laundromat",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: primeryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: "Choose laundromat",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) => controller.searchLaundromats(value),
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
                  itemCount: controller.filteredLaundromats.length,
                  itemBuilder: (context, index) {
                    Laundry laundry = controller.filteredLaundromats[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ServicesScreen(laundry: laundry));
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    laundry.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    laundry.address,
                                    style: TextStyle(color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${laundry.distance} ml",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    "Open",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
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

