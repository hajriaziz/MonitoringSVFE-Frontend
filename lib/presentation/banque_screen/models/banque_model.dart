class RefusalRatePerIssuer {
  final Map<String, double> rates;

  RefusalRatePerIssuer({required this.rates});

  factory RefusalRatePerIssuer.fromJson(Map<String, dynamic> json) {
    return RefusalRatePerIssuer(
      rates: Map<String, double>.from(json['refusal_rate_per_issuer']),
    );
  }

  where(bool Function(dynamic item) param0) {}
}
class KPIsResponse {
  final int totalTransactions;
  final int successfulTransactions;
  final double successRate;
  final int refusedTransactions;
  final double refusalRate;
  final int mostFrequentRefusalCode;
  final int mostFrequentRefusalCount;

  KPIsResponse({
    required this.totalTransactions,
    required this.successfulTransactions,
    required this.successRate,
    required this.refusedTransactions,
    required this.refusalRate,
    required this.mostFrequentRefusalCode,
    required this.mostFrequentRefusalCount,
  });

  factory KPIsResponse.fromJson(Map<String, dynamic> json) {
    return KPIsResponse(
      totalTransactions: json['total_transactions'],
      successfulTransactions: json['successful_transactions'],
      successRate: json['success_rate'],
      refusedTransactions: json['refused_transactions'],
      refusalRate: json['refusal_rate'],
      mostFrequentRefusalCode: json['most_frequent_refusal_code'],
      mostFrequentRefusalCount: json['most_frequent_refusal_count'],
    );
  }
}
