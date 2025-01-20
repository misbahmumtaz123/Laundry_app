import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/screen/placeorder/placeorder.dart';
import 'package:laundry/utils/Colors.dart';

import '../categorydetails_screen.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Services",
          style: TextStyle(
            color: primeryColor,
            fontSize: width * 0.05, // Responsive font size
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
              // Super Laundromat Info Box
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
                  border: Border.all(color: primeryColor, width: width * 0.005),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Super Laundromat",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.045,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            "325 Park Ave",
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
                          "0.2 ml",
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => DropOffScreen()),
                       // );
                        Get.to(DropOffScreen());
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
                        // Get.to(CategoryDetailsScreen());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DropOffScreen()),
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
                              'Deliver your drop-off',
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: height * 0.005),
                            Text(
                              'We DELIVER your drop-off from the laundromat to your house once it is ready',
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
