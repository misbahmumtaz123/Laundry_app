import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/fontfamily_model.dart';
import '../utils/Colors.dart';
import '../utils/Custom_widget.dart';
import 'addlocation/addressdetails_screen.dart';
import 'addlocation/deliveryaddress1.dart';
import 'drop_of_waiting_screen.dart';

class Deliverydropofscreen extends StatefulWidget {
  final String storetitle;
  final String storeloc;
  final String storedis;
  const Deliverydropofscreen(
      {super.key,
      required this.storetitle,
      required this.storedis,
      required this.storeloc});

  @override
  State<Deliverydropofscreen> createState() => _DeliverydropofscreenState();
}

class _DeliverydropofscreenState extends State<Deliverydropofscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Deliver Your Drop-off",
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  " Deliver Your Drop-off",
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
                    style:
                        TextStyle(fontFamily: "Gilroy Regular", fontSize: 14),
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
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  //    controller: addLocationController.homeAddress,
                  keyboardType: TextInputType.number,
                  cursorColor: BlackColor,
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    hintText: "Reciept No".tr,
                    hintStyle: TextStyle(
                      fontFamily: FontFamily.gilroyMedium,
                      fontSize: 15,
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: FontFamily.gilroyMedium,
                    fontSize: 16,
                    color: BlackColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Floor No'.tr;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Upload Receipt Photo",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Deivering time",
                    style: TextStyle(
                      fontFamily: "Gilroy Medium",
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(
                          12,
                        )),
                    child: Text(
                      "Now",
                      style: TextStyle(
                        fontFamily: "Gilroy Medium",
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Address",
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
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.storeloc,
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
              GestButton(
                Width: 200,
                height: 50,
                buttoncolor: blueColor,
                margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                buttontext: "Add New Adress ".tr,
                style: TextStyle(
                  fontFamily: FontFamily.gilroyBold,
                  color: WhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                onclick: () {
                  Get.to(DeliveryAddress1());
                },
              ),
              SizedBox(
                height: 10,
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
                  Get.to(Dropofwatingscreen());
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
