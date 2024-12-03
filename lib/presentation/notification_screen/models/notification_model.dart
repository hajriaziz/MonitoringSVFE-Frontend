class NotificationModel {
  final int id;
  final String message;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.message,
    required this.createdAt,
  });

  // Convertir un JSON en instance de NotificationModel
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Convertir une instance de NotificationModel en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
