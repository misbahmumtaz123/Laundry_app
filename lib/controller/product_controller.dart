import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../Api/config.dart';
import '../model/product_model.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs; // Stores all available products from API
  var selectedProduct = Rxn<Product>(); // Stores the currently selected product
  var isLoading = false.obs;

  final Dio _dio = Dio(BaseOptions(baseUrl: Config.path));

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response = await _dio.post(
        Config.getProductsLaundryApi,
        options: Options(headers: {"Content-Type": "application/json"}),
        data: {"laundromat_id": "1"},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['Result'] == 'true' && data['Products'] is List) {
          products.value = (data['Products'] as List)
              .map((product) => Product.fromJson(product))
              .toList();
        } else {
          Get.snackbar('Error', 'No products found!');
        }
      } else {
        Get.snackbar('Error', 'Server Error: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    } finally {
      isLoading(false);
    }
  }

  void selectProduct(Product product) {
    selectedProduct.value = product;
  }
}
