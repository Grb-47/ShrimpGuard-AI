class RiskReport {
  const RiskReport({
    required this.id,
    required this.pondId,
    required this.riskLevel,
    required this.summary,
    required this.generatedAt,
    this.riskScore,
    this.explanationBn,
  });

  final String id;
  final String pondId;
  final String riskLevel;
  final String summary;
  final DateTime generatedAt;
  final double? riskScore;
  final String? explanationBn;

  factory RiskReport.fromJson(Map<String, dynamic> json) {
    return RiskReport(
      id: json['id'] as String,
      pondId: json['pond_id'] as String,
      riskLevel: json['risk_level'] as String? ?? 'unknown',
      summary: json['summary'] as String? ?? '',
      generatedAt: DateTime.parse(json['generated_at'] as String),
      riskScore: (json['risk_score'] as num?)?.toDouble(),
      explanationBn: json['gemini_explanation'] as String?,
    );
  }
}
