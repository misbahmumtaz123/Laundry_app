import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/model/laundryment_search_model.dart';
import 'package:laundry/screen/placeorder/place_order1.dart';

class ServicesScreen extends StatelessWidget {
  final Laundry laundry;

  const ServicesScreen({Key? key, required this.laundry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Services",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display Laundry Information
              Container(
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.03),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: width * 0.02,
                      offset: Offset(0, height * 0.005),
                    ),
                  ],
                  border: Border.all(color: Theme.of(context).primaryColor, width: width * 0.005),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            laundry.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.045,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            laundry.address,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: width * 0.035,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${laundry.distance.toStringAsFixed(2)} ml",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.045,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          "Open",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: width * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),

              Text(
                "Choose Service",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.05,
                ),
              ),
              SizedBox(height: height * 0.03),

              // First Service Option
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(width * 0.03),
                    ),
                    child: Image.asset(
                      'assets/laudry1.png',
                      height: height * 0.2,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: -height * 0.06,
                    left: width * 0.04,
                    right: width * 0.04,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to PlaceOrderScreen and pass laundry details
                        Get.to(
                              () => PlaceOrderScreen(
                            laundryName: laundry.name,
                            laundryAddress: laundry.address,
                            laundryDistance: laundry.distance,
                            // pricePerPound: laundry.pricePerPound,
                          ),
                        );
                      },
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

                              'Pickup to laundromat only',
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: height * 0.005),
                            Text(
                              'We PICK UP your laundry from your house to the selected laundromat and you will pick it up once it is ready',
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                            SizedBox(height: height * 0.015),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.12),

              // Second Service Option
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(width * 0.03),
                    ),
                    child: Image.asset(
                      'assets/laudry2.jpg',
                      height: height * 0.2,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: -height * 0.06,
                    left: width * 0.04,
                    right: width * 0.04,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to another screen if needed (placeholder here)
                        // Get.to(
                        //       () => DeliverYourDropOff(), // Replace with your appropriate widget
                        // );
                      },
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
                              'Pickup and Delivery',
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: height * 0.005),
                            Text(
                              'We PICKUP your laundry from your house to the selected laundromat and DELIVER it to you once it is ready',
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                            SizedBox(height: height * 0.015),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
