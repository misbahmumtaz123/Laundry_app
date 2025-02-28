// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pretty_qr_code/pretty_qr_code.dart';
//
// class OrderDetailScreen extends StatefulWidget {
//   final String customerId;
//
//   const OrderDetailScreen({super.key, required this.customerId});
//
//   @override
//   _OrderDetailScreenState createState() => _OrderDetailScreenState();
// }
//
// class _OrderDetailScreenState extends State<OrderDetailScreen> {
//   @protected
//   late QrImage qrImage;
//
//   @override
//   void initState() {
//     super.initState();
//
//     final qrCode = QrCode(
//       8,
//       QrErrorCorrectLevel.H, // High error correction
//     )..addData(widget.customerId);
//
//     qrImage = QrImage(qrCode);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Order Detail",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.blueAccent,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.all(20),
//           margin: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.shade300,
//                 blurRadius: 5,
//                 spreadRadius: 2,
//                 offset: Offset(2, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "Show Driver to confirm receiving the delivery",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 20),
//               PrettyQrView(
//                 qrImage: qrImage,
//                 decoration: PrettyQrDecoration(),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 "Code : ${widget.customerId}",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class OrderDetailScreen extends StatelessWidget {
  final String customerId;
  final String orderId;

  OrderDetailScreen({required this.customerId, required this.orderId});

  @override
  Widget build(BuildContext context) {
    // Convert data to JSON string for QR code
    String qrData = jsonEncode({
      "customerId": customerId,
      "orderId": orderId,
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Detail"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Show Driver to confirm receiving the delivery",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              PrettyQr(
                typeNumber: 3,
                size: 150,
                data: qrData,
                errorCorrectLevel: QrErrorCorrectLevel.M,
                roundEdges: true,
              ),
              SizedBox(height: 20),
              Text(
                "Order ID: $orderId",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  //Get.to(() => ScanQRCodeScreen());
                },
                child: Text("Scan QR Code"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

