import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/screen/ordersScreens/OrderDetails.dart';
import '../../model/c_orderScreenModel.dart';

class ConfirmSuccess extends StatelessWidget {
  final Orders order; // Declare order as a required parameter

  ConfirmSuccess({required this.order}); // Pass order in constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD5E9F7),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          bool isWeb = width > 600;

          return Center(
            child: Container(
              width: isWeb ? 400 : double.infinity,
              padding: EdgeInsets.symmetric(horizontal: isWeb ? 20 : 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your Laundry is\non the way",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isWeb ? 24 : 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  SizedBox(height: isWeb ? 50 : 40),

                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(isWeb ? 40 : 30),
                    child: Icon(
                      Icons.check,
                      color: Colors.green,
                      size: isWeb ? 80 : 60,
                    ),
                  ),
                  SizedBox(height: isWeb ? 70 : 60),

                  SizedBox(
                    width: isWeb ? 250 : 200,
                    height: isWeb ? 55 : 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => OrderDetailsScreen(order: order)); // ✅ Pass order to details screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF5567C9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "View Detail",
                        style: TextStyle(fontSize: isWeb ? 18 : 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
