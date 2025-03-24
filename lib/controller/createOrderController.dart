// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../Api/config.dart';
// import '../model/createOrderModel.dart';
// import '../model/order_model2.dart';
//
// class OrderController extends GetxController {
//   var orders = <Order>[].obs;
//   var isLoading = false.obs;
//   final Dio _dio = Dio();
//
//   // ✅ Fetch All Orders (Updated method name)
//   Future<void> fetchOrders() async {
//     try {
//       isLoading(true);
//
//       var response = await _dio.get(Config.getAllOrdersApi);
//
//       if (response.statusCode == 200) {
//         List<dynamic> orderData = response.data['Orders'];
//         orders.value = orderData.map((json) => Order.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to fetch orders');
//       }
//     } catch (e) {
//       print('❌ Error fetching order data: $e');
//       Get.snackbar("Error", "Could not load orders.");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   // ✅ Place Order
//   Future<void> placeOrder(OrderModel order) async {
//     isLoading.value = true;
//
//     try {
//       // Retrieve stored token and customer ID
//       final prefs = await SharedPreferences.getInstance();
//       final String? securityToken = prefs.getString('auth_token');
//       final String? customerId = prefs.getString('customer_id');
//
//       if (securityToken == null || customerId == null) {
//         Get.snackbar("Error", "Authentication failed. Please login again.");
//         throw Exception("Security token or customer ID not found.");
//       }
//
//       // Attach token & customer ID
//       var orderData = order.toJson();
//       orderData["security_token"] = securityToken;
//       orderData["customer_id"] = int.tryParse(customerId) ?? 0;
//
//       // Define headers
//       final headers = {
//         "Content-Type": "application/json",
//         "Security-Token": securityToken,
//       };
//
//       print("⏳ Sending order data: ${jsonEncode(orderData)}");
//
//       // Send API request
//       final response = await _dio.post(
//         Config.orderApi,
//         data: jsonEncode(orderData),
//         options: Options(headers: headers),
//       );
//
//       print("✅ API Response: ${response.data}");
//
//       if (response.statusCode == 200) {
//         Get.snackbar("Success", "Order placed successfully!");
//       } else {
//         Get.snackbar("Error", "Failed to place order: ${response.data}");
//       }
//     } catch (e) {
//       print("❌ Error placing order: $e");
//       Get.snackbar("Error", "Something went wrong: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
