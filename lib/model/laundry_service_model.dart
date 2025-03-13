class LaundryService {
  final String id;
  final String serviceName;
  final String createdAt;

  LaundryService({
    required this.id,
    required this.serviceName,
    required this.createdAt,
  });

  factory LaundryService.fromJson(Map<String, dynamic> json) {
    return LaundryService(
      id: json['id'],
      serviceName: json['service_name'],
      createdAt: json['created_at'],
    );
  }
}
