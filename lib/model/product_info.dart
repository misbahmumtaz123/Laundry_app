// To parse this JSON data, do
//
//     final productInfo = productInfoFromJson(jsonString);

import 'dart:convert';

ProductInfo productInfoFromJson(String str) =>
    ProductInfo.fromJson(json.decode(str));

String productInfoToJson(ProductInfo data) => json.encode(data.toJson());

class ProductInfo {
  String responseCode;
  String result;
  String responseMsg;
  ProductData productData;

  ProductInfo({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
    required this.productData,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
        productData: ProductData.fromJson(json["ProductData"]),
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
        "ProductData": productData.toJson(),
      };
}

class ProductData {
  String id;
  String title;
  String productDescription;
  String img;
  List<ProductInfoElement> productInfo;

  ProductData({
    required this.id,
    required this.title,
    required this.productDescription,
    required this.img,
    required this.productInfo,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"],
        title: json["title"],
        productDescription: json["product_description"],
        img: json["img"],
        productInfo: List<ProductInfoElement>.from(
            json["product_info"].map((x) => ProductInfoElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "product_description": productDescription,
        "img": img,
        "product_info": List<dynamic>.from(productInfo.map((x) => x.toJson())),
      };
}

class ProductInfoElement {
  String attributeId;
  String productId;
  String normalPrice;
  String title;
  String productDiscount;
  String productOutStock;

  ProductInfoElement({
    required this.attributeId,
    required this.productId,
    required this.normalPrice,
    required this.title,
    required this.productDiscount,
    required this.productOutStock,
  });

  factory ProductInfoElement.fromJson(Map<String, dynamic> json) =>
      ProductInfoElement(
        attributeId: json["attribute_id"],
        productId: json["product_id"],
        normalPrice: json["normal_price"],
        title: json["title"],
        productDiscount: json["product_discount"],
        productOutStock: json["Product_Out_Stock"],
      );

  Map<String, dynamic> toJson() => {
        "attribute_id": attributeId,
        "product_id": productId,
        "normal_price": normalPrice,
        "title": title,
        "product_discount": productDiscount,
        "Product_Out_Stock": productOutStock,
      };
}
