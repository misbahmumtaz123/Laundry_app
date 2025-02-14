import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api/config.dart';
import '../model/c_orderScreenModel.dart';

class CurrentOrderController extends GetxController {
  final Dio _dio = Dio();
  var currentOrders = <CurrentOrder>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentOrders();
  }

  Future<void> fetchCurrentOrders() async {
    isLoading(true);
    try {
      print("Fetching current orders from: ${Config.getAllOrdersApi}");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      // Debugging: Print token before sending request
      print("Token: $token");

      if (token == null || token.isEmpty) {
        print("❌ Error: No authentication token found!");
        isLoading(false);
        return;
      }

      // API Request with correct headers
      final response = await _dio.get(
        Config.getAllOrdersApi,
        options: Options(
          headers: {
            "security_token": token,
            'Content-Type': 'application/json',
          },
        ),
      );

      // Debugging: Print API response
      print("🔄 API Response: ${response.data}");

      if (response.statusCode == 200 && response.data['ResponseCode'] == "200") {
        List orders = response.data['Orders'] ?? [];

        if (orders.isEmpty) {
          print("ℹ️ No current orders found.");
        }

        currentOrders.assignAll(orders.map((json) => CurrentOrder.fromJson(json)).toList());
        print("✅ Current Orders Updated: ${currentOrders.length} orders loaded.");
      } else {
        print("⚠️ Unexpected API Response: ${response.data}");
      }
    } catch (e) {
      print("🚨 Error fetching current orders: $e");
    } finally {
      isLoading(false);
    }
  }
}
