// class NewOrder {
//   String? responseCode;
//   String? result;
//   String? title;
//   String? orderQId;
//   String? orderType;
//   String? orderTime;
//
//   NewOrder({
//     this.responseCode,
//     this.result,
//     this.title,
//     this.orderQId,
//     this.orderType,
//     this.orderTime,
//   });
//
//   NewOrder.fromJson(Map<String, dynamic> json) {
//     responseCode = json['ResponseCode'];
//     result = json['Result'];
//     title = json['title'];
//     orderQId = json['order_q_id'];
//     orderType = json['order_type'];
//     orderTime = json['order_time'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['ResponseCode'] = responseCode;
//     data['Result'] = result;
//     data['title'] = title;
//     data['order_q_id'] = orderQId;
//     data['order_type'] = orderType;
//     data['order_time'] = orderTime;
//     return data;
//   }
// }