import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/model/laundryment_search_model.dart';
import 'package:laundry/controller/product_controller.dart';
import '../../model/product_model.dart';

class PlaceOrderScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments as Map<String, dynamic>;
    final Laundry laundry = Laundry.fromJson(data["laundry"]);
    final String serviceName = data["serviceName"] ?? "Unknown Service";
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Place Order"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Laundry Details Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(laundry.name, style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold)),
                  Text(laundry.address, style: TextStyle(fontSize: screenWidth * 0.035, color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${laundry.distance.toStringAsFixed(2)} km", style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.blue, fontWeight: FontWeight.bold)),
                      Text(
                        laundry.status.toUpperCase(),
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          color: laundry.status.toLowerCase() == "open" ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Row for rating, distance, and time
            LayoutBuilder(
              builder: (context, constraints) {
                bool isWideScreen = constraints.maxWidth > 600;
                return isWideScreen
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _buildInfoWidgets(screenWidth),
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildInfoWidgets(screenWidth),
                );
              },
            ),

            const SizedBox(height: 20),

            Text(
              "Selected Service: $serviceName",
              style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold, color: Colors.blue),
            ),

            const SizedBox(height: 20),

            // Product Selection Section
            Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Products", style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  for (var product in productController.products)
                    ProductCard(product: product, screenWidth: screenWidth),
                ],
              );
            }),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildInfoWidgets(double screenWidth) {
    return [
      Row(
        children: [
          const Icon(Icons.star, color: Colors.orange, size: 20),
          const SizedBox(width: 4),
          Text(
            "4.5",
            style: TextStyle(fontSize: screenWidth * 0.035),
          ),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.location_on, color: Colors.green, size: 20),
          const SizedBox(width: 4),
          Text(
            "1.5 Km",
            style: TextStyle(fontSize: screenWidth * 0.035),
          ),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.access_time, color: Colors.blue, size: 20),
          const SizedBox(width: 4),
          Text(
            "9:00 AM - 8:00 PM",
            style: TextStyle(fontSize: screenWidth * 0.035),
          ),
        ],
      ),
    ];
  }
}

class ProductCard extends StatefulWidget {
  final Product product;
  final double screenWidth;

  const ProductCard({required this.product, required this.screenWidth});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late int quantity;
  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantity = widget.product.selectedQuantity == 'Single' ? 1 : 2;
  }

  void increaseQuantity() {
    setState(() {
      quantity++;
      widget.product.updateQuantity(quantity == 1 ? 'Single' : 'Double');
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        widget.product.updateQuantity(quantity == 1 ? 'Single' : 'Double');
      });
    }
  }

  void updatePrice() {
    if (weightController.text.isNotEmpty) {
      double weight = double.parse(weightController.text);
      setState(() {
        widget.product.totalPrice = widget.product.basePrice * weight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.productName,
                    style: TextStyle(fontSize: widget.screenWidth * 0.04, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${(widget.product.basePrice * quantity).toStringAsFixed(2)}",
                    style: TextStyle(fontSize: widget.screenWidth * 0.035, color: Colors.green),
                  ),
                  const SizedBox(height: 8),

                  // Dropdown for blankets/comforters
                  if (widget.product.productName.contains('Blanket') || widget.product.productName.contains('Comforter'))
                    DropdownButton<String>(
                      value: quantity == 1 ? 'Single' : 'Double',
                      items: const [
                        DropdownMenuItem<String>(value: 'Single', child: Text('Single')),
                        DropdownMenuItem<String>(value: 'Double', child: Text('Double')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            quantity = value == 'Single' ? 1 : 2;
                            widget.product.updateQuantity(value);
                          });
                        }
                      },
                    )
                  else
                    Column(
                      children: [
                        TextField(
                          controller: weightController,
                          decoration: const InputDecoration(
                            labelText: 'Enter weight in pounds',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            updatePrice();
                          },
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Total Price: \$${widget.product.totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: widget.screenWidth * 0.035, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

