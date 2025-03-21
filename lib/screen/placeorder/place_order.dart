import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/controller/product_controller.dart';
import '../../model/laundryment_search_model.dart';
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
                  Text(
                    laundry.name,
                    style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    laundry.address,
                    style: TextStyle(fontSize: screenWidth * 0.035, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${laundry.distance.toStringAsFixed(2)} km",
                        style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
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

            // Dynamic Data Section for Rating, Distance, and Timing
            LayoutBuilder(
              builder: (context, constraints) {
                bool isWideScreen = constraints.maxWidth > 600;
                return isWideScreen
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _buildDynamicInfoWidgets(screenWidth, laundry),
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildDynamicInfoWidgets(screenWidth, laundry),
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

  // Widget to build dynamic info for Rating, Distance, and Time
  List<Widget> _buildDynamicInfoWidgets(double screenWidth, Laundry laundry) {
    return [
      Row(
        children: [
          const Icon(Icons.star, color: Colors.orange, size: 20),
          const SizedBox(width: 4),
          Text(
            laundry.rating != null ? laundry.rating!.toStringAsFixed(1) : "N/A",
            style: TextStyle(fontSize: screenWidth * 0.035),
          ),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.location_on, color: Colors.green, size: 20),
          const SizedBox(width: 4),
          Text(
            "${laundry.distance.toStringAsFixed(2)} Km",
            style: TextStyle(fontSize: screenWidth * 0.035),
          ),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.access_time, color: Colors.blue, size: 20),
          const SizedBox(width: 4),
          Text(
            "${laundry.startTime} - ${laundry.endTime}",
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
  bool isWeightUnknown = false;
  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantity = widget.product.selectedQuantity == 'Single' ? 1 : 2;
    if (widget.product.selectedWeight != null) {
      weightController.text = widget.product.selectedWeight!.toString();
    } else {
      weightController.text = '';
    }
  }

  void increaseQuantity() {
    if (!isWeightUnknown) {
      setState(() {
        quantity++;
        widget.product.updateQuantity(quantity == 1 ? 'Single' : 'Double');
        updatePrice();
      });
    }
  }

  void decreaseQuantity() {
    if (quantity > 1 && !isWeightUnknown) {
      setState(() {
        quantity--;
        widget.product.updateQuantity(quantity == 1 ? 'Single' : 'Double');
        updatePrice();
      });
    }
  }

  void updatePrice() {
    double price = widget.product.basePrice;

    // If weight is provided, update price based on weight
    if (weightController.text.isNotEmpty && !isWeightUnknown) {
      double weight = double.parse(weightController.text);
      price = widget.product.basePrice * weight;
    }

    // Update the total price based on quantity and weight
    setState(() {
      widget.product.totalPrice = price * quantity;
    });
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
                  // Display price after quantity and weight are adjusted
                  Text(
                    "\$${(widget.product.totalPrice).toStringAsFixed(2)}",
                    style: TextStyle(fontSize: widget.screenWidth * 0.035, color: Colors.green),
                  ),
                  const SizedBox(height: 8),

                  // Show dropdown only for blankets and comforters
                  if (widget.product.productName.contains('Blanket') || widget.product.productName.contains('Comforter'))
                    Column(
                      children: [
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
                                updatePrice();
                              });
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Minus Button
                            GestureDetector(
                              onTap: decreaseQuantity,
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 18,
                                child: const Icon(Icons.remove, color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Quantity
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "$quantity",
                                style: TextStyle(fontSize: widget.screenWidth * 0.04, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Plus Button
                            GestureDetector(
                              onTap: increaseQuantity,
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 18,
                                child: const Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  else
                  // For other products, we don't show the quantity adjustment buttons
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isWeightUnknown,
                              onChanged: (value) {
                                setState(() {
                                  isWeightUnknown = value ?? false;
                                  if (isWeightUnknown) {
                                    weightController.text = '';
                                  }
                                  updatePrice();  // Update price when weight unknown status is changed
                                });
                              },
                            ),
                            Text("I don't know the weight"),
                          ],
                        ),
                        TextField(
                          controller: weightController,
                          decoration: const InputDecoration(
                            labelText: 'Enter weight in pounds',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (!isWeightUnknown) {
                              updatePrice();
                            }
                          },
                          enabled: !isWeightUnknown,
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
