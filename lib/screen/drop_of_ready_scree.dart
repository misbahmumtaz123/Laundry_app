import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/fontfamily_model.dart';
import '../utils/Colors.dart';
import '../utils/Custom_widget.dart';
import 'my booking/mybooking_screen.dart';

class Dropofreadyscreen extends StatefulWidget {
  const Dropofreadyscreen({super.key});

  @override
  State<Dropofreadyscreen> createState() => _DropofreadyscreenState();
}

class _DropofreadyscreenState extends State<Dropofreadyscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Delivery  Ready",
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
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "Your Delivery is Ready\n           for Payment",
                style: TextStyle(
                  fontFamily: "Gilroy Medium",
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ClipOval(
              child: Container(
                margin: EdgeInsets.all(8),
                alignment: Alignment.center,
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(18)),
                child: Text("Ready"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Waiting for Laundry Confirmation",
                style: TextStyle(
                  fontFamily: "Gilroy Medium",
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              width: 200,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text(
                            "Receipt: 5586552",
                            style: TextStyle(
                              fontFamily: "Gilroy Medium",
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Laundry Price ",
                                style: TextStyle(
                                  fontFamily: "Gilroy Medium",
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "25",
                                style: TextStyle(
                                  fontFamily: "Gilroy Medium",
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Delivery ",
                                style: TextStyle(
                                  fontFamily: "Gilroy Medium",
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "25",
                                style: TextStyle(
                                  fontFamily: "Gilroy Medium",
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Total",
                                style: TextStyle(
                                  fontFamily: "Gilroy Medium",
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "30",
                                style: TextStyle(
                                  fontFamily: "Gilroy Medium",
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            GestButton(
              Width: 400,
              height: 50,
              buttoncolor: blueColor,
              margin: EdgeInsets.only(top: 15, left: 30, right: 30),
              buttontext: "Proceed".tr,
              style: TextStyle(
                fontFamily: FontFamily.gilroyBold,
                color: WhiteColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              onclick: () {
                Get.to(MyBookingScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
