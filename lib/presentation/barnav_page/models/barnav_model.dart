class SystemStatusModel {
  final String systemStatus;

  SystemStatusModel({required this.systemStatus});

  factory SystemStatusModel.fromJson(Map<String, dynamic> json) {
    return SystemStatusModel(
      systemStatus: json['system_status'] as String, // Assurez-vous que ce champ existe
    );
  }
}
