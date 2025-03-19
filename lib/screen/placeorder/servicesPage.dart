import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/controller/laundry_service_controller.dart';
import 'package:laundry/model/laundryment_search_model.dart';
import 'package:laundry/screen/placeorder/place_order.dart';

class ServicesScreen extends StatefulWidget {
  final Laundry laundry;

  const ServicesScreen({Key? key, required this.laundry}) : super(key: key);

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final LaundryServicesController laundryServicesController = Get.put(LaundryServicesController());

  @override
  void initState() {
    super.initState();
    laundryServicesController.fetchLaundryServices();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double height = constraints.maxHeight;
      double width = constraints.maxWidth;

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: Text(
            "Services",
            style: TextStyle(
              color: Colors.blue.shade700,
              fontSize: width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Laundromat Info Card (Responsive)
              Container(
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.03),
                  border: Border.all(color: Colors.blue.shade700, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: width * 0.02,
                      offset: Offset(0, height * 0.005),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.laundry.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.045,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: height * 0.005),
                          Text(
                            widget.laundry.address,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: width * 0.035,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min, // ✅ Keeps column size minimal
                      crossAxisAlignment: CrossAxisAlignment.end, // ✅ Aligns items to the right
                      children: [
                        // 📏 Distance Display
                        Text(
                          "${widget.laundry.distance.toStringAsFixed(2)} km",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.035,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        SizedBox(height: height * 0.005),

                        // 🔘 Status Badge with Better UI
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), // ✅ Adjusted padding for balance
                          decoration: BoxDecoration(
                            // color: widget.laundry.status.toLowerCase() == "open"
                            //     ? Colors.green.shade100
                            //     : Colors.red.shade100,
                            borderRadius: BorderRadius.circular(8),
                            // border: Border.all(
                            //   color: widget.laundry.status.toLowerCase() == "open"
                            //       ? Colors.green
                            //       : Colors.red,
                            //   width: 1.5, // ✅ Adds a clear border for better visibility
                            // ),
                          ),
                          child: Text(
                            widget.laundry.status.toUpperCase(),
                            style: TextStyle(
                              fontSize: width * 0.032, // ✅ Slightly smaller for a cleaner look
                              fontWeight: FontWeight.bold,
                              color: widget.laundry.status.toLowerCase() == "open"
                                  ? Colors.green.shade800
                                  : Colors.red.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: height * 0.04),

              // 🔹 Choose Service Title
              Text(
                "Choose Service",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.05,
                ),
              ),
              SizedBox(height: height * 0.05),

              // 🔹 Fetch & Show Services Dynamically (Card Overlapping Image)
              Expanded(
                child: Obx(() {
                  if (laundryServicesController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (laundryServicesController.services.isEmpty) {
                    return Center(child: Text("No services available"));
                  }

                  return ListView.builder(
                    itemCount: laundryServicesController.services.length,
                    itemBuilder: (context, index) {
                      var service = laundryServicesController.services[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: height * 0.1), // More spacing between services
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to PlaceOrderScreen with the selected service
                            // Navigate to PlaceOrderScreen with selected service and laundry
                            Get.to(() => PlaceOrderScreen(), arguments: {
                              "laundry": widget.laundry.toJson(), // Convert laundry object to JSON
                              "serviceName": service.serviceName, // Pass selected service name
                            });

                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // 🖼 Service Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(width * 0.03),
                                child: Image.asset(
                                  index == 0
                                      ? 'assets/laudry1.png'
                                      : 'assets/laudry2.jpg', // Dynamic Images
                                  height: height * 0.22,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              // 🏷 Overlapping Service Description Box (Fixed Overlapping)
                              Positioned(
                                bottom: -height * 0.04, // Overlaps image slightly
                                left: width * 0.04,
                                right: width * 0.04,
                                child: Container(
                                  padding: EdgeInsets.all(width * 0.03),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(width * 0.03),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: width * 0.02,
                                        offset: Offset(0, height * 0.005),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        service.serviceName, // Dynamic service name
                                        style: TextStyle(
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: height * 0.005),
                                      Text(
                                        index == 0
                                            ? "We PICK UP your laundry from your house to the selected laundromat and you will pick it up once it is ready."
                                            : "We PICKUP your laundry from your house to the selected laundromat and DELIVER it to you once it is ready.",
                                        style: TextStyle(
                                          fontSize: width * 0.035,
                                          color: Colors.grey,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                      SizedBox(height: height * 0.01),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
    });
  }
}
