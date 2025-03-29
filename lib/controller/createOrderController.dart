// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../model/createOrderModel.dart';
//
//
// class OrderController {
//   final Dio _dio = Dio();
//   final String _baseUrl = "https://laundry.saleselevation.tech/user_api/u_new_order.php";
//
//   Future<OrderModel> PlaceOrd(Map<String, dynamic> orderData) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final String? securityToken = prefs.getString('auth_token');
//       final String? customerId = prefs.getString('customer_id');
//
//       if (securityToken == null || customerId == null) {
//         print("❌ Error: Security token or customer ID is NULL!");
//         throw Exception("Security token or customer ID not found. Please login again.");
//       }
//
//       print("✅ Retrieved Security Token: $securityToken");
//       print("✅ Retrieved Customer ID: $customerId");
//
//       // Add security token and customer ID to the request body
//       orderData["security_token"] = securityToken;
//       orderData["customer_id"] = customerId;
//
//       print("📤 Request Payload: ${jsonEncode(orderData)}");
//
//       final headers = {
//         "Content-Type": "application/json",
//         "Security-Token": securityToken,  // ✅ Ensure correct header value
//       };
//
//       final response = await _dio.post(
//         _baseUrl,
//         data: jsonEncode(orderData),
//         options: Options(headers: headers),
//       );
//
//       print("✅ API Response: ${response.statusCode}");
//       print("✅ API Response Data: ${response.data}");
//
//       if (response.statusCode == 200) {
//         return OrderModel.fromJson(response.data);
//       } else {
//         print("❌ Error: API Request Failed with Status Code: ${response.statusCode}");
//         throw Exception("Failed to place order. Status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("❌ Error: Exception Occurred - $e");
//       throw Exception("Error placing order: $e");
//     }
//   }
// }
//
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/createOrderModel.dart';
import '../model/order_model.dart';

class OrderController {
  final Dio _dio = Dio();
  final String _baseUrl = "https://laundry.saleselevation.tech/user_api/u_new_order.php";

  Future<OrderModel> placeOrder(OrderModel order) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? securityToken = prefs.getString('auth_token');
      final String? customerId = prefs.getString('customer_id');

      if (securityToken == null || customerId == null) {
        print("❌ Error: Security token or customer ID is NULL!");
        throw Exception("Security token or customer ID not found. Please login again.");
      }

      print("✅ Retrieved Security Token: $securityToken");
      print("✅ Retrieved Customer ID: $customerId");

      // Convert OrderModel to JSON
      Map<String, dynamic> orderData = order.toJson();

      // Add security token and customer ID to request body
      orderData["security_token"] = securityToken;
      orderData["customer_id"] = int.tryParse(customerId) ?? 0;

      print("📤 Request Payload: ${jsonEncode(orderData)}");

      final headers = {
        "Content-Type": "application/json",
        "Security-Token": securityToken,
      };

      final response = await _dio.post(
        _baseUrl,
        data: jsonEncode(orderData),
        options: Options(headers: headers),
      );

      print("✅ API Response: ${response.statusCode}");
      print("✅ API Response Data: ${response.data}");

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData["ResponseCode"] == "200" && responseData["Result"] == "true") {
          print("✅ Order Placed Successfully!");
          return OrderModel.fromJson(responseData);
        } else {
          print("❌ API Error: ${responseData["message"]}");
          throw Exception(responseData["message"]);
        }
      } else {
        print("❌ Error: API Request Failed with Status Code: ${response.statusCode}");
        throw Exception("Failed to place order. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Error: Exception Occurred - $e");
      throw Exception("Error placing order: $e");
    }
  }
}
