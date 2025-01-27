class ProfileModel {
  String? username;
  String? phone;
  String? department;
  String? imagePath; // Update the field name to match the backend response

  ProfileModel({
    this.username,
    this.phone,
    this.department,
    this.imagePath,
  });

  // Method to convert JSON to `ProfileModel`
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json['username'],
      phone: json['phone'],
      department: json['department'],
      imagePath: json['image'], // Map the new field
    );
  }

  // Method to convert `ProfileModel` to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'phone': phone,
      'department': department,
      'image_path': imagePath, // Match the backend field
    };
  }
}
