
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:laundry/Api/config.dart';
import 'package:laundry/model/laundryment_search_model.dart';

class LaundryController extends GetxController {
  var laundromats = <Laundry>[].obs;
  var filteredLaundromats = <Laundry>[].obs;
  var isLoading = true.obs;

  Future<void> fetchLaundromats(double latitude, double longitude) async {
    final String url = '${Config.baseurl}${Config.getLaundromatsApi}';

    try {
      isLoading(true);

      var response = await Dio().get(url, queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
      });

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        laundromats.value = data.map((json) => Laundry.fromJson(json)).toList();
        filteredLaundromats.value = laundromats;
      } else {
        throw Exception('Failed to load laundromats');
      }
    } catch (e) {
      print('Error fetching laundromats: $e');
    } finally {
      isLoading(false);
    }
  }

  void searchLaundromats(String query) {
    if (query.isEmpty) {
      filteredLaundromats.value = laundromats;
    } else {
      filteredLaundromats.value = laundromats.where((laundromat) =>
          laundromat.name.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }
}
