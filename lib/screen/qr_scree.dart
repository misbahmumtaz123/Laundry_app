import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({super.key});

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "QR Code",
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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Show Driver to confirm receiving the delivery ",
              style: TextStyle(
                fontFamily: "Gilroy Bold",
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/qr-code.png",
                height: MediaQuery.of(context).size.height / 3,
              ),
            ),
            Text(
              "Code: 7890",
              style: TextStyle(
                fontFamily: "Gilroy Bold",
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
