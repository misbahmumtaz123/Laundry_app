// class OrderModel {
//   final int customerId;
//   final int laundromatId;
//   final String orderType;
//   final String orderStatus;
//   final List<String> pickupTime;
//   final List<int> productType;
//   final List<int> variationId;
//   final List<int> quantity;
//   final List<double> price;
//   final double totalPrice;
//   final String payment;
//   final String deliveryMethod;
//   final String deliveryType;
//   final String orderInstructions;
//   final String orderAddress;
//   final List<String> orderTemp;
//   final String houseStatus;
//   final String aptNo;
//   final int elevatorStatus;
//   final int floor;
//   final String deliveryStatus;
//
//   OrderModel({
//     required this.customerId,
//     required this.laundromatId,
//     required this.orderType,
//     required this.orderStatus,
//     required this.pickupTime,
//     required this.productType,
//     required this.variationId,
//     required this.quantity,
//     required this.price,
//     required this.totalPrice,
//     required this.payment,
//     required this.deliveryMethod,
//     required this.deliveryType,
//     required this.orderInstructions,
//     required this.orderAddress,
//     required this.orderTemp,
//     required this.houseStatus,
//     required this.aptNo,
//     required this.elevatorStatus,
//     required this.floor,
//     required this.deliveryStatus,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       "customer_id": customerId,
//       "laundromat_id": laundromatId,
//       "order_type": orderType,
//       "order_status": orderStatus,
//       "pickuptime": pickupTime,
//       "product_type": productType,
//       "variation_id": variationId,
//       "quantity": quantity,
//       "price": price,
//       "total_price": totalPrice.toStringAsFixed(2),
//       "payment": payment,
//       "delivery_method": deliveryMethod,
//       "delivery_type": deliveryType,
//       "order_instructions": orderInstructions,
//       "order_address": orderAddress,
//       "order_temp": orderTemp,
//       "house_status": houseStatus,
//       "apt_no": aptNo,
//       "elevator_status": elevatorStatus,
//       "floor": floor,
//       "delivery_status": deliveryStatus,
//     };
//   }
// }
