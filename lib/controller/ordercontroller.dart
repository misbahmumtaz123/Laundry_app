import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/order_model.dart';

class OrderController {
  final Dio _dio = Dio();
  final String _baseUrl = "https://laundry.saleselevation.tech/user_api/u_new_order.php";

  Future<NewOrder> placeOrder(Map<String, dynamic> orderData) async {
    try {
      // Retrieve the stored token and customer ID
      final prefs = await SharedPreferences.getInstance();
      final String? securityToken = prefs.getString('auth_token');
      final String? customerId = prefs.getString('customer_id');

      if (securityToken == null || customerId == null) {
        throw Exception("Security token or customer ID not found. Please login again.");
      }

      // Add security token and customer ID to the order data
      orderData["security_token"] = securityToken;
      orderData["customer_id"] = customerId;

      // Add security token to headers
      final headers = {
        "Content-Type": "application/json",
        "Security-Token": securityToken,
      };

      // Make the API request
      final response = await _dio.post(
        _baseUrl,
        data: jsonEncode(orderData),
        options: Options(headers: headers),
      );

      // Log the response for debugging
      print("API Response: ${response.data}");

      // Check response status
      if (response.statusCode == 200) {
        return NewOrder.fromJson(response.data);
      } else {
        throw Exception("Failed to place order. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error placing order: $e");
    }
  }
}