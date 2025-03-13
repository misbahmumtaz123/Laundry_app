import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../model/laundry_service_model.dart';

class LaundryServiceController extends GetxController {
  var isLoading = true.obs;
  var servicesList = <LaundryService>[].obs;

  final Dio _dio = Dio();

  Future<void> fetchLaundryServices() async {
    try {
      isLoading(true);
      var response = await _dio.get('https://laundry.saleselevation.tech/user_api/get_laundry_services.php');

      if (response.statusCode == 200 && response.data['Result'] == "true") {
        var services = response.data['Services'] as List;
        servicesList.value = services.map((json) => LaundryService.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching services: $e");
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    fetchLaundryServices();
    super.onInit();
  }
}
