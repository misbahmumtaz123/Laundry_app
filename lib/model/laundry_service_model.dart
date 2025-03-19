class LaundryService {
  final String id;
  final String serviceName;
  final String createdAt;

  LaundryService({
    required this.id,
    required this.serviceName,
    required this.createdAt,
  });

  // Factory constructor to parse JSON data
  factory LaundryService.fromJson(Map<String, dynamic> json) {
    return LaundryService(
      id: json['id'] ?? '',
      serviceName: json['service_name'] ?? 'Unknown Service',
      createdAt: json['created_at'] ?? '',
    );
  }
}

class LaundryServiceResponse {
  final String responseCode;
  final bool result;
  final String responseMsg;
  final List<LaundryService> services;

  LaundryServiceResponse({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
    required this.services,
  });

  // Factory constructor to parse API response
  factory LaundryServiceResponse.fromJson(Map<String, dynamic> json) {
    return LaundryServiceResponse(
      responseCode: json['ResponseCode'] ?? '',
      result: json['Result'].toString().toLowerCase() == "true",
      responseMsg: json['ResponseMsg'] ?? '',
      services: (json['Services'] as List<dynamic>?)
          ?.map((item) => LaundryService.fromJson(item))
          .toList() ??
          [],
    );
  }
}
