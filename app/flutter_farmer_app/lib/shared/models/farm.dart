class Farm {
  const Farm({
    required this.id,
    required this.userId,
    required this.name,
    this.address,
    this.area,
    this.areaUnit,
  });

  final String id;
  final String userId;
  final String name;
  final String? address;
  final double? area;
  final String? areaUnit;

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String? ?? '',
      address: json['address'] as String?,
      area: (json['area'] as num?)?.toDouble(),
      areaUnit: json['area_unit'] as String?,
    );
  }
}
