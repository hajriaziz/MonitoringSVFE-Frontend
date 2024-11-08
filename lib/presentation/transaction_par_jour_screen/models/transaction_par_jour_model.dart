import 'package:intl/intl.dart';

class Transaction_HistModel {
  final int totalTransactions;
  final int successfulTransactions;
  final double successRate;
  final int refusedTransactions;
  final double refusalRate;

  Transaction_HistModel({
    required this.totalTransactions,
    required this.successfulTransactions,
    required this.successRate,
    required this.refusedTransactions,
    required this.refusalRate,
  });

  factory Transaction_HistModel.fromJson(Map<String, dynamic> json) {
    return Transaction_HistModel(
      totalTransactions: json['total_transactions'] ?? 0,
      successfulTransactions: json['successful_transactions'] ?? 0,
      successRate: (json['success_rate'] ?? 0).toDouble(),
      refusedTransactions: json['refused_transactions'] ?? 0,
      refusalRate: (json['refusal_rate'] ?? 0).toDouble(),
    );
  }
}

class TransactionTrendDataHist {
  final DateTime timestamp;
  final double successfulTransactions;
  final double refusedTransactions;

  TransactionTrendDataHist({
    required this.timestamp,
    required this.successfulTransactions,
    required this.refusedTransactions,
  });

  // Factory constructor to create the model from API response
  factory TransactionTrendDataHist.fromJson(Map<String, dynamic> json) {
    final timeOnly = json['TIME_ONLY'] as String;

    // Parse only the time component (HH:mm) using DateFormat
    final DateTime timestamp = DateFormat('HH:mm').parse(timeOnly);

    return TransactionTrendDataHist(
      timestamp: timestamp,
      successfulTransactions:
          (json['successful_transactions'] as num).toDouble(),
      refusedTransactions: (json['refused_transactions'] as num).toDouble(),
    );
  }
}
