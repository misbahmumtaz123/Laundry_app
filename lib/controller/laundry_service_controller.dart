import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:laundry/Api/config.dart';

import '../model/laundry_service_model.dart';


class LaundryServicesController extends GetxController {
  var services = <LaundryService>[].obs;
  var isLoading = true.obs;

  Future<void> fetchLaundryServices() async {
    final String url = Config.getLaundryServicesApi;

    try {
      isLoading(true); // Start loading

      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        var data = LaundryServiceResponse.fromJson(response.data);

        if (data.result) {
          services.value = data.services; // Update the services list
        } else {
          print("Error: ${data.responseMsg}");
        }
      } else {
        print("Failed to load services: ${response.statusMessage}");
      }
    } catch (e) {
      print('Error fetching laundry services: $e');
    } finally {
      isLoading(false); // Stop loading
    }
  }
}