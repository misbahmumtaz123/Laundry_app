import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api/config.dart';
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
      String? token = prefs.getString('auth_token'); // ✅ Get correct token
      String? customerId = prefs.getString('customer_id'); // ✅ Get customer ID

      if (token == null || customerId == null) {
        print("❌ No authentication token or customer ID found!");
        isLoading(false);
        return;
      }

      print("🚀 Fetching completed orders for Customer ID: $customerId");

      // ✅ Ensure we send only the logged-in user's orders
      final response = await _dio.post(
        Config.getAllCompletedOrdersApi,
        data: {"customer_id": customerId}, // ✅ Send customer ID
        options: Options(headers: {
          "Security-Token": token, // ✅ Ensure token is correct
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
