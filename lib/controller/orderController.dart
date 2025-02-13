// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:laundry/model/order_model.dart';
//
// import '../Api/config.dart';
//
//
// class OrderController {
//   final Dio _dio = Dio();
//
//   Future<OrderResponse> placeOrder(OrderModel order) async {
//     try {
//       final response = await _dio.post(
//         Config.orderApi,
//         data: jsonEncode(order.toJson()),
//         options: Options(headers: {"Content-Type": "application/json"}),
//       );
//
//       if (response.statusCode == 200) {
//         return OrderResponse.fromJson(response.data);
//       } else {
//         throw Exception("Failed to place order");
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:laundry/model/order_model.dart';
import '../Api/config.dart';

class OrderController {
  final Dio _dio = Dio();

  Future<OrderResponse> placeOrder(OrderModel order) async {
    try {
      // Print the request payload for debugging
      print("Request Payload: ${jsonEncode(order.toJson())}");
      print("API Endpoint: ${Config.orderApi}");

      final response = await _dio.post(
        Config.orderApi,
        data: jsonEncode(order.toJson()),
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      // Print the raw response for debugging
      print("Response Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        print("vbc to place order. Status Code: ${response.statusCode}");
        return OrderResponse.fromJson(response.data);
      } else {
       // print("Failed to place order. Status Code: ${response.statusCode}");
        throw Exception("Failed to place order");
      }
    } catch (e) {
      // Print the error for debugging
      print("Error occurred: $e");
      rethrow;
    }
  }
}

