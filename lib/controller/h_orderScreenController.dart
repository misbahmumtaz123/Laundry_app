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
      print("Fetching current orders from: ${Config.getAllCompletedOrdersApi}");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      // Debugging: Print token before sending request
      print("Token: $token");

      if (token == null || token.isEmpty) {
        print("Error: No authentication token found!");
        isLoading(false);
        return;
      }

      // Ensure the token is passed as "Bearer <token>" in the headers
      final response = await _dio.get(
        Config.getAllCompletedOrdersApi,
        options: Options(
          headers: {
            "security_token": "$token",
            'Content-Type': 'application/json',
          },
        ),
      );

      // Debugging: Print the full response data for inspection
      print("Response: ${response.data}");

      if (response.statusCode == 200 && response.data['ResponseCode'] == "200") {
        List orders = response.data['Orders'];
        historyOrders.assignAll(orders.map((json) => HistoryOrder.fromJson(json)).toList());
      } else {
        print("Unexpected Response: ${response.data}");
      }
    } catch (e) {
      print("Error fetching history orders: $e");
    } finally {
      isLoading(false);
    }
  }
}
