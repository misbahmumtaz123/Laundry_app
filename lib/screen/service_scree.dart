import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:laundry/screen/yourcart_screen.dart';

import '../model/fontfamily_model.dart';
import '../utils/Colors.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cartViewList.isNotEmpty ? bgcolor : WhiteColor,
      appBar: AppBar(
        title: Text(
          "Your Cart".tr,
          style: TextStyle(
            color: BlackColor,
            fontFamily: FontFamily.gilroyBold,
            fontSize: 18,
          ),
        ),
        backgroundColor: WhiteColor,
        elevation: 0,
        leading: BackButton(
          color: BlackColor,
          onPressed: () {
            Get.back();
          },
        ),
      ),
    );
  }
}