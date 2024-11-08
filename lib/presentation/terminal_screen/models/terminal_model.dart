class TerminalDistributionModel {
  final int dab; // Represents terminal 1 (DAB)
  final int tpe; // Represents terminal 2 (TPE)
  final int eCommerce; // Represents terminal 8 (E-commerce)

  TerminalDistributionModel({
    required this.dab,
    required this.tpe,
    required this.eCommerce,
  });

  // Factory constructor to parse JSON response
  factory TerminalDistributionModel.fromJson(Map<String, dynamic> json) {
    return TerminalDistributionModel(
      dab: json['1'] ?? 0,
      tpe: json['2'] ?? 0,
      eCommerce: json['8'] ?? 0,
    );
  }
}
