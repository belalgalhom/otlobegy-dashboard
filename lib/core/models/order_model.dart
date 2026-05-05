class OrderModel {
  final String id;
  final String status;
  final double totalAmount;
  final String customerName;
  final String vendorName;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.customerName,
    required this.vendorName,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      status: json['status'],
      totalAmount: (json['totalAmount'] as num).toDouble(),
      customerName: json['customer']?['user']?['name'] ?? 'Unknown',
      vendorName: json['vendor']?['storeName'] ?? 'Unknown',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
