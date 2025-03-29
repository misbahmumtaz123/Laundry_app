import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/h_orderScreenModel.dart';

class HistoryOrderController extends GetxController {
  final Dio _dio = Dio();
  var historyOrders = <HistoryOrder>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistoryOrders();
  }

  Future<void> fetchHistoryOrders() async {
    isLoading(true);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      String? customerId = prefs.getString('customer_id');

      if (token == null || customerId == null) {
        print("❌ No authentication token or customer ID found!");
        isLoading(false);
        return;
      }

      print("🚀 Fetching completed orders for Customer ID: $customerId");

      final response = await _dio.post(
        "https://laundry.saleselevation.tech/user_api/get_all_completed_orders.php",
        data: {"customer_id": customerId},
        options: Options(headers: {
          "Security-Token": token,
          'Content-Type': 'application/json',
        }),
      );

      print("🔄 Response Status: ${response.statusCode}");
      print("🔄 Response Data: ${response.data}");

      if (response.statusCode == 200 && response.data['ResponseCode'] == "200") {
        List orders = response.data['Orders'];
        historyOrders.assignAll(orders.map((json) => HistoryOrder.fromJson(json)).toList());
      } else {
        print("⚠ Unexpected response: ${response.data}");
      }
    } catch (e) {
      print("🚨 Error fetching history orders: $e");
    } finally {
      isLoading(false);
    }
  }
}

