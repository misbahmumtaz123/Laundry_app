class OrderModel {
  final String customerId;
  final String laundromatId;
  final String orderTime;
  final String orderType;
  final String orderStatus;
  final String driverAssignedId;
  final List<String> pickuptime;
  final String receipt;
  final String rating;
  final String attachment;
  final String deliveryCode;
  final String totalPrice;
  final List<String> productType;
  final List<String> quantity;
  final List<String> price;
  final List<String?> weight;

  OrderModel({
    required this.customerId,
    required this.laundromatId,
    required this.orderTime,
    required this.orderType,
    required this.orderStatus,
    required this.driverAssignedId,
    required this.pickuptime,
    required this.receipt,
    required this.rating,
    required this.attachment,
    required this.deliveryCode,
    required this.totalPrice,
    required this.productType,
    required this.quantity,
    required this.price,
    required this.weight,
  });

  Map<String, dynamic> toJson() {
    return {
      "customer_id": customerId,
      "laundromat_id": laundromatId,
      "order_time": orderTime,
      "order_type": orderType,
      "order_status": orderStatus,
      "driver_assigned_id": driverAssignedId,
      "pickuptime": pickuptime,
      "receipt": receipt,
      "rating": rating,
      "attachment": attachment,
      "delivery_code": deliveryCode,
      "total_price": totalPrice,
      "product_type": productType,
      "quantity": quantity,
      "price": price,
      "weight": weight,
    };
  }
}

class OrderResponse {
  final String responseCode;
  final bool result;
  final String title;
  final String message;

  OrderResponse({
    required this.responseCode,
    required this.result,
    required this.title,
    required this.message,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      responseCode: json['ResponseCode'],
      result: json['Result'] == "true",
      title: json['title'],
      message: json['message'],
    );
  }
}
