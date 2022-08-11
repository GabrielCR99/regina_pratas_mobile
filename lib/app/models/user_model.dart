import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String phone;
  final String about;
  final String registerType;
  final String userRole;
  final String imageAvatar;

  const UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.about,
    required this.registerType,
    required this.userRole,
    required this.imageAvatar,
  });

  const UserModel.empty()
      : name = '',
        email = '',
        phone = '',
        about = '',
        registerType = '',
        userRole = '',
        imageAvatar = '';

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'about': about,
      'register_type': registerType,
      'user_role': userRole,
      'image_avatar': imageAvatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['nome'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      about: map['sobre'] ?? '',
      registerType: map['register_type'] ?? '',
      userRole: map['user_role'] ?? '',
      imageAvatar: map['image_avatar'] ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source));
}
