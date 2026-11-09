class Device {
  const Device({
    required this.id,
    required this.pondId,
    required this.deviceSerial,
    this.name,
    this.status = 'unknown',
  });

  final String id;
  final String pondId;
  final String deviceSerial;
  final String? name;
  final String status;

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'] as String,
      pondId: json['pond_id'] as String,
      deviceSerial: json['device_serial'] as String? ?? '',
      name: json['name'] as String?,
      status: json['status'] as String? ?? 'unknown',
    );
  }
}
