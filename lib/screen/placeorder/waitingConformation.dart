// import 'package:flutter/material.dart';
// import 'package:laundry/controller/orderController.dart';
// import 'package:laundry/model/order_model.dart';
// import 'package:laundry/utils/Colors.dart';
//
// class OrderScreen extends StatefulWidget {
//   final String customerId;
//
//   const OrderScreen({Key? key, required this.customerId}) : super(key: key);
//
//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }
//
// class _OrderScreenState extends State<OrderScreen> {
//   late Future<OrderModel?> _orderFuture;
//   bool _isProcessing = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _orderFuture = OrderController().fetchOrderDetails(widget.customerId);
//     Future.delayed(const Duration(seconds: 3), () {
//       setState(() {
//         _isProcessing = false;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<OrderModel?>(
//         future: _orderFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return _buildProcessingScreen(); // While the data is loading
//           } else if (snapshot.hasData && snapshot.data != null) {
//             return _isProcessing
//                 ? _buildProcessingScreen()
//                 : _buildReadyScreen(snapshot.data!); // After data is loaded
//           } else {
//             return Center(
//               child: Text(
//                 'Error loading data',
//                 style: TextStyle(fontSize: 18, color: Colors.red),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildProcessingScreen() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Your Delivery is processed for Payment',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             const CircularProgressIndicator(),
//             const SizedBox(height: 20),
//             const Text(
//               'Please Wait a second',
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Waiting for Laundry Confirmation',
//               style: TextStyle(fontSize: 16, color: Colors.red),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text('Receipt: 5586552'),
//                   SizedBox(height: 10),
//                   Text('Updating Price ........'),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: primeryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text('View Detail'),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: primeryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text('Confirm & Pay'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildReadyScreen(OrderModel order) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Your Delivery is Ready for Payment',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             const CircleAvatar(
//               radius: 40,
//               backgroundColor: Colors.green,
//               child: Icon(Icons.check, size: 40, color: Colors.white),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Ready',
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Waiting for Laundry Confirmation',
//               style: TextStyle(fontSize: 16, color: Colors.red),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Receipt: ${order.receiptUrl}'),
//                   const SizedBox(height: 10),
//                   Text('Laundry Price: \$${order.orderPrice.toStringAsFixed(2)}'),
//                   const Text('Delivery: \$5.00'),
//                   Text('Total: \$${(order.orderPrice + 5.0).toStringAsFixed(2)}'),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Darkblue2, // Button color from color.dart file
//                 padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15), // Button padding
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15), // Rounded corners
//                 ),
//                 elevation: 5, // Button shadow effect
//               ),
//               child: const Text('View Detail'),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Darkblue2, // Button color from color.dart file
//                 padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15), // Button padding
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15), // Rounded corners
//                 ),
//                 elevation: 5, // Button shadow effect
//               ),
//               child: const Text('Confirm & Pay'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
