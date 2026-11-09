class SensorReading {
  const SensorReading({
    required this.sensorId,
    required this.value,
    required this.recordedAt,
    this.qualityFlag = 'valid',
  });

  final String sensorId;
  final double value;
  final DateTime recordedAt;
  final String qualityFlag;

  factory SensorReading.fromJson(Map<String, dynamic> json) {
    return SensorReading(
      sensorId: json['sensor_id'] as String,
      value: (json['value'] as num).toDouble(),
      recordedAt: DateTime.parse(json['recorded_at'] as String),
      qualityFlag: json['quality_flag'] as String? ?? 'valid',
    );
  }
}
