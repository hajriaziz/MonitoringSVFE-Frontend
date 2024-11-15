class TerminalDistributionModel {
  final int dab; // Represents terminal 1 (DAB)
  final int tpe; // Represents terminal 2 (TPE)
  final int eCommerce; // Represents terminal 8 (E-commerce)
  final String latestUpdate;

  TerminalDistributionModel({
    required this.dab,
    required this.tpe,
    required this.eCommerce,
    required this.latestUpdate,
  });

// Factory constructor to parse JSON response
  factory TerminalDistributionModel.fromJson(Map<String, dynamic> json) {
    final terminalDistribution =
        json['terminal_distribution'] as Map<String, dynamic>?;

    return TerminalDistributionModel(
      dab: terminalDistribution?['1'] ?? 0,
      tpe: terminalDistribution?['2'] ?? 0,
      eCommerce: terminalDistribution?['8'] ?? 0,
      latestUpdate: json['latest_update'] ?? 'N/A',
    );
  }
}
