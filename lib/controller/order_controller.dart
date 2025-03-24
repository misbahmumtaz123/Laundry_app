// order_controller.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:laundry/Api/config.dart';

import '../model/order_model2.dart';

class OrderController extends GetxController {
  var orders = <Order>[].obs;
  var isLoading = false.obs;

  // Fetch the pickup times and delivery types from the API
  Future<void> fetchPickupAndDeliveryTimes() async {
    try {
      isLoading(true);

      var response = await Dio().get(Config.getAllOrdersApi);

      if (response.statusCode == 200) {
        List<dynamic> orderData = response.data['Orders'];
        orders.value = orderData
            .map((orderJson) => Order.fromJson(orderJson))
            .toList();
      } else {
        throw Exception('Failed to fetch orders');
      }
    } catch (e) {
      print('Error fetching order data: $e');
    } finally {
      isLoading(false);
    }
  }
}
