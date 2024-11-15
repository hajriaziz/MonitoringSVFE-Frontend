import 'package:intl/intl.dart';

class TransactionModel {
  final int totalTransactions;
  final int successfulTransactions;
  final double successRate;
  final int refusedTransactions;
  final double refusalRate;
  final int mostFrequentRefusalCode;
  final int mostFrequentRefusalCount;
  final String latestUpdate;

  TransactionModel({
    required this.totalTransactions,
    required this.successfulTransactions,
    required this.successRate,
    required this.refusedTransactions,
    required this.refusalRate,
    required this.mostFrequentRefusalCode,
    required this.mostFrequentRefusalCount,
    required this.latestUpdate,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      totalTransactions: json['total_transactions'] ?? 0,
      successfulTransactions: json['successful_transactions'] ?? 0,
      successRate: (json['success_rate'] ?? 0).toDouble(),
      refusedTransactions: json['refused_transactions'] ?? 0,
      refusalRate: (json['refusal_rate'] ?? 0).toDouble(),
      mostFrequentRefusalCode: json['most_frequent_refusal_code'] ?? 0,
      mostFrequentRefusalCount: json['most_frequent_refusal_count'] ?? 0,
      latestUpdate: json['latest_update'] ?? 'N/A',
    );
  }
}

class TransactionTrendData {
  final DateTime timestamp;
  final double successfulTransactions;
  final double refusedTransactions;

  TransactionTrendData({
    required this.timestamp,
    required this.successfulTransactions,
    required this.refusedTransactions,
  });

  // Factory constructor to create the model from API response
  factory TransactionTrendData.fromJson(Map<String, dynamic> json) {
    final timeOnly = json['TIME_ONLY'] as String;

    // Parse only the time component (HH:mm) using DateFormat
    final DateTime timestamp = DateFormat('HH:mm').parse(timeOnly);

    return TransactionTrendData(
      timestamp: timestamp,
      successfulTransactions:
          (json['successful_transactions'] as num).toDouble(),
      refusedTransactions: (json['refused_transactions'] as num).toDouble(),
    );
  }
}
