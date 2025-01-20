import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:laundry/screen/drop_of_ready_scree.dart';

class Dropofwatingscreen extends StatefulWidget {
  const Dropofwatingscreen({super.key});

  @override
  State<Dropofwatingscreen> createState() => _DropofwatingscreenState();
}

class _DropofwatingscreenState extends State<Dropofwatingscreen> {
  splash() async {
    Timer(Duration(seconds: 3), (() {
      Get.to(Dropofreadyscreen());
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Delivery  processed",
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
                "Your Delivery is processed\n             for Payment",
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
                child: Text("Please Wait\n  a Second"),
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
                      Container(
                        child: Text(
                          "Updating Price ........ ",
                          style: TextStyle(
                            fontFamily: "Gilroy Medium",
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
