import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/screen/categorydetails_screen.dart';

import '../delivery_drop_of_screen.dart';

class Servicesscreen extends StatefulWidget {
  final String storetitle;
  final String storeloc;
  final String storedis;
  Servicesscreen(
      {Key? key,
      required this.storetitle,
      required this.storedis,
      required this.storeloc})
      : super(key: key);

  @override
  State<Servicesscreen> createState() => _ServicesscreenState();
}

class _ServicesscreenState extends State<Servicesscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Services",
          style: TextStyle(
            fontFamily: "Gilroy Bold",
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back(); // Navigate back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Laundromat Information Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: Text(
                  widget.storetitle.toString(),
                  style: TextStyle(
                    fontFamily: "Gilroy Medium",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  widget.storeloc.toString(),
                  style: TextStyle(fontFamily: "Gilroy Regular", fontSize: 14),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.storedis.toString(),
                      style: TextStyle(fontFamily: "Gilroy Medium"),
                    ),
                    Text(
                      "Open",
                      style: TextStyle(
                        color: Colors.green,
                        fontFamily: "Gilroy Medium",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Service Buttons
            Text(
              "Choose Service",
              style: TextStyle(
                fontFamily: "Gilroy Bold",
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            _serviceOption(
              title: "Pickup and Delivery",
              description:
                  "We PICKUP your laundry from your house to the selected laundromat and DELIVER it to you once it is ready.",
              onTap: () {
                Get.to(CategoryDetailsScreen()); // Navigate to Category Screen
              },
            ),

            SizedBox(height: 10),
            _serviceOption(
              title: "Deliver your drop-off",
              description:
                  "We DELIVER your drop-off from the laundromat to your house once it is ready.",
              onTap: () {
                Get.to(Deliverydropofscreen(
                  storedis: widget.storedis,
                  storeloc: widget.storeloc,
                  storetitle: widget.storetitle,
                ));
              },
            ),
            Spacer(),

            // Login Button

            // Sign Up Link
          ],
        ),
      ),
    );
  }

  // Service Option Widget
  Widget _serviceOption(
      {required String title,
      required String description,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: "Gilroy Bold",
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(
                fontFamily: "Gilroy Medium",
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
