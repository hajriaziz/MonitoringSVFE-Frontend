class SystemStatusModel {
  final String systemStatus;
  final bool isStable;


  SystemStatusModel({required this.systemStatus , required this.isStable});

  factory SystemStatusModel.fromJson(Map<String, dynamic> json) {
    return SystemStatusModel(
      systemStatus: json['system_status'] as String,
      isStable: json['is_stable'] as bool, // Assurez-vous que ce champ existe
    );
  }
}
