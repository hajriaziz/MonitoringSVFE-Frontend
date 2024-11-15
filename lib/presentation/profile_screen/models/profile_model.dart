class ProfileModel {
  String? username;
  String? phone;
  String? email;
  String? image;

  ProfileModel({
    this.username,
    this.phone,
    this.email,
    this.image,
  });

  // Méthode pour convertir un JSON en `ProfileModel`
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
    );
  }

  // Méthode pour convertir un `ProfileModel` en JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'phone': phone,
      'email': email,
      'image': image,
    };
  }
}
