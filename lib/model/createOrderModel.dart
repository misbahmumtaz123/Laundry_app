import 'dart:convert';

class OrderModel {
  final int customerId;
  final int laundromatId;
  final String orderType;
  final String orderStatus;
  final List<String> pickupTime;
  final List<int> productType;
  final List<int> variationId;
  final List<int> quantity;
  final List<double> price;
  final double totalPrice;
  final String payment;
  final String deliveryMethod;
  final String deliveryType;
  final String orderInstructions;
  final String orderAddress;
  final List<String> orderTemp;
  final String houseStatus;
  final String aptNo;
  final int elevatorStatus;
  final int floor;
  final String deliveryStatus;
  final int? orderQId; // ✅ Matches API response
  final String? orderTime; // ✅ Matches API response

  OrderModel({
    required this.customerId,
    required this.laundromatId,
    required this.orderType,
    required this.orderStatus,
    required this.pickupTime,
    required this.productType,
    required this.variationId,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.payment,
    required this.deliveryMethod,
    required this.deliveryType,
    required this.orderInstructions,
    required this.orderAddress,
    required this.orderTemp,
    required this.houseStatus,
    required this.aptNo,
    required this.elevatorStatus,
    required this.floor,
    required this.deliveryStatus,
    this.orderQId,
    this.orderTime,
  });

  // ✅ Convert Object to JSON (Request Body)
  Map<String, dynamic> toJson() {
    return {
      "customer_id": customerId,
      "laundromat_id": laundromatId,
      "order_type": orderType,
      "order_status": orderStatus,
      "pickuptime": pickupTime,
      "product_type": productType,
      "variation_id": variationId,
      "quantity": quantity,
      "price": price.map((p) => p.toStringAsFixed(2)).toList(), // Ensure correct format
      "total_price": totalPrice.toStringAsFixed(2), // Convert to String for API precision
      "payment": payment,
      "delivery_method": deliveryMethod,
      "delivery_type": deliveryType,
      "order_instructions": orderInstructions,
      "order_address": orderAddress,
      "order_temp": orderTemp,
      "house_status": houseStatus,
      "apt_no": aptNo,
      "elevator_status": elevatorStatus,
      "floor": floor,
      "delivery_status": deliveryStatus,
    };
  }

  // ✅ Convert JSON (API Response) to Object
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      customerId: json["customer_id"] ?? 0,
      laundromatId: json["laundromat_id"] ?? 0,
      orderType: json["order_type"] ?? "",
      orderStatus: json["order_status"] ?? "",
      pickupTime: List<String>.from(json["pickuptime"] ?? []),
      productType: List<int>.from(json["product_type"] ?? []),
      variationId: List<int>.from(json["variation_id"] ?? []),
      quantity: List<int>.from(json["quantity"] ?? []),
      price: (json["price"] as List?)?.map((p) => double.tryParse(p.toString()) ?? 0.0).toList() ?? [],
      totalPrice: double.tryParse(json["total_price"].toString()) ?? 0.0,
      payment: json["payment"] ?? "",
      deliveryMethod: json["delivery_method"] ?? "",
      deliveryType: json["delivery_type"] ?? "",
      orderInstructions: json["order_instructions"] ?? "",
      orderAddress: json["order_address"] ?? "",
      orderTemp: List<String>.from(json["order_temp"] ?? []),
      houseStatus: json["house_status"] ?? "",
      aptNo: json["apt_no"] ?? "",
      elevatorStatus: json["elevator_status"] ?? 0,
      floor: json["floor"] ?? 0,
      deliveryStatus: json["delivery_status"] ?? "",
      orderQId: int.tryParse(json["order_q_id"]?.toString() ?? "0"),
      orderTime: json["order_time"],
    );
  }
}
