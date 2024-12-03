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
  final String latestUpdate;
  final Map<String, double> criticalCodeRates; // Nouvelle propriété

  KPIsResponse({
    required this.totalTransactions,
    required this.successfulTransactions,
    required this.successRate,
    required this.refusedTransactions,
    required this.refusalRate,
    required this.mostFrequentRefusalCode,
    required this.mostFrequentRefusalCount,
    required this.latestUpdate,
    required this.criticalCodeRates, // Initialisation de la nouvelle propriété
  });

  factory KPIsResponse.fromJson(Map<String, dynamic> json) {
    Map<String, double> criticalRates = {};

    // Collect manually known critical code rates
    //List<String> criticalKeys = ['rate_of_code_802', 'rate_of_code_803'];
    List<String> criticalKeys = ['rate_of_code_802', 'rate_of_code_803', 'rate_of_code_840'];

    for (var key in criticalKeys) {
      if (json[key] != null) {
        criticalRates[key.split('_').last] = json[key];
      }
    }

    return KPIsResponse(
      totalTransactions: json['total_transactions'],
      successfulTransactions: json['successful_transactions'],
      successRate: json['success_rate'],
      refusedTransactions: json['refused_transactions'],
      refusalRate: json['refusal_rate'],
      mostFrequentRefusalCode: json['most_frequent_refusal_code'],
      mostFrequentRefusalCount: json['most_frequent_refusal_count'],
      latestUpdate: json['latest_update'] ?? 'N/A',
      criticalCodeRates: criticalRates, // Correct assignment
    );
  }
}
