class Pond {
  const Pond({
    required this.id,
    required this.farmId,
    required this.name,
    this.status = 'active',
  });

  final String id;
  final String farmId;
  final String name;
  final String status;

  factory Pond.fromJson(Map<String, dynamic> json) {
    return Pond(
      id: json['id'] as String,
      farmId: json['farm_id'] as String,
      name: json['name'] as String? ?? '',
      status: json['status'] as String? ?? 'active',
    );
  }
}
