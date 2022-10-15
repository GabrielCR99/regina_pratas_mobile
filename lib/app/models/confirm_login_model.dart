import 'dart:convert';

class ConfirmLoginModel {
  final String accessToken;
  final String refreshToken;

  const ConfirmLoginModel({
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toMap() => {
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };

  factory ConfirmLoginModel.fromMap(Map<String, dynamic> map) =>
      ConfirmLoginModel(
        accessToken: map['access_token'] ?? '',
        refreshToken: map['refresh_token'] ?? '',
      );

  String toJson() => json.encode(toMap());

  factory ConfirmLoginModel.fromJson(String source) =>
      ConfirmLoginModel.fromMap(json.decode(source));
}
