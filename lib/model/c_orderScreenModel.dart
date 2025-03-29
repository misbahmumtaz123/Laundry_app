class CurrentOrder {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<Orders>? orders;

  CurrentOrder({this.responseCode, this.result, this.responseMsg, this.orders});

  CurrentOrder.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    if (json['Orders'] != null) {
      orders = <Orders>[];
      json['Orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = this.responseCode;
    data['Result'] = this.result;
    data['ResponseMsg'] = this.responseMsg;
    if (this.orders != null) {
      data['Orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Orders {
  int? id;
  String? orderQId;
  int? customerId;
  int? laundromatId;
  String? orderTime;
  String? orderDate;
  String? orderType;
  String? orderStatus;
  int? driverAssignedId;
  String? orderPrice;
  String? receipt;
  int? rating;
  String? attachment;
  String? deliveryCode;
  String? productType;
  String? createdAt;
  dynamic weight; // weight can be `null`, so we keep it dynamic
  String? pickupOrderTime;
  String? deliveryMethod;
  String? deliveryType;

  Orders({
    this.id,
    this.orderQId,
    this.customerId,
    this.laundromatId,
    this.orderTime,
    this.orderDate,
    this.orderType,
    this.orderStatus,
    this.driverAssignedId,
    this.orderPrice,
    this.receipt,
    this.rating,
    this.attachment,
    this.deliveryCode,
    this.productType,
    this.createdAt,
    this.weight,
    this.pickupOrderTime,
    this.deliveryMethod,
    this.deliveryType,
  });

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderQId = json['order_q_id'];
    customerId = json['customer_id'];
    laundromatId = json['laundromat_id'];
    orderTime = json['order_time'];
    orderDate = json['order_date'];
    orderType = json['order_type'];
    orderStatus = json['order_status'];
    driverAssignedId = json['driver_assigned_id'];
    orderPrice = json['order_price'];
    receipt = json['receipt'];
    rating = json['rating'];
    attachment = json['attachment'];
    deliveryCode = json['delivery_code'];
    productType = json['product_type'];
    createdAt = json['created_at'];
    weight = json['weight']; // It can be null or a valid value
    pickupOrderTime = json['pickup_order_time'];
    deliveryMethod = json['delivery_method'];
    deliveryType = json['delivery_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['order_q_id'] = this.orderQId;
    data['customer_id'] = this.customerId;
    data['laundromat_id'] = this.laundromatId;
    data['order_time'] = this.orderTime;
    data['order_date'] = this.orderDate;
    data['order_type'] = this.orderType;
    data['order_status'] = this.orderStatus;
    data['driver_assigned_id'] = this.driverAssignedId;
    data['order_price'] = this.orderPrice;
    data['receipt'] = this.receipt;
    data['rating'] = this.rating;
    data['attachment'] = this.attachment;
    data['delivery_code'] = this.deliveryCode;
    data['product_type'] = this.productType;
    data['created_at'] = this.createdAt;
    data['weight'] = this.weight;
    data['pickup_order_time'] = this.pickupOrderTime;
    data['delivery_method'] = this.deliveryMethod;
    data['delivery_type'] = this.deliveryType;
    return data;
  }
}
