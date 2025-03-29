// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Api/config.dart';
// import '../model/c_orderScreenModel.dart';
//
// class CurrentOrderController extends GetxController {
//   final Dio _dio = Dio();
//   var currentOrders = <CurrentOrder>[].obs; // This will hold the list of CurrentOrder
//   var isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchCurrentOrders();
//   }
//   Future<void> fetchCurrentOrders() async {
//     isLoading(true); // Start loading
//
//     try {
//       print("Fetching current orders from: ${Config.getAllOrdersApi}");
//
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('auth_token');
//       String? customerId = prefs.getString('customer_id'); // Retrieve customer_id
//
//       if (token == null || token.isEmpty) {
//         print("❌ Error: No authentication token found!");
//         isLoading(false);
//         return;
//       }
//
//       if (customerId == null || customerId.isEmpty) {
//         print("❌ Error: No customer ID found!");
//         isLoading(false);
//         return;
//       }
//
//       final response = await _dio.post(
//         Config.getAllOrdersApi,
//         data: {"customer_id": customerId},
//         options: Options(
//           headers: {"security_token": token, 'Content-Type': 'application/json'},
//         ),
//       );
//
//       print("🔄 API Response: ${response.data}");  // Log the entire API response
//
//       if (response.statusCode == 200 && response.data['ResponseCode'].toString() == "200") {
//         List orders = response.data['Orders'] ?? [];
//         print("Orders from API: $orders"); // Log the Orders list
//
//         if (orders.isEmpty) {
//           print("ℹ No current orders found.");
//         }
//
//         // Assigning the orders to the observable list
//         currentOrders.assignAll(
//           orders.map((json) {
//             try {
//               return CurrentOrder.fromJson(json);
//             } catch (e) {
//               print("Error parsing order: $e");
//               return null;
//             }
//           }).whereType<CurrentOrder>().toList(),
//         );
//
//         print("currentOrders length after fetch: ${currentOrders.length}"); // Log length of currentOrders
//         currentOrders.refresh(); // Ensure UI is updated
//       } else {
//         print("⚠ Unexpected API Response: ${response.data}");
//       }
//     } catch (e) {
//       print("🚨 Error fetching current orders: $e");
//     } finally {
//       isLoading(false); // End loading
//     }
//   }
//
// }
import 'dart:convert';
import 'package:dio/dio.dart' as dio; // Import with alias
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/c_orderScreenModel.dart';

class OrderController extends GetxController {
  final dio.Dio _dio = dio.Dio();
  var isLoading = false.obs;
  var ordersList = <Orders>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    isLoading(true);

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      String? customerId = prefs.getString('customer_id');

      if (token == null || customerId == null || token.isEmpty || customerId.isEmpty) {
        Get.snackbar("Error", "Missing authentication token or customer ID");
        isLoading(false);
        return;
      }

      var url = "https://laundry.saleselevation.tech/user_api/u_get_pending_orders.php";

      dio.Response response = await _dio.post(
        url,
        data: {"customer_id": customerId},
        options: dio.Options(
          headers: {
            "security_token": token,
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print("🔄 API Response: ${response.data}");
        var jsonData = response.data;

        if (jsonData['ResponseCode'] == "200" && jsonData['Result'] == "true") {
          CurrentOrder currentOrder = CurrentOrder.fromJson(jsonData);
          if (currentOrder.orders != null && currentOrder.orders!.isNotEmpty) {
            ordersList.assignAll(currentOrder.orders!);
          } else {
            Get.snackbar("No Pending Orders", "No orders are pending.");
          }
        } else {
          Get.snackbar("Error", jsonData['ResponseMsg'] ?? "Failed to load orders");
        }
      } else {
        Get.snackbar("Error", "Failed to load orders");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading(false);
    }
  }
}




